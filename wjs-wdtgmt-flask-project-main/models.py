from flask_login import UserMixin
from app import db

class User(UserMixin, db.Model):
    id = db.Column(db.Integer, primary_key=True) # primary keys are required by SQLAlchemy
    email = db.Column(db.String(100), unique=True)
    password = db.Column(db.String(100))
    name = db.Column(db.String(100))

# #class Image_user for login 
class Image_user(UserMixin, db.Model):
    id = db.Column(db.Integer, primary_key=True)
    image = db.Column(db.String(1000), unique=True)
    name = db.Column(db.String(100))

# class product 
class Product(db.Model):
    id = db.Column(db.Integer, primary_key=True) 
    code = db.Column(db.String(100))
    title = db.Column(db.String(100))
    # price = db.Column(db.String(100))
    price = db.Column(db.Integer)
    image = db.Column(db.String(1000))

class Product_info(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    code = db.Column(db.String(100))
    key = db.Column(db.String(100))
    content = db.Column(db.String(100))

class Product_cart(db.Model):
    # id = db.Column(db.Integer, primary_key=True)
    # date = db.Column(db.String(10))
    # total = db.Column(db.Integer)
    # status = db.Column(db.String(10))
    # customer_name = db.Column(db.String(100))
    customer_id = db.Column(db.String(100), primary_key=True)
    product_code = db.Column(db.String(100), primary_key=True)

class Bill(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    customer_id = db.Column(db.Integer)
    customer_name = db.Column(db.String(100))
    phone = db.Column(db.String(100))
    date = db.Column(db.String(10))
    total = db.Column(db.Integer)
    store_address = db.Column(db.String(100))
    status = db.Column(db.String(10))

class Bill_detail(db.Model):
    bill_id = db.Column(db.Integer, primary_key=True)
    product_code = db.Column(db.String(100), primary_key=True)
    product_title = db.Column(db.String(100))
    quantity = db.Column(db.Integer)