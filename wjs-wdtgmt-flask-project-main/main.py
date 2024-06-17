from flask import Blueprint, render_template, redirect, url_for, request, flash, make_response, jsonify, session
from flask_login import login_required, current_user
from app import db
from models import Product, Product_info, Product_cart, Bill, Bill_detail
from image_processing.read_data import read_data_into_tables

main = Blueprint('main', __name__)

@main.route('/')
def index():
    read_data_into_tables()
    page = request.args.get('page', 1, type=int)
    pagination = Product.query.paginate(page=page, per_page=20, error_out=False)
    products = pagination.items
    product_info = db.session.query(Product_info).all()
    return render_template('home.html', products=products, pagination=pagination)
    # return render_template('home.html')

@main.route('/profile')
@login_required
def profile():
    orders = Bill.query.filter_by(customer_id=current_user.id).all()
    products = []
    for order in orders:
        products.append(db.session.query(Bill_detail).filter_by(bill_id=order.id).all())
    print(products)
    return render_template('profile.html', name=current_user.name, orders=orders, products=products)

@main.route('/product_info/<code>')
def product_info(code):
    product = db.session.query(Product).filter_by(code=code).first()
    info = db.session.query(Product_info).filter_by(code=code).all()
    return render_template('product_info.html', product=product, infos=info)

@main.route('/product_info/<code>/add_to_cart')
@login_required
def add_to_cart(code):
    if Product_cart.query.filter_by(product_code=code, customer_id=current_user.id).first():
        flash('Product already added to cart', "message")
        return redirect(url_for('main.product_info', code=code))
    else:
        new_product = Product_cart(product_code=code, customer_id=current_user.id)
        db.session.add(new_product)
        db.session.commit()
        return make_response('', 204)

@main.route('/cart')
@login_required
def cart():
    # Read the cart from the database of the current user
    cart = Product_cart.query.filter_by(customer_id=current_user.id).all()
    products = []
    for product in cart:
        products.append(db.session.query(Product).filter_by(code=product.product_code).first())
    print(products)
    return render_template('cart.html', products=products)
    #return render_template('cart.html')

@main.route('/cart/order', methods=['GET', 'POST'])
@login_required
def order():
    products = []
    selectedProducts = []
    if request.method == 'POST':
        selectedProducts = request.get_json()
        session['selectedProducts'] = selectedProducts
    else:
        selectedProducts = session.get('selectedProducts', [])
    print(selectedProducts)
    for productCode in selectedProducts:
        products.append(db.session.query(Product).filter_by(code=productCode).first())
    print(products)
    return render_template('order.html', products=products)

@main.route('/search', methods=['GET', 'POST'])
def search():
    if request.method == 'POST':
        search_string = request.form['search']
        products = Product.query.filter(Product.title.like('%' + search_string + '%')).all()
        return render_template('search_results.html', products=products)
    return redirect(url_for('index'))

@main.route('/delete_from_cart/<code>', methods=['DELETE'])
@login_required
def delete_from_cart(code):
    product = Product_cart.query.filter_by(product_code=code, customer_id=current_user.id).first()
    if product:
        db.session.delete(product)
        db.session.commit()
        return jsonify(success=True)
    else:
        return jsonify(success=False, error="Product not found in cart")

@main.route('/delete_all_from_cart', methods=['DELETE'])
@login_required
def delete_all_from_cart():
    products = Product_cart.query.filter_by(customer_id=current_user.id).all()
    for product in products:
        db.session.delete(product)
    db.session.commit()
    # check if the cart of the current user is empty
    if Product_cart.query.filter_by(customer_id=current_user.id).first():
        return jsonify(success=False, error="Cart not empty")
    else:
        return jsonify(success=True)

#Create bill that send from client to server
@main.route('/create_bill', methods=['POST'])
@login_required
def create_bill():
    # Get the data from the request
    data = request.get_json()
    # Create a new bill
    new_bill = Bill(customer_id=current_user.id, customer_name=data['name'], phone=data['phoneNumber'], date=data['date'], total=data['totalPrice'], store_address=data['dropdown'], status='Đã đặt hàng')
    db.session.add(new_bill)
    db.session.commit()
    # Create bill detail
    for product in data['products']:
        new_bill_detail = Bill_detail(bill_id=new_bill.id, product_code=product['code'], product_title=product['product_title'], quantity=product['quantity'])
        db.session.add(new_bill_detail)
    db.session.commit()
    # Delete all products in cart
    products = Product_cart.query.filter_by(customer_id=current_user.id).all()
    for product in products:
        db.session.delete(product)
    db.session.commit()
    # Check if the bill is created
    if Bill.query.filter_by(customer_id=current_user.id).first():
        return jsonify(success=True)
    else:
        return jsonify(success=False, error="Bill not created")