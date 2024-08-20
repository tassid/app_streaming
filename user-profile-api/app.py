from flask import Flask, jsonify, request
from models.user import User
from models.profile import Profile
from models.movie import Movie
from config import db
from firebase_admin import auth
from flasgger import Swagger, swag_from
import logging
from functools import wraps

logging.basicConfig(level=logging.DEBUG)

app = Flask(__name__)

swagger_config = {
    "headers": [],
    "specs": [
        {
            "endpoint": 'apispec_1',
            "route": '/apispec_1.json',
            "rule_filter": lambda rule: True,  # all in
            "model_filter": lambda tag: True,  # all in
        }
    ],
    "static_url_path": "/flasgger_static",
    "swagger_ui": True,
    "specs_route": "/swagger/"
}

swagger = Swagger(app, config=swagger_config)

app.config.from_object('config.Config')
db.init_app(app)

# Ensure the database is created
with app.app_context():
    db.create_all()

# Authentication middleware
def firebase_auth_required(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        id_token = request.headers.get('Authorization')
        if not id_token:
            return jsonify({"error": "Authorization token required"}), 401

        try:
            id_token = id_token.replace("Bearer ", "")
            decoded_token = auth.verify_id_token(id_token)
            request.user = decoded_token
        except Exception as e:
            return jsonify({"error": str(e)}), 401

        return f(*args, **kwargs)
    return decorated_function

# Example Firebase Authentication Route
@app.route('/verify_token', methods=['POST'])
@swag_from({
    'responses': {
        200: {
            'description': 'Token verification successful',
            'examples': {
                'application/json': {
                    "message": "Token is valid",
                    "uid": "user_id"
                }
            }
        },
        401: {
            'description': 'Token verification failed'
        }
    }
})
def verify_token():
    id_token = request.json.get('id_token')
    try:
        decoded_token = auth.verify_id_token(id_token)
        uid = decoded_token['uid']
        return jsonify({"message": "Token is valid", "uid": uid})
    except Exception as e:
        return jsonify({"error": str(e)}), 401

# Create a new user profile
@app.route('/users/<int:user_id>/profiles', methods=['POST'])
@firebase_auth_required
@swag_from({
    'parameters': [
        {
            'name': 'user_id',
            'in': 'path',
            'type': 'integer',
            'required': True,
            'description': 'ID of the user'
        },
        {
            'name': 'profile',
            'in': 'body',
            'schema': {
                'properties': {
                    'name': {
                        'type': 'string'
                    },
                    'avatarUrl': {
                        'type': 'string'
                    },
                    'email': {
                        'type': 'string'  # New email field
                    },
                    'color': {
                        'type': 'string'  # New color field
                    }
                }
            },
            'required': True,
            'description': 'Profile details'
        }
    ],
    'responses': {
        201: {
            'description': 'Profile created successfully'
        }
    }
})
def create_profile(user_id):
    data = request.json
    if not data or not data.get('name'):
        return jsonify({"error": "Missing 'name' in request"}), 400
    
    try:
        new_profile = Profile(
            name=data['name'],
            avatar_url=data.get('avatarUrl'),
            email=data.get('email'),  # Handle email input
            color=data.get('color', '#FFFFFF'),  # Handle color input, default to white
            user_id=user_id
        )
        db.session.add(new_profile)
        db.session.commit()
        return jsonify(new_profile.to_dict()), 201
    except Exception as e:
        db.session.rollback()
        logging.error(f"Error creating profile: {e}")
        return jsonify({"error": "An error occurred while creating the profile"}), 500

# Get all profiles for a user
@app.route('/users/<int:user_id>/profiles', methods=['GET'])
@firebase_auth_required
@swag_from({
    'parameters': [
        {
            'name': 'user_id',
            'in': 'path',
            'type': 'integer',
            'required': True,
            'description': 'ID of the user'
        }
    ],
    'responses': {
        200: {
            'description': 'A list of user profiles',
            'examples': {
                'application/json': [
                    {
                        "id": 1,
                        "name": "Profile 1",
                        "avatarUrl": "https://example.com/avatar.jpg",
                        "color": "#ffffff"
                    }
                ]
            }
        }
    }
})
def get_profiles(user_id):
    try:
        profiles = Profile.query.filter_by(user_id=user_id).all()
        return jsonify([profile.to_dict() for profile in profiles])
    except Exception as e:
        logging.error(f"Error fetching profiles: {e}")
        return jsonify({"error": "An error occurred while fetching profiles"}), 500

# Add liked/disliked movies to a profile
@app.route('/profiles/<int:profile_id>/movies', methods=['POST'])
@firebase_auth_required
@swag_from({
    'parameters': [
        {
            'name': 'profile_id',
            'in': 'path',
            'type': 'integer',
            'required': True,
            'description': 'ID of the profile'
        },
        {
            'name': 'movie',
            'in': 'body',
            'schema': {
                'properties': {
                    'title': {
                        'type': 'string'
                    },
                    'liked': {
                        'type': 'boolean'
                    }
                }
            },
            'required': True,
            'description': 'Movie details'
        }
    ],
    'responses': {
        201: {
            'description': 'Movie added successfully'
        }
    }
})
def add_movie(profile_id):
    data = request.json
    if not data or not data.get('title') or not isinstance(data.get('liked'), bool):
        return jsonify({"error": "Invalid movie data"}), 400
    
    try:
        movie = Movie(title=data['title'], liked=data['liked'], profile_id=profile_id)
        db.session.add(movie)
        db.session.commit()
        return jsonify(movie.to_dict()), 201
    except Exception as e:
        db.session.rollback()
        logging.error(f"Error adding movie: {e}")
        return jsonify({"error": "An error occurred while adding the movie"}), 500

# Associate email with a profile
@app.route('/profiles/<int:profile_id>/associate_email', methods=['POST'])
@firebase_auth_required
@swag_from({
    'parameters': [
        {
            'name': 'profile_id',
            'in': 'path',
            'type': 'integer',
            'required': True,
            'description': 'ID of the profile'
        },
        {
            'name': 'email',
            'in': 'body',
            'schema': {
                'properties': {
                    'email': {
                        'type': 'string'
                    }
                }
            },
            'required': True,
            'description': 'Email to associate with the profile'
        }
    ],
    'responses': {
        200: {
            'description': 'Email associated successfully'
        },
        400: {
            'description': 'Bad Request'
        },
        404: {
            'description': 'Profile not found'
        }
    }
})
def associate_email(profile_id):
    data = request.json
    email = data.get('email')

    if not email:
        return jsonify({"error": "Email is required"}), 400

    try:
        profile = Profile.query.get(profile_id)
        if not profile:
            return jsonify({"error": "Profile not found"}), 404

        profile.email = email
        db.session.commit()

        return jsonify({"message": "Email associated successfully", "profile": profile.to_dict()}), 200
    except Exception as e:
        db.session.rollback()
        logging.error(f"Error associating email: {e}")
        return jsonify({"error": str(e)}), 500

# Get profile settings
@app.route('/profiles/<int:profile_id>/settings', methods=['GET'])
@firebase_auth_required
@swag_from({
    'parameters': [
        {
            'name': 'profile_id',
            'in': 'path',
            'type': 'integer',
            'required': True,
            'description': 'ID of the profile'
        }
    ],
    'responses': {
        200: {
            'description': 'Profile settings retrieved successfully',
            'examples': {
                'application/json': {
                    'settings': {
                        'theme': 'dark',
                        'notifications': True
                    }
                }
            }
        },
        404: {
            'description': 'Profile not found'
        }
    }
})
def get_profile_settings(profile_id):
    try:
        profile = Profile.query.get(profile_id)
        if not profile:
            return jsonify({"error": "Profile not found"}), 404

        return jsonify({"settings": profile.settings}), 200
    except Exception as e:
        logging.error(f"Error fetching settings: {e}")
        return jsonify({"error": "An error occurred while fetching settings"}), 500

# Verify or create profile based on email
@app.route('/verify_or_create_profile', methods=['POST'])
@firebase_auth_required
@swag_from({
    'parameters': [
        {
            'name': 'email',
            'in': 'body',
            'schema': {
                'properties': {
                    'email': {
                        'type': 'string'
                    }
                }
            },
            'required': True,
            'description': 'Email of the user'
        }
    ],
    'responses': {
        200: {
            'description': 'Profile verified or created successfully'
        },
        400: {
            'description': 'Bad Request'
        }
    }
})
def verify_or_create_profile():
    data = request.json
    email = data.get('email')

    if not email:
        return jsonify({"error": "Email is required"}), 400

    try:
        # Check if the profile already exists
        profile = Profile.query.filter_by(email=email).first()
        if not profile:
            # If the profile doesn't exist, create a new one
            profile = Profile(email=email, name="Default Name", color="#FFFFFF")
            db.session.add(profile)
            db.session.commit()

        return jsonify({"message": "Profile verified/created", "profile": profile.to_dict()}), 200
    except Exception as e:
        db.session.rollback()
        logging.error(f"Error verifying/creating profile: {e}")
        return jsonify({"error": str(e)}), 500

# Home route
@app.route('/')
def home():
    return "Hello, Flask!"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
