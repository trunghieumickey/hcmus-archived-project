import os,csv,json

file_list = os.listdir("./data")
file_list = [file for file in file_list if file.endswith(".json")]
print("Found " + str(len(file_list)) + " files!")

#create a new csv file
file = open("data.csv", "w", encoding="utf-8")
meta = open("meta.csv", "w", encoding="utf-8")

#write meta.csv
meta_writer = csv.writer(meta)
meta_writer.writerow(["code", "key", "content"])

#write data.csv
writer = csv.writer(file)
writer.writerow(["code", "title", "price", "image"])

for file_name in file_list:
    with open("./data/" + file_name, "r", encoding="utf-8") as f:
        data = json.load(f)
        writer.writerow([data["code"], data["title"], data["price"], data["image"]])
        for key in data["info"]:
            meta_writer.writerow([data["code"], key, data["info"][key]])
        print("Added " + file_name + "!")
print("Pushed total of " + str(len(file_list)) + " products!")
file.close()
meta.close()
