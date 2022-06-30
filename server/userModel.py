from flask_sqlalchemy import SQLAlchemy
from werkzeug.security import generate_password_hash, check_password_hash
db = SQLAlchemy()


class UserModel(db.Model):
    ___tablename__ = 'users'
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(80), unique=True, index = True)
    password = db.Column(db.String(128))

    def set_password(self, password):
        self.password_hash = generate_password_hash(password)

    def check_password(self, password):
        return check_password_hash(self.password_hash, password)

    def saveToDatabase(self):
        db.session.add(self)
        db.session.commit()

    def __init__(self, username, password):
        self.username = username
        self.password = self.set_password(password)