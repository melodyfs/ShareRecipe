from flask import Flask, request, make_response
from flask_restful import Resource, Api
from pymongo import MongoClient
from utils.mongo_json_encoder import JSONEncoder
from bson.objectid import ObjectId
import bcrypt
import pdb


app = Flask(__name__)
mongo = MongoClient('localhost', 27017)
# mongo = MongoClient('mongodb://melodyfs:Melody0116@ds015335.mlab.com:15335/trip_planner_development')
app.db = mongo.grocery_development
api = Api(app)

def auth_validation(email, password):
    user_collection = app.db.users
    myUser = user_collection.find_one({'email': email})
    user_password = myUser['password']

    if myUser is None:
        return ({"error": "Email not found"}, 404, None)
    else:
        encodedPassword = password.encode('utf-8')
        if bcrypt.hashpw(encodedPassword, user_password) == user_password:
            return True
        else:
            return False

def auth_function(func):
    def wrapper(*args, **kwargs):
        auth = request.authorization
        if not auth_validation(auth.username, auth.password):
            return ({'error': 'Could not verify your credentials'}, 401,
                    {'WWW-Authenticate': 'Basic realm="Login Required"'})
        return func(*args, **kwargs)
    return wrapper



class User(Resource):

    def post(self):
        new_user = request.json
        user_collection = app.db.users

        if 'email' in new_user and 'password' in new_user:
            user = user_collection.find_one({'email': new_user.get('email')})
            if user:
                 return ({'error': 'email already exists'}, 409, None)
            else:

                password = new_user.get('password')
                app.bcrypt_rounds = 12
                # Convert password to utf-8 string
                encodedPassword = password.encode('utf-8')
                hashed = bcrypt.hashpw(encodedPassword, bcrypt.gensalt(app.bcrypt_rounds))
                result = user_collection.insert({'email': new_user.get('email'),
                                                 'password': hashed})

                user.pop(password)

                return (user, 201, None)
        else:
            return ({"error": "Can't create user"}, 400, None)

    @auth_function
    def get(self):
        user_collection = app.db.users
        email = request.args.get("email")
        myUser = user_collection.find_one({'email': email})

        if myUser is None:
            return ({"error": "Email not found"}, 404, None)
        else:
            myUser.pop('password')
            return (myUser, 200, None)


    @auth_function
    def patch(self):
        email = request.args.get('email')

        update_ = request.json
        # new_name = update_.get('name')
        new_password = update_.get('password')
        new_email = update_.get('email')
        user_collection = app.db.users

        if email is not None:
            user = user_collection.find_one({'email': email})
            if new_email:
                 user["email"] = new_email
            if new_password:
                user['password'] = new_password
            user_collection.save(user)

            return (user, 200, None)
        else:
            return ({"error": "Can't modify the user"}, 404, None)

    @auth_function
    def delete(self):
        user_collection = app.db.users
        email = request.args.get('email')
        myUser = user_collection.delete_one({'email': email})

        if myUser is None:
            return ({"error": "Can't modify the user"}, 404, None)
        else:
            return myUser


class Recipe(Resource):

    def post(self):
        new_recipe = request.json
        email = request.args.get('email')
        name = new_recipe.get('recipeName')
        ingredientLines = new_recipe.get('ingredientLines')
        url = new_recipe.get('url')
        imageURL = new_recipe.get('imageURL')

        target_recipeName = request.args.get('recipeName')
        ingredientOptions = new_recipe.get('options')
        note = new_recipe.get('note')

        recipe_col = app.db.recipes

        # check whether the user has added a note before
        check_note = recipe_col.find({'emai': email, 'recipe.recipeName.notes': {'$exists':True}})
        # add user's notes for certain recipe
        if check_note and target_recipeName and ingredientOptions and note:
            # pdb.set_trace()
            result = recipe_col.update(
                {"email": email, 'recipes.recipeName': target_recipeName},
                {'$push':
                    {"recipes.$.notes": {
                                'ingredientOptions': ingredientOptions,
                                'note': note
                            }

                    }
                }
            )

            return (result, 200, None)
        # if the recipe container (array) exists, insert the new recipe object
        check_recipe = recipe_col.find({'email': email,'recipes.recipeName': {'$exists':True}})
        if check_recipe:
            result = recipe_col.update_one(
                {"email": email},
                {'$addToSet':
                    {'recipes': {
                        "recipeName": name,
    	                "ingredientLines": ingredientLines,
    	                 "url": url,
    	                 "imageURL": imageURL
                         }
                    }
                }

            )
            return (result, 200, None)

        # for brand new user
        result = recipe_col.insert(
            {  "email": email,
                "recipes": [
                 {
                   "recipeName": name,
                   "ingredientLines": ingredientLines,
                   "url": url,
                   "imageURL": imageURL,
                   'notes':[]
                 }]
            })
        return (result, 200, None)


        # return (result, 201, None)

    def get(self):
        email = request.args.get('email')
        name = request.args.get('recipeName')
        recipe_col = app.db.recipes

        target = recipe_col.find_one({'email': email,'recipes.recipeName': name})

        return (target, 200, None)

    def patch(self):
        new_recipe = request.json
        email = request.args.get('email')
        name = request.args.get('recipeName')
        recipe_col = app.db.recipes

        new_name = new_recipe.get('recipeName')
        new_ingredient = new_recipe.get('ingredientLines')
        new_url = new_recipe.get('url')
        new_image = new_recipe.get('imageURL')

        target = recipe_col.find_one({'email': email,'recipes.recipeName': name})
        # recipe = target['recipes']

        if new_name:
            result = recipe_col.update(
                {'email': email,'recipes.recipeName': name},
                {'$set': {'recipes.$.recipeName': new_name}}
                )
            return (result, 200, None)
        if new_ingredient:
            result = recipe_col.update(
                {'email': email,'recipes.recipeName': name},
                {'$set': {'recipes.$.ingredientLines': new_ingredient}}
                )
            return (result, 200, None)
        if new_url:
            result = recipe_col.update(
                {'email': email,'recipes.recipeName': name},
                {'$set': {'recipes.$.url': new_url}}
                )
            return (result, 200, None)
        if new_image:
            result = recipe_col.update(
                {'email': email,'recipes.recipeName': name},
                {'$set': {'recipes.$.imageURL': new_image}}
                )
            return (result, 200, None)

        else:
            return ({"error": "Can't modify the recipe"}, 404, None)


    def delete(self):
        recipe_col = app.db.recipes
        recipe = request.args.get('recipeName')
        email = request.args.get('email')

        target = recipe_col.update({'email': email,'recipes.recipeName': recipe},
                                    {'$pull': {
                                        'recipes':{
                                        'recipeName': recipe}}
                                     })

        return (target, 200, None)

class Global_Recipes(Resource):

    def post(self):
        new_recipe = request.json
        email = request.args.get('email')
        name = new_recipe.get('recipeName')

        ingredientOptions = new_recipe.get('options')
        note = new_recipe.get('note')

        global_recipe_col = app.db.global_recipes

        check_recipe = global_recipe_col.find_one({'recipeName': name})
        # import pdb; pdb.set_trace()
        if check_recipe:
            result = global_recipe_col.update_one(
                {'recipeName': name},
                {'$addToSet':
                    {"options": {
                        'email': email,
                        'ingredientOptions': ingredientOptions,
                        'note': note
                        }

                    }
                }
            )
            return (result, 201, None)

        result = global_recipe_col.insert(
            { "recipeName": name,
                "options": [
                 {
                    'email': email,
                    'ingredientOptions': ingredientOptions,
                    'note': note
                 }]
            })

        return (result, 200, None)


##api routes
api.add_resource(User,'/users')
api.add_resource(Recipe,'/recipes')
api.add_resource(Global_Recipes, '/global_recipes')

#  Custom JSON serializer for flask_restful
@api.representation('application/json')
def output_json(data, code, headers=None):
    resp = make_response(JSONEncoder().encode(data), code)
    resp.headers.extend(headers or {})
    return resp

if __name__ == '__main__':
    app.config['TRAP_BAD_REQUEST_ERRORS'] = True
    app.run(debug=True)
