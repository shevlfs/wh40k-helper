from flask import Flask
from flask import make_response
from flask import request

app = Flask(__name__)


@app.route('/', methods=['GET', 'POST'])
def handshake():
    return "HellO!"


if __name__ == '__main__':
    app.run()
