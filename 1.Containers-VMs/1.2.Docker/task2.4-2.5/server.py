from flask import Flask
import os
from random import randrange

app = Flask(__name__)

@app.route('/')
def hello():

    return 'Hello, World! - k8s app for test!! ' + str(os.uname()[1]) +" - "+str(randrange(1000))


if __name__ == "__main__":
    app.run(debug=True)

