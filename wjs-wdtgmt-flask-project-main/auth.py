from flask import Blueprint, render_template, redirect, url_for, flash, request
from flask_login import login_user, login_required, logout_user
from werkzeug.security import generate_password_hash, check_password_hash
from models import User, Image_user
from app import db
from image_processing.face_recognize import check_face
from image_processing.read_image import read_image

auth = Blueprint('auth', __name__)

############################################
# Normal login
@auth.route('/login')
def login():
    return render_template('login.html')

@auth.route('/login', methods=['POST'])
def login_post():
    # login code goes here
    email = request.form.get('email')
    password = request.form.get('password')
    remember = True if request.form.get('remember') else False

    user = User.query.filter_by(email=email).first()

    # check if the user actually exists
    # take the user-supplied password, hash it, and compare it to the hashed password in the database
    if not user or not check_password_hash(user.password, password):
        flash('Please check your login details and try again.')
        return redirect(url_for('auth.login')) # if the user doesn't exist or password is wrong, reload the page

    # if the above check passes, then we know the user has the right credentials
    login_user(user, remember=remember)
    return redirect(url_for('main.index'))

############################################
#login with face
@auth.route('/loginwithface')
def facelogin():
    return render_template('login_with_face.html')

@auth.route('/loginwithface', methods=['POST'])
def facelogin_post():
    # login code goes here
    image_data = request.form.get('image')
    name = request.form.get('username')
    remember = True if request.form.get('remember') else False

    # Read the image from the form data
    image = read_image(image_data)

    # Check if a user with the given username already exists
    user = Image_user.query.filter_by(name=name).first()
    user_image = user.image
    # Read the image from the database
    user_image = read_image(user_image)

    results = check_face(image, user_image)

    # check if the user actually exists
    if results[0] == False:
        flash('Please check your login details and try again.')
        return redirect(url_for('auth.login'))
    else:
        login_user(user, remember=remember)
        return redirect(url_for('main.index'))

############################################
# Normal signup    
@auth.route('/signup')
def signup():
    return render_template('signup.html')

@auth.route('/signup', methods=['POST'])
def signup_post():
    # code to validate and add user to database goes here
    email = request.form.get('email')
    name = request.form.get('name')
    password = request.form.get('password')

    user = User.query.filter_by(email=email).first() # if this returns a user, then the email already exists in database

    if user: # if a user is found, we want to redirect back to signup page so user can try again
        flash('Email address already exists !!!')
        return redirect(url_for('auth.signup'))

    # create a new user with the form data. Hash the password so the plaintext version isn't saved.
    new_user = User(email=email, name=name, password=generate_password_hash(password, method='pbkdf2:sha256'))

    # add the new user to the database
    db.session.add(new_user)
    db.session.commit()

    return redirect(url_for('auth.login'))

############################################
# Signup with face
@auth.route('/signupwithface')
def signupwithface():
    return render_template('signup_with_face.html')

@auth.route('/signupwithface', methods=['POST'])
def signupwithface_post():
    image = request.form.get('image')
    name = request.form.get('username')

    # Check if a user with the given username already exists
    existing_user = Image_user.query.filter_by(name=name).first()
    if existing_user:
        # If a user with the given username exists, redirect them to the main index
        return redirect(url_for('main.index'))

    # If no user with the given username exists, proceed with the sign up with face process
    new_user = Image_user(image=image, name=name)
    db.session.add(new_user)
    db.session.commit()

    return redirect(url_for('main.index'))

############################################
# Logout
@auth.route('/logout')
@login_required
def logout():
    logout_user()
    return redirect(url_for('main.index'))