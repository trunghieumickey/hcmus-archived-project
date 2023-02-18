from database_utils import Database, ScheduleInfo
from fastapi import FastAPI, Response
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

data = Database("data.db")


class LoginInfo(BaseModel):
    username: str
    password: str


class BookingInfo(BaseModel):
    username: str
    start: str
    end: str
    price: str


class Permissions(BaseModel):
    permissions: list[str]


@app.post("/login", status_code=200)
def login(login_info: LoginInfo, response: Response):
    if data.check_credentials(login_info.username, login_info.password):
        return {
            "user_info": data.get_user_info(login_info.username),
            "permissions": data.get_user_permissions(login_info.username),
        }
    else:
        response.status_code = 401
        return


@app.get("/users", status_code=200)
def get_users():
    return data.get_users()


@app.get("/users_info", status_code=200)
def get_users_info():
    result = []
    for user in data.get_users():
        result.append({
            "username": user,
            "user_info": data.get_user_info(user),
            "permissions": data.get_user_permissions(user)
        })
    return result


@app.get("/user/{username}", status_code=200)
def get_user_info(username: str):
    return {
        "user_info": data.get_user_info(username),
        "permissions": data.get_user_permissions(username)
    }


@app.post("/user/{username}/permissions", status_code=200)
def change_permission(username: str, permissions: Permissions):
    data.update_permissions(username, permissions.permissions)


@app.get("/schedule/{username}", status_code=200)
def get_user_schedule(username: str):
    result = data.get_schedule(username)
    return {
        "schedule": result,
    }


@app.post("/schedule/{username}", status_code=200)
def add_user_schedule(username: str, schedule: ScheduleInfo):
    data.insert_schedule(username, schedule.Date, schedule.TimeStart,
                         schedule.TimeEnd)


@app.get("/hotels_info", status_code=200)
def hotels_info():
    return data.get_hotels_info()


@app.post("/book/{room_id}", status_code=201)
def book_room(room_id: str, info: BookingInfo):
    data.insert_log(info.username, room_id, info.start, info.end, info.price)


@app.post("/status/{room_id}", status_code=201)
def change_availability(room_id: str):
    data.mark_room(room_id)