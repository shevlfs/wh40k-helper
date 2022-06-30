from flask import Flask
from werkzeug.security import generate_password_hash, check_password_hash
from flask import make_response
from flask import request
from userModel import UserModel
from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()
app = Flask(__name__)


@app.route('/', methods=['GET', 'POST'])
def handshake():
    return "HellO!"


if __name__ == '__main__':
    app.run()
