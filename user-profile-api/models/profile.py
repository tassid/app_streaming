from config import db

class Profile(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(80), nullable=False)
    avatar_url = db.Column(db.String(200), nullable=True)
    color = db.Column(db.String(7), nullable=False)
    email = db.Column(db.String(100), unique=True, nullable=False)  # Email associated with the profile
    settings = db.Column(db.JSON, nullable=True)  # Profile settings stored as JSON
    user_id = db.Column(db.Integer, db.ForeignKey('user.id'), nullable=False)
    movies = db.relationship('Movie', backref='profile', lazy=True)

    def to_dict(self):
        return {
            "id": self.id,
            "name": self.name,
            "avatarUrl": self.avatar_url,
            "color": self.color,
            "email": self.email,  # Include email in the dictionary
            "settings": self.settings  # Include settings in the dictionary
        }
