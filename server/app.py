from flask import Flask
from werkzeug.security import generate_password_hash, check_password_hash
from flask import make_response
from flask import request, flash
import requests
from flask_sqlalchemy import SQLAlchemy
from data import database, mail, secretKey
import re
from flask import render_template
from sqlalchemy.orm.attributes import flag_modified
import json
from flask_mail import Mail, Message
from itsdangerous import URLSafeTimedSerializer
from flask_login import login_user, login_required, current_user, LoginManager, logout_user
import base64

app = Flask(__name__)
login_manager = LoginManager()
login_manager.init_app(app)
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
    loggedin = db.Column(db.Boolean, default = False)

    def get_password(self, password):
        return generate_password_hash(password)

    def check_password(self, password):
        return check_password_hash(self.password_hash, password)

    def __get__(self, user_id):
        return self.id

    def is_active(self):
        """True, as all users are active."""
        return True

    def get_id(self):
        """Return the email address to satisfy Flask-Login's requirements."""
        return self.username

    def is_authenticated(self):
        """Return True if the user is authenticated."""
        return self.authenticated

    def is_anonymous(self):
        """False, as anonymous users aren't supported."""
        return False

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

    def sendChangePassMail(self):
        with app.app_context():
            msg = Message(subject="Change password -- ArmyBuilder",
                              sender=app.config.get("MAIL_USERNAME"),
                              recipients=[self.username],  # replace with your email for testing
                              body="Change your passwrod by clicking this link:\n"
                                   "localhost:5000/changepasswordweb/"  + generate_confirmation_token(self.username) + " \n "
                                   "If it wasn't you who tried to change the password, please ignore this message.")
            mail.send(msg)

    @classmethod
    def find_by_username(cls, username):
        return cls.query.filter_by(username=username).first()


    def __init__(self, username, password):
        self.username = username
        self.password = self.get_password(password)
        col = CollectionModel(username = username, userid = self.id)
        col.saveToDatabase()

class ArmyModel(db.Model):
    ___tablename__ = 'armies'
    user = db.Column(db.String(128))
    userid = db.Column(db.Integer)
    id = db.Column(db.Integer, primary_key=True)
    army = db.Column(db.JSON)
    deleted = db.Column(db.Boolean)


    def saveToDatabase(self):
        db.session.add(self)
        db.session.commit()
        return "army added"

    def __init__(self, username, userid, army ):
        self.user = username
        self.userid = userid
        self.army = army

    @classmethod
    def find_by_username(cls, username):

        return cls.query.filter_by(user=username)

    @classmethod
    def find_by_username_and_name(cls, username, name):
        armies = cls.query.filter_by(user=username).all()
        for army in armies:
            if army.army["name"] == name and army.army["deleted"] == False:
                return army


class CollectionModel(db.Model):
    ___tablename__ = 'collections'
    user = db.Column(db.String(128))
    userid = db.Column(db.Integer)
    id = db.Column(db.Integer, primary_key=True)
    collection = db.Column(db.JSON)


    def saveToDatabase(self):
        db.session.add(self)
        db.session.commit()
        return "collection saved"

    def __init__(self, username, userid):
        self.user = username
        self.userid = userid

    @classmethod
    def find_by_username(cls, username):
        return cls.query.filter_by(user=username)


@app.route('/', methods=['GET', 'POST'])
def handshake():
    return "HellO!"

@login_manager.user_loader
def load_user(name):
    return UserModel.find_by_username(name)

@login_manager.request_loader
def request_loader(request):
    email = request.form.get('name')
    if UserModel(username = "", password = ""):
        return

    user = UserModel()
    return user

@app.route('/registration',methods=['POST'])
def registration():
    request.get_json(force=True)
    name = request.json['name']
    if not re.match(r"[^@]+@[^@]+\.[^@]+", name):
        return 'emailError'
    password = request.json['password']
    if not len(password) >= 7:
        return 'passwordTooShort'
    elif password.lower() == password:
        return 'caseError'
    print(name)
    print(password)
    if not UserModel.find_by_username(name):
        user = UserModel(username = name, password = password)
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
    if UserModel.find_by_username(username = email).verified:
        return "user already verified"
    else:
        print(UserModel.find_by_username(username=email).verified)
        UserModel.find_by_username(username=email).verified = True
        print(UserModel.find_by_username(username=email).verified)
       # db.engine.execute("UPDATE `user_model` SET verified = true WHERE username = %s;", email)
        print(UserModel.find_by_username(username=email).verified)
        db.session.commit()
        return "verification successful"

@app.route('/login', methods = ["POST"])
def login():
    request.get_json(force=True)
    name = request.json['name']
    password = request.json['password']
    user = UserModel.find_by_username(name)
    if not user:
        return "check user name or password"
    if not user.verified:
        print(user.verified)
        return "verify your account"
    if check_password_hash(user.password, password):
        user.loggedin = True
        login_user(user)
        db.session.commit()
        return "logged in successfully"
    else:
        return "check user name or password"

@app.route("/whoami", methods = ["GET"])
@login_required
def whoami():
    return current_user.username

@app.route("/addarmy", methods = ["GET","POST"])
@login_required
def add_army():
    request.get_json(force=True)
    army = ArmyModel(username=current_user.username, userid=current_user.id, army = request.json)
    army.saveToDatabase()
    return "army added"

@app.route("/savecollection", methods = ["GET","POST"])
@login_required
def save_collection():
    request.get_json(force=True)
    col = CollectionModel.find_by_username(username = current_user.username).first()
    col.collection = request.json
    flag_modified(col, "collection")
    db.session.commit()
    return "collection saved"

@app.route("/getarmies", methods = ["GET","POST"])
@login_required
def get_armies():
    armies = ArmyModel.find_by_username(current_user.username).all()
    ansdict = []
    for army in armies:
        if army.army["deleted"] == False:
            print(army.army["name"])
            ansdict.append(army.army)
    return json.dumps(ansdict)

@app.route("/updatearmy", methods = ["GET","POST"])
@login_required
def update_army():
    request.get_json(force=True)
    army = ArmyModel.find_by_username_and_name(username = current_user.username, name = request.json['name'])
    army.army = request.json
    flag_modified(army, "army")
    db.session.commit()
    return "ok!"


@app.route("/changearmyname", methods = ["GET","POST"])
@login_required
def changearmyname():
    request.get_json(force=True)
    army = ArmyModel.find_by_username_and_name(username = current_user.username, name = request.json['oldname'])
    army.army["name"] = request.json["newname"]
    flag_modified(army, "army")
    db.session.commit()
    return "ok!"

@app.route("/deletearmy", methods = ["GET","POST"])
@login_required
def deletearmy():
    request.get_json(force=True)
    army = ArmyModel.find_by_username_and_name(username = current_user.username, name = request.json['name'])
    army.army["deleted"] = True
    flag_modified(army, "army")
    db.session.commit()
    return "ok!"


@app.route("/getcollection", methods = ["GET","POST"])
@login_required
def get_collection():
    col = CollectionModel.find_by_username(username= current_user.username).first()
    if col.collection:
        return col.collection
    else:
        return "NOne"

@app.route("/changepasswordapp", methods = ["POST"])
def changepasswordapp():
    request.get_json(force=True)
    UserModel.sendChangePassMail(UserModel.find_by_username(username = request.json['email']))
    return "ok!"

@app.route("/logout", methods = ["GET"])
@login_required
def logout():
    user = UserModel.find_by_username(current_user.username)
    user.loggedin = False
    db.session.commit()
    logout_user()
    return "logged out successfully"

@app.route("/changepasswordweb/<token>", methods = ["POST","GET"])
def changepasswordweb(token):
        try:
            email = confirm_token(token)
        except:
            return 'The confirmation link is invalid or has expired.'
        if not email:
            return 'The confirmation link is invalid or has expired.'
        if "submitpass" in request.form and "passOne" in request.form and "passTwo" in request.form:
            if len(request.form['passOne']) > 0:
                print(email)
                user = UserModel.find_by_username(username= email)
                user.password = user.get_password(password = request.form['passOne'])
                db.session.commit()
                return "Password changed."
        return render_template('changepass.html')



if __name__ == '__main__':
    app.run()
