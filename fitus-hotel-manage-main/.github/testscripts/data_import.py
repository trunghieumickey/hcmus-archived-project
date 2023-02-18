import json, os

def import_test_to_db(cur, limit=100):

    basePath = os.path.join(os.path.dirname(__file__), '..', '..', '.github', 'testcases')

    with open(os.path.join(basePath, 'PermissionsList.json'), encoding="utf8") as f:
        traffic = json.load(f)

    for id in range (0, len(traffic)):
        cur.execute("INSERT INTO PERMISSION VALUES (?,?)", (id, traffic[id]))


    with open(os.path.join(basePath, 'UsersList.json'), encoding="utf8") as f:
        traffic = json.load(f)

    id = 0
    for row in traffic:
        if id >= limit:
            break
        else:
            cur.execute("INSERT INTO USER VALUES (?,?,?,?,?,?,?)", (id, row['Name'], row['Phone'], row['Email'], row['Gender'], row['Birthday'], row['Address']))
            cur.execute("INSERT INTO LOGIN_INFO VALUES (?,?,?)", (id, row['Username'], row['Password']))
            id += 1

    with open(os.path.join(basePath, 'HotelsList.json'), encoding="utf8") as f:
        traffic = json.load(f)

    for row in traffic:
        cur.execute("INSERT INTO HOTEL VALUES (?,?,?)", (row['ID'], row['Name'], row['Address']))

    with open(os.path.join(basePath, 'RoomsList.json'), encoding="utf8") as f:
        traffic = json.load(f)

    for row in traffic:
        cur.execute("INSERT INTO ROOM VALUES (?,?,?,?,?)", (row['Room'], row['Room'][0], row['Price'], row['BedNum'], None))
        Fur = 4*[None]
        for i in range(len(row['InRoom'])):
            Fur[i] = row['InRoom'][i]
        cur.execute("INSERT INTO FURNITURE VALUES (?,?,?,?,?)", (row['Room'], Fur[0], Fur[1], Fur[2], Fur[3]))

    with open(os.path.join(basePath, 'UserPermissions.json'), encoding="utf8") as f:
        traffic = json.load(f)

    id = 0

    for row in traffic:
        if id >= limit:
            break
        else:
            #get id of user from username in login_info
            cur.execute("SELECT USER_ID FROM LOGIN_INFO WHERE USERNAME = ?", (row['Username'],))
            ID = cur.fetchone()[0]

            for i in range(len(row['perm'])):
                #get permission id from permission name
                cur.execute("SELECT PERMISSION_ID FROM PERMISSION WHERE PERMISSION_NAME = ?", (row['perm'][i],))
                permID = cur.fetchone()[0]

                cur.execute("INSERT INTO USER_PERMISSION VALUES (?,?)", (ID, permID))
        
            id += 1