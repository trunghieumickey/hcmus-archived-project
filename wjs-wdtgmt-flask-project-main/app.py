from flask import Flask
from flask_sqlalchemy import SQLAlchemy
from flask_login import LoginManager

# Create an instance of the SQLAlchemy class
db = SQLAlchemy()

def create_app():
    app = Flask(__name__)

    # # Configure the database URI:
    # user = 'postgres'
    # password = '123456789'
    # host = 'localhost'
    # port = '5432'
    # database = 'postgres'

    # # Create the connection string
    # app.config['SQLALCHEMY_DATABASE_URI'] = f'postgresql://{user}:{password}@{host}:{port}/{database}'


    # Configure the database URI:
    app.config['SECRET_KEY'] = 'SECRET_KEY'
    app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///database.db'

    # Initialize the SQLAlchemy object with the Flask app
    db.init_app(app)

    @app.template_filter('format_price')
    def format_price(price):
        return f'{price:,}'.replace(',', '.')
    
    from models import User
    # Create the database tables
    with app.app_context():
        db.create_all()

    login_manager = LoginManager()
    login_manager.login_view = 'auth.login'
    login_manager.init_app(app)

    @login_manager.user_loader
    def load_user(user_id):
        return User.query.get(int(user_id))

    # Blueprint for auth routes in our app
    from auth import auth as auth_blueprint
    app.register_blueprint(auth_blueprint)

    # Blueprint for non-auth parts of app
    from main import main as main_blueprint
    app.register_blueprint(main_blueprint)

    return app