import os
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import and_
from app import db
from models import Product, Product_info
import pandas as pd

def read_data_into_tables():
    data = pd.read_csv('data.csv', encoding='utf-8')
    for i in range(len(data)):
        existing_product = db.session.query(Product).filter_by(code=data['code'][i]).first()
        if existing_product is None:
            product = Product(code=data['code'][i], title=data['title'][i], price=int(data['price'][i]), image=data['image'][i])
            db.session.add(product)
    db.session.commit()

    meta_df = pd.read_csv('meta.csv', encoding='utf-8')
    for j in range(len(meta_df)):
        existing_product_info = db.session.query(Product_info).filter(and_(Product_info.code==meta_df['code'][j], Product_info.key==meta_df['key'][j])).first()
        if existing_product_info is None:
            product_info = Product_info(code=meta_df['code'][j], key=meta_df['key'][j], content=meta_df['content'][j])
            db.session.add(product_info)
    db.session.commit()
                