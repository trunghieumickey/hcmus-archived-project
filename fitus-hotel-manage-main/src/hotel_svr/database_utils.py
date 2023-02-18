import datetime
import os
import sqlite3

from pydantic import BaseModel


class UserInfo(BaseModel):
    Name: str
    Phone: str
    Email: str
    Gender: str
    DOB: str
    Address: str


class RoomInfo(BaseModel):
    RoomID: str
    Price: str
    BedNums: str
    Furnitures: list[str]
    Available: bool


class HotelInfo(BaseModel):
    HotelName: str
    HotelAddress: str
    Rooms: list[RoomInfo]


class ScheduleInfo(BaseModel):
    Date: str
    TimeStart: str
    TimeEnd: str


class Database():
    QUERY_PASSWORD = "SELECT PASSWORD\
        FROM LOGIN_INFO\
        WHERE USERNAME = ?"

    QUERY_USER_INFO = "SELECT * FROM USER \
        WHERE USER_ID = \
        (SELECT USER_ID \
        FROM LOGIN_INFO \
        WHERE USERNAME = ?)"

    QUERY_USERS = "SELECT USERNAME FROM LOGIN_INFO"

    QUERY_PERMISSIONS = "SELECT PERMISSION_NAME \
        FROM USER_PERMISSION \
        JOIN PERMISSION \
        ON USER_PERMISSION.PERMISSION_ID = PERMISSION.PERMISSION_ID \
        WHERE USER_ID = \
        (SELECT USER_ID \
        FROM LOGIN_INFO \
        WHERE USERNAME = ?)"

    QUERY_HOTELS = "SELECT * \
        FROM HOTEL \
    "

    QUERY_ROOMS = "SELECT * \
        FROM ROOM \
        WHERE HOTEL_ID = ? \
    "

    QUERY_FURNITURES = "SELECT * \
        FROM FURNITURE \
        WHERE ROOM_ID = ? \
    "

    QUERY_LOG = "SELECT* \
        FROM TRANSACTION_LOG \
        WHERE USER_ID = ? \
    "

    QUERY_SCHEDULE = "SELECT* \
        FROM SCHEDULE \
        WHERE USER_ID = \
        (SELECT USER_ID \
        FROM LOGIN_INFO \
        WHERE USERNAME = ?) \
    "

    QUERY_FEEDBACK = "SELECT* \
        FROM FEEDBACK \
        WHERE USER_ID = ? \
    "

    def __init__(self, dbname: str):
        # A database should be there, we don't want it to be implicitly created
        if os.path.exists(dbname):
            # This is assuming only the server access the database, don't call it from multiple threads
            self.con = sqlite3.connect(dbname, check_same_thread=False)
            self.cur = self.con.cursor()
        else:
            raise Exception("Database doesn't exist")

    def check_credentials(self, username: str, password: str) -> bool:
        self.cur.execute(self.QUERY_PASSWORD, (username, ))
        result = self.cur.fetchone()
        if result is not None:
            return result[0] == password
        else:
            return False

    def get_users(self) -> list:
        self.cur.execute(self.QUERY_USERS)
        query = self.cur.fetchall()
        return [user[0] for user in query]

    def get_user_info(self, username: str) -> tuple:
        self.cur.execute(self.QUERY_USER_INFO, (username, ))
        info = self.cur.fetchone()
        return UserInfo(**{
            key: info[i + 1]
            for i, key in enumerate(UserInfo.__fields__.keys())
        }),

    def get_user_permissions(self, username: str) -> tuple:
        self.cur.execute(self.QUERY_PERMISSIONS, (username, ))
        result = self.cur.fetchall()
        if result is not None:
            return (permission[0] for permission in result)
        else:
            return ()

    def update_permissions(self, username: str, permissions: list[str]):
        self.cur.execute(
            "DELETE FROM USER_PERMISSION \
            WHERE USER_ID = \
            (SELECT USER_ID \
            FROM LOGIN_INFO \
            WHERE USERNAME = ?)", (username, ))
        self.con.commit()

        self.cur.execute(self.QUERY_USER_INFO, (username, ))
        user_id = self.cur.fetchone()[0]

        for permission in permissions:
            self.cur.execute(
                "INSERT INTO USER_PERMISSION \
                VALUES(?, \
                (SELECT PERMISSION_ID \
                FROM PERMISSION \
                WHERE PERMISSION_NAME = ?))", (user_id, permission))
            self.con.commit()

    def get_hotels_info(self) -> dict:
        result = []

        #delete expired log
        self.cur.execute("DELETE FROM TRANSACTION_LOG WHERE DATE_END > ? ",
                         (datetime.date.today(), ))
        self.con.commit()

        self.cur.execute("SELECT ROOM_ID FROM TRANSACTION_LOG")
        room_id = [id[0] for id in self.cur.fetchall()]

        self.cur.execute(self.QUERY_HOTELS)
        hotels = self.cur.fetchall()
        for hotel in hotels:
            self.cur.execute(self.QUERY_ROOMS, (hotel[0], ))
            rooms = self.cur.fetchall()
            rooms_list = []
            for room in rooms:
                if room[0] in room_id:
                    continue
                else:
                    furnitures_list = []
                    self.cur.execute(self.QUERY_FURNITURES, (room[0], ))
                    furnitures = list(self.cur.fetchone())
                    if furnitures is not None:
                        for furniture in furnitures[1:]:
                            if furniture is not None:
                                furnitures_list.append(furniture)
                    rooms_list.append(
                        RoomInfo(
                            RoomID=room[0],
                            Price=room[2],
                            BedNums=room[3],
                            Furnitures=furnitures_list,
                            Available=(True if room[4] is None else False)))

            result.append(
                HotelInfo(HotelName=hotel[1],
                          HotelAddress=hotel[2],
                          Rooms=rooms_list))

        return result

    def get_log(self, username: str) -> tuple:
        self.cur.execute(self.QUERY_USER_INFO, (username, ))
        user_id = self.cur.fetchone()[0]
        self.cur.execute(self.QUERY_LOG, (user_id, ))
        result = self.cur.fetchall()
        return result

    def insert_log(self, username: str, room_id: str, start: str, end: str,
                   paid: str):
        self.cur.execute(self.QUERY_USER_INFO, (username, ))
        user_id = self.cur.fetchone()[0]

        self.cur.execute(
            "SELECT * FROM TRANSACTION_LOG Order by LOG_ID DESC LIMIT 1")
        row_count = self.cur.fetchone()
        if row_count is not None:
            row_count = row_count[0]
        else:
            row_count = 0

        self.cur.execute(
            "INSERT INTO TRANSACTION_LOG VALUES (?,?, ?, ?, ?, ?)",
            (row_count + 1, user_id, room_id, start, end, paid))

        self.con.commit()

    def get_schedule(self, username) -> list:
        self.cur.execute(self.QUERY_SCHEDULE, (username, ))
        result = self.cur.fetchall()
        schedule_list = []
        for schedule in result:
            schedule_list.append(
                ScheduleInfo(
                    **{
                        key: schedule[i + 1]
                        for i, key in enumerate(ScheduleInfo.__fields__.keys())
                    }))
        return schedule_list

    def insert_schedule(self, username: str, date: str, start: str, end: str):
        self.cur.execute(self.QUERY_USER_INFO, (username, ))
        user_id = self.cur.fetchone()[0]

        self.cur.execute("INSERT INTO SCHEDULE VALUES (?,?, ?, ?)",
                         (user_id, date, start, end))

        self.con.commit()

    def get_feedback(self, username: str) -> tuple:
        self.cur.execute(self.QUERY_USER_INFO, (username, ))
        user_id = self.cur.fetchone()[0]
        self.cur.execute(self.QUERY_FEEDBACK, (user_id, ))
        result = self.cur.fetchall()
        return result

    def insert_feedback(self, username: str, feedback: str):
        self.cur.execute(self.QUERY_USER_INFO, (username, ))
        user_id = self.cur.fetchone()[0]

        self.cur.execute("INSERT INTO FEEDBACK VALUES (?,?)",
                         (user_id, feedback))

        self.con.commit()

    def mark_room(self, room_id: str):
        self.cur.execute("SELECT MARKING FROM ROOM WHERE ROOM_ID = ?",
                         (room_id, ))
        marking = self.cur.fetchone()[0]

        if marking:
            marking = None
        else:
            marking = 1

        self.cur.execute("UPDATE ROOM SET MARKING = ? WHERE ROOM_ID = ?", (
            marking,
            room_id,
        ))

        self.con.commit()

    def close(self):
        self.con.close()