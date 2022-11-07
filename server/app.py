from flask import Flask
from werkzeug.security import generate_password_hash, check_password_hash
from flask import request
from flask_sqlalchemy import SQLAlchemy
from data import database, mail, secretKey
import re
from flask import render_template
from sqlalchemy.orm.attributes import flag_modified
import json
from flask_mail import Mail, Message
from itsdangerous import URLSafeTimedSerializer
from flask_login import login_user, login_required, current_user, LoginManager, logout_user

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
# секреты и строка для подключения к базе данных лежат в отдельном файле data.py для безопасности
app.config.update(mail_settings)
mail = Mail(app)
app.config['SQLALCHEMY_DATABASE_URI'] = \
    database.url
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['SECRET_KEY'] = secretKey.secret
app.config['SECURITY_PASSWORD_SALT'] = secretKey.secret2

db = SQLAlchemy(app)
# инициализация всего...

def generate_confirmation_token(email): # генератор токенов для подтверждения почты
    serializer = URLSafeTimedSerializer(app.config['SECRET_KEY'])
    return serializer.dumps(email, salt=app.config['SECURITY_PASSWORD_SALT'])


def confirm_token(token, expiration=3600): # функция подтверждения токена при подтверждении почты
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


class UserModel(db.Model): # класс UserModel (класс для SQLAlchemy)
    ___tablename__ = 'users'
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(80), unique=True, index=True)
    password = db.Column(db.String(128))
    verified = db.Column(db.Boolean, default=False)
    loggedin = db.Column(db.Boolean, default=False)

    def get_password(self, password): # функции генерации хэша пароля
        return generate_password_hash(password)

    def check_password(self, password): # функция проверки пароля на валидность
        return check_password_hash(self.password_hash, password)

    # Далее идут функции требуемые Flask-Login для корректной работы (по сути, они нигде не используются, но нужны для корректной работы)
    def __get__(self, user_id):
        return self.id

    def is_active(self):
        return True

    def get_id(self):
        return self.username

    def is_authenticated(self):
        return self.authenticated

    def is_anonymous(self):
        return False

    def saveToDatabase(self): # функция сохранения user'a в базу данных
        db.session.add(self)
        db.session.commit()
        return "ok!"

    def sendConfirmationMail(self): # функция отправки письма для подтверждения почты
        with app.app_context():
            msg = Message(subject="Email confirmation -- ArmyBuilder",
                          sender=app.config.get("MAIL_USERNAME"),
                          recipients=[self.username],
                          body="Confirm your email by clicking this link:\n"
                               "94.228.195.88:5000/verification/" + generate_confirmation_token(self.username))
            mail.send(msg)

    def sendChangePassMail(self): # функция отправки письма для восстановления пароля
        with app.app_context():
            msg = Message(subject="Change password -- ArmyBuilder",
                          sender=app.config.get("MAIL_USERNAME"),
                          recipients=[self.username],
                          body="Change your password by clicking this link:\n"
                               "94.228.195.88:5000/changepasswordweb/" + generate_confirmation_token(
                              self.username) + " \n "
                                               "If it wasn't you who tried to change the password, please ignore this message.")
            mail.send(msg)

    @classmethod
    def find_by_username(cls, username): # метод для поиска пользователя по email
        return cls.query.filter_by(username=username).first()

    def __init__(self, username, password): # инициализация
        self.username = username
        self.password = self.get_password(password)
        col = CollectionModel(username=username, userid=self.id)
        col.saveToDatabase()


class ArmyModel(db.Model): # класс ArmyModel (класс для SQLAlchemy)
    ___tablename__ = 'armies'
    user = db.Column(db.String(128))
    userid = db.Column(db.Integer)
    id = db.Column(db.Integer, primary_key=True)
    army = db.Column(db.JSON)
    deleted = db.Column(db.Boolean)

    def saveToDatabase(self): # функция сохранения армии в базу данных
        db.session.add(self)
        db.session.commit()
        return "army added"

    def __init__(self, username, userid, army): # инициализация
        self.user = username
        self.userid = userid
        self.army = army

    @classmethod
    def find_by_username(cls, username): # поиск армий пользователя по email
        return cls.query.filter_by(user=username)

    @classmethod
    def find_by_username_and_name(cls, username, name): # поиск армий пользователя по email и имени самой армии
        armies = cls.query.filter_by(user=username).all()
        for army in armies:
            if army.army["name"] == name and army.army["deleted"] == False:
                return army


class CollectionModel(db.Model): # класс CollectionModel (класс для SQLAlchemy)
    ___tablename__ = 'collections'
    user = db.Column(db.String(128))
    userid = db.Column(db.Integer)
    id = db.Column(db.Integer, primary_key=True)
    collection = db.Column(db.JSON)

    def saveToDatabase(self): # функция сохранения коллекции в базу данных
        db.session.add(self)
        db.session.commit()
        return "collection saved"

    def __init__(self, username, userid): # инициализация
        self.user = username
        self.userid = userid

    @classmethod
    def find_by_username(cls, username): # поиск коллекции по email
        return cls.query.filter_by(user=username)

@login_manager.user_loader
def load_user(name): # функция flask-login для загрузки пользователя
    return UserModel.find_by_username(name)


@login_manager.request_loader
def request_loader(request): # функция необходимая flask-login для корректной обработки запросов
    email = request.form.get('name')
    if UserModel:
        return
    user = UserModel()
    return user


# Далее идут функции через которые само приложение взаимодействует с бекэндом.

@app.route('/registration', methods=['POST'])
def registration(): # функция регистрации нового пользователя и сохранения информации о нем в базу данных
    request.get_json(force=True)
    name = request.json['name']
    if not re.match(r"[^@]+@[^@]+\.[^@]+", name):
        return 'emailError'
    password = request.json['password']
    if not len(password) >= 7:
        return 'passwordTooShort'
    elif password.lower() == password:
        return 'caseError'
    if not UserModel.find_by_username(name):
        user = UserModel(username=name, password=password)
        user.saveToDatabase()
        user.sendConfirmationMail()
        return "ok!"
    return "user already exists"


@app.route('/verification/<token>')
def verify(token): # функция подтверждения email (web)
    try:
        email = confirm_token(token)
    except:
        return 'The confirmation link is invalid or has expired.'
    if UserModel.find_by_username(username=email).verified:
        return "user already verified"
    else:
        print(UserModel.find_by_username(username=email).verified)
        UserModel.find_by_username(username=email).verified = True
        print(UserModel.find_by_username(username=email).verified)
        # db.engine.execute("UPDATE `user_model` SET verified = true WHERE username = %s;", email)
        print(UserModel.find_by_username(username=email).verified)
        db.session.commit()
        return render_template('verificationok.html')


@app.route('/login', methods=["POST"])
def login(): # фунция аутентификации
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


@app.route("/whoami", methods=["GET"])
@login_required
def whoami(): # функция для возвращения email текущего пользователя
    return current_user.username


@app.route("/addarmy", methods=["GET", "POST"])
@login_required
def add_army(): # функция для добавления новой армии
    request.get_json(force=True)
    army = ArmyModel(username=current_user.username, userid=current_user.id, army=request.json)
    army.saveToDatabase()
    return "army added"


@app.route("/savecollection", methods=["GET", "POST"])
@login_required
def save_collection(): # функция для сохранения коллекции
    request.get_json(force=True)
    col = CollectionModel.find_by_username(username=current_user.username).first()
    col.collection = request.json
    flag_modified(col, "collection")
    db.session.commit()
    return "collection saved"


@app.route("/getarmies", methods=["GET", "POST"])
@login_required
def get_armies(): # функция для получения всех армий пользователя
    armies = ArmyModel.find_by_username(current_user.username).all()
    ansdict = []
    for army in armies:
        if army.army["deleted"] == False:
            print(army.army["name"])
            ansdict.append(army.army)
    return json.dumps(ansdict)


@app.route("/updatearmy", methods=["GET", "POST"])
@login_required
def update_army(): # функция для обновления уже созданной армии
    request.get_json(force=True)
    army = ArmyModel.find_by_username_and_name(username=current_user.username, name=request.json['name'])
    army.army = request.json
    flag_modified(army, "army")
    db.session.commit()
    return "ok!"


@app.route("/changearmyname", methods=["GET", "POST"])
@login_required
def changearmyname(): # функция для изменения названия армии
    request.get_json(force=True)
    army = ArmyModel.find_by_username_and_name(username=current_user.username, name=request.json['oldname'])
    army.army["name"] = request.json["newname"]
    flag_modified(army, "army")
    db.session.commit()
    return "ok!"


@app.route("/deletearmy", methods=["GET", "POST"])
@login_required
def deletearmy(): # функция для удаления армии
    request.get_json(force=True)
    army = ArmyModel.find_by_username_and_name(username=current_user.username, name=request.json['name'])
    army.army["deleted"] = True
    flag_modified(army, "army")
    db.session.commit()
    return "ok!"


@app.route("/getcollection", methods=["GET", "POST"])
@login_required
def get_collection(): # функция для получения коллекции пользователя
    col = CollectionModel.find_by_username(username=current_user.username).first()
    if col.collection:
        return col.collection
    else:
        return "NOne"


@app.route("/changepasswordapp", methods=["POST"])
def changepasswordapp(): # функция отправки запроса на восстановление пароля
    request.get_json(force=True)
    UserModel.sendChangePassMail(UserModel.find_by_username(username=request.json['email']))
    return "ok!"


@app.route("/logout", methods=["GET"])
@login_required
def logout(): # функция выхода из аккаунта
    UserModel.find_by_username(current_user.username).loggedin = False
    db.session.commit()
    logout_user()
    return "logged out successfully"


@app.route("/changepasswordweb/<token>", methods=["POST", "GET"])
def changepasswordweb(token): # функция для изменения пароля (web)
    try:
        email = confirm_token(token)
    except:
        return 'The confirmation link is invalid or has expired.'
    if not email:
        return 'The confirmation link is invalid or has expired.'
    if "submitpass" in request.form and "passOne" in request.form and "passTwo" in request.form:
        if len(request.form['passOne']) > 0:
            print(email)
            user = UserModel.find_by_username(username=email)
            user.password = user.get_password(password=request.form['passOne'])
            db.session.commit()
            return "Password changed."
    return render_template('changepass.html')


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000) # запуск самого бэкенда
