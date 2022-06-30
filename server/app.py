from flask import Flask
from werkzeug.security import generate_password_hash, check_password_hash
from flask import make_response
from flask import request, flash
import requests
from flask_sqlalchemy import SQLAlchemy
from data import database, mail, secretKey
import re
from flask_mail import Mail, Message
from itsdangerous import URLSafeTimedSerializer
from flask_login import login_user, login_required

app = Flask(__name__)
mail_settings = {
    "MAIL_SERVER": 'smtp.gmail.com',
    "MAIL_PORT": 465,
    "MAIL_USE_TLS": False,
    "MAIL_USE_SSL": True,
    "MAIL_USERNAME": mail.login,
    "MAIL_PASSWORD": mail.password
}
app.config.update(mail_settings)
mail = Mail(app)
app.config['SQLALCHEMY_DATABASE_URI'] =\
        database.url
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['SECRET_KEY'] = secretKey.secret
app.config['SECURITY_PASSWORD_SALT'] = secretKey.secret2

db = SQLAlchemy(app)

def generate_confirmation_token(email):
    serializer = URLSafeTimedSerializer(app.config['SECRET_KEY'])
    return serializer.dumps(email, salt=app.config['SECURITY_PASSWORD_SALT'])


def confirm_token(token, expiration=3600):
    serializer = URLSafeTimedSerializer(app.config['SECRET_KEY'])
    try:
        email = serializer.loads(
            token,
            salt=app.config['SECURITY_PASSWORD_SALT'],
            max_age=expiration
        )
    except:
        return False
    return email


class UserModel(db.Model):
    ___tablename__ = 'users'
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(80), unique=True, index=True)
    password = db.Column(db.String(128))
    verified = db.Column(db.Boolean, default = False)

    def get_password(self, password):
        return generate_password_hash(password)

    def check_password(self, password):
        return check_password_hash(self.password_hash, password)

    def saveToDatabase(self):
        db.session.add(self)
        db.session.commit()
        return "ok!"

    def sendConfirmationMail(self):
        with app.app_context():
            msg = Message(subject="Email confirmation -- ArmyBuilder",
                              sender=app.config.get("MAIL_USERNAME"),
                              recipients=[self.username],  # replace with your email for testing
                              body="Confirm your email by clicking this link:\n"
                                   "localhost:5000/verification/" + generate_confirmation_token(self.username))
            mail.send(msg)

    @classmethod
    def find_by_username(cls, username):
        return cls.query.filter_by(username=username).first()

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
    if not re.match(r"[^@]+@[^@]+\.[^@]+", name):
        return 'emailError'
    password = request.json['password']
    if not len(password) >= 8:
        return 'passwordTooShort'
    elif password.lower() == password:
        return 'caseError'
    print(name)
    print(password)
    user = UserModel(username = name, password = password)
    if not user.find_by_username(user.username):
        user.saveToDatabase()
        user.sendConfirmationMail()
        return "ok!"
    return "user already exists"

@app.route('/verification/<token>')
def verify(token):
    try:
        email = confirm_token(token)
    except:
        return 'The confirmation link is invalid or has expired.'
    user = UserModel(username = email, password = "None")
    if user.find_by_username(username = email).verified:
        return "user already verified"
    else:
        user.find_by_username(username=email).verified = True
        db.engine.execute("UPDATE `user_model` SET verified = true WHERE username = %s;", email)
        return "verification succesful"







if __name__ == '__main__':
    app.run()
