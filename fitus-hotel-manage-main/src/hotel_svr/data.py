import sqlite3
from data_import import *

con = sqlite3.connect("data.db")
cur = con.cursor()

# drop everything
cur.execute("DROP TABLE IF EXISTS HOTEL")
cur.execute("DROP TABLE IF EXISTS USER")
cur.execute("DROP TABLE IF EXISTS PERMISSION")
cur.execute("DROP TABLE IF EXISTS ROOM")
cur.execute("DROP TABLE IF EXISTS TRANSACTION_LOG")
cur.execute("DROP TABLE IF EXISTS USER_PERMISSION")
cur.execute("DROP TABLE IF EXISTS LOGIN_INFO")
cur.execute("DROP TABLE IF EXISTS FURNITURE")
cur.execute("DROP TABLE IF EXISTS SCHEDULE")
cur.execute("DROP TABLE IF EXISTS FEEDBACK")

# Enable foreign keys
cur.execute("PRAGMA foreign_keys = ON")

#create HOTEL table with Hotel ID as KEY, Name, Location
cur.execute("CREATE TABLE IF NOT EXISTS HOTEL (HOTEL_ID TEXT PRIMARY KEY, Name TEXT, LOCATION TEXT)")

#create USER table with User ID as KEY, Name, Phone, Email, GENDER, DOB, ADDRESS
cur.execute("CREATE TABLE IF NOT EXISTS USER (USER_ID TEXT PRIMARY KEY, NAME TEXT, PHONE TEXT, EMAIL TEXT, GENDER TEXT, DOB TEXT,  ADDRESS TEXT)")

#create PERMISSION table with PermissionID as KEY, PermissionName
cur.execute("CREATE TABLE IF NOT EXISTS PERMISSION (PERMISSION_ID TEXT PRIMARY KEY, PERMISSION_NAME TEXT)")

#create ROOM table with RoomID as KEY, HotelID referencing HotelID in HOTEL table, RoomType, RoomPrice, NumOfBeds, Marking
cur.execute("CREATE TABLE IF NOT EXISTS ROOM (ROOM_ID TEXT PRIMARY KEY, HOTEL_ID TEXT, ROOM_PRICE REAL, NUM_OF_BEDS INTERGER, MARKING TEXT, FOREIGN KEY(HOTEL_ID) REFERENCES HOTEL(HOTEL_ID))")

#create Furniture table with RoomID referencing RoomID in ROOM table, Furniture_1, Furniture_2, Furniture_3, Furniture_4
cur.execute("CREATE TABLE IF NOT EXISTS FURNITURE (ROOM_ID TEXT, FURNITURE_1 TEXT, FURNITURE_2 TEXT, FURNITURE_3 TEXT, FURNITURE_4 TEXT, FOREIGN KEY(ROOM_ID) REFERENCES ROOM(ROOM_ID))")

#create TransactionLog table with LogID as KEY, UserID referencing UserID in USER table, RoomID referencing RoomID in ROOM table, DATE_START, DATE_END, , PAID_AMOUNT
cur.execute("CREATE TABLE IF NOT EXISTS TRANSACTION_LOG (LOG_ID TEXT PRIMARY KEY, USER_ID TEXT, ROOM_ID TEXT , DATE_START TEXT, DATE_END TEXT, PAID_AMOUNT TEXT, FOREIGN KEY(USER_ID) REFERENCES USER(USER_ID), FOREIGN KEY(ROOM_ID) REFERENCES ROOM(ROOM_ID))")

#create User_Permission table with UserID referencing UserID in USER table, PermissionID referencing PermissionID in PERMISSION table
cur.execute("CREATE TABLE IF NOT EXISTS USER_PERMISSION (USER_ID TEXT, PERMISSION_ID TEXT, FOREIGN KEY(USER_ID) REFERENCES USER(USER_ID), FOREIGN KEY(PERMISSION_ID) REFERENCES PERMISSION(PERMISSION_ID))")

#create Login_Info table with UserID referencing UserID in USER table, Username, Password
cur.execute("CREATE TABLE IF NOT EXISTS LOGIN_INFO (USER_ID TEXT, USERNAME TEXT, PASSWORD TEXT, FOREIGN KEY(USER_ID) REFERENCES USER(USER_ID))")

#create SCHEDULE table with UserID referencing UserID in USER table, DATE, TIME_START, TIME_END
cur.execute("CREATE TABLE IF NOT EXISTS SCHEDULE (USER_ID TEXT, DATE TEXT, TIME_START TEXT, TIME_END TEXT, FOREIGN KEY(USER_ID) REFERENCES USER(USER_ID))")

#create Feedback table with UserID referencing UserID in USER table, Feedback
cur.execute("CREATE TABLE IF NOT EXISTS FEEDBACK (USER_ID TEXT, FEEDBACK TEXT, FOREIGN KEY(USER_ID) REFERENCES USER(USER_ID))")

import_test_to_db(cur)

con.commit()
con.close()