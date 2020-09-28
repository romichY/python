# src/config.py

import os


class Development(object):
    """
    Development environment configuration
    """
    DEBUG = True
    TESTING = False
    ENV = 'development'


class Production(object):
    """
    Production environment configurations
    """
    DEBUG = False
    TESTING = False
    ENV = 'production'


app_config = {
    'development': Development,
    'production': Production,
}
