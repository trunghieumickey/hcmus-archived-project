import json, random
#open json file
with open(".github/testcases/PermissionsList.json", "r") as f:
    permission = json.load(f)

user_perm = [x for x in permission if x.split(".")[0] == 'user']
staff_perm = [x for x in permission if x.split(".")[0] in ['staff', 'admin']]

with open(".github/testcases/UsersList.json", "r", encoding= "utf-8") as f:
    users = json.load(f)
    users = [{"Username": x['Username']} for x in users]


for i in users:
    i["perm"] = []
    if random.random() < 0.9:
        i["perm"].append(user_perm[0])
        i["perm"].append(random.choice(user_perm[1:]))
        if random.random() < 0.9:
            continue
    i["perm"].append(staff_perm[0])
    i["perm"].append(random.choice(staff_perm[1:]))

with open(".github/testcases/UserPermissions.json", "w", encoding= "utf-8") as f:
    json.dump(users, f, indent=4)