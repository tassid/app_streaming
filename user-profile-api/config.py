from flask_sqlalchemy import SQLAlchemy
import firebase_admin
from firebase_admin import credentials

# Initialize SQLAlchemy
db = SQLAlchemy()

class Config:
    # Database configuration
    SQLALCHEMY_DATABASE_URI = 'sqlite:///user_profiles.db'
    SQLALCHEMY_TRACK_MODIFICATIONS = False

    # Firebase Admin SDK configuration
    cred = credentials.Certificate("firebase-adminsdk.json")
    firebase_admin.initialize_app(cred)
