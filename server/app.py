from flask import Flask
from werkzeug.security import generate_password_hash, check_password_hash
from flask import make_response
from flask import request
import requests
from flask_sqlalchemy import SQLAlchemy
from data import database







app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] =\
        database.url
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db = SQLAlchemy(app)


class UserModel(db.Model):
    ___tablename__ = 'users'
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(80), unique=True, index=True)
    password = db.Column(db.String(128))

    def get_password(self, password):
        return generate_password_hash(password)

    def check_password(self, password):
        return check_password_hash(self.password_hash, password)

    def saveToDatabase(self):
        db.session.add(self)
        db.session.commit()

    def __init__(self, username, password):
        self.username = username
        self.password = self.get_password(password)


@app.route('/', methods=['GET', 'POST'])
def handshake():
    return "HellO!"

@app.route('/registration',methods=['POST'])
def registration():
    request.get_json(force=True)
    name = request.json['name']
    password = request.json['password']
    print(name)
    print(password)
    user = UserModel(username = name, password = password)
    user.saveToDatabase()
    return 'ok!'





if __name__ == '__main__':
    app.run()
