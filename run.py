# /run.py
import os
from src.app import create_app
from src.config import app_config

app = create_app(app_config[os.environ.get('FLASK_ENV', 'development')])

if __name__ == '__main__':
    app.run(host=os.environ.get('APP_HOST', 'localhost'), port=os.environ.get('APP_PORT', 9874))
