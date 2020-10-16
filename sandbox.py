from json import load, dump
data = load(open("db.json", encoding='utf-8'))
print(data["tasks"][0])
