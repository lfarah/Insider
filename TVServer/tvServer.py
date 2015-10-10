# -*- coding: UTF-8 -*-
from flask import Flask, request, redirect, session, url_for
import os
import json
app = Flask(__name__)


@app.route("/")
def index():

    with open('users.json',"r") as data_file:    
        data = json.load(data_file)
        return json.dumps(data)

def str_to_bool(s):
    if s == 'true':
         return True
    elif s == 'false':
         return False
    else:
         raise ValueError # evil ValueError that doesn't tell you what the wrong value was


@app.route("/addUser")
def get_obj_index():
    userEmail = str(request.args['email'])
    userPassword = str(request.args['password'])
    userName = str(request.args['name'])

    userToAdd = {"email":userEmail,"password":userPassword,"name":userName,"isActive":False}
    with open('users.json',"r+") as data_file:    
        data = json.load(data_file)
        data.append(userToAdd)
        jsonFile = open("users.json", "w+")
        jsonFile.write(json.dumps(data))
        jsonFile.close()
        return "YUP"

# http://0.0.0.0:5000/addUser?email=luamecom&password=potato&name=John
@app.route("/updateUser")
def getO():
    userId = str(request.args['id'])
    userIsIn = request.args['isIn']
    print(userIsIn)
    with open('users.json',"r+") as data_file:    
        data = json.load(data_file)
        for user in data:
            if user["email"] == userId:
                data[data.index(user)]["isActive"] = str_to_bool(userIsIn)
                jsonFile = open("users.json", "w+")
                jsonFile.write(json.dumps(data))
                jsonFile.close()

    return "yup"


@app.route('/upload', methods=['GET', 'POST'])
def upload():
    if request.method == 'POST':
        file = request.files['file']
        extension = os.path.splitext(file.filename)[1]
        f_name = str(uuid.uuid4()) + extension
        file.save(os.path.join(app.config['UPLOAD_FOLDER'], f_name))
        return json.dumps({'filename':f_name})

        # http://0.0.0.0:5000/upload

@app.route("/getObjectForName")
def get_obj_name():
    array_names = []
    i = 0
        #for dc in json.loads(index()):
    for dc in json.loads(index()):
        if "name" in dc:
            item = dc["name"]
            array_names.append(item)
    index_of_element = array_names.index(request.args['name'])
    #return "INDEX:" + str(index_of_element) + " - " + str(json.loads(index())[index_of_element]["name"]) + " out of " + str(len(arrayNames))
    return str(json.loads(index())[index_of_element])
        #i+=1
        # arrayNames.append(dc["name"])
        # dc = json.loads(index())[56]["name"]
        #array.append(js["name"])
    ## Ex: http://127.0.0.1:5000/getObject?index=10

# if __name__ == "__main__":
#     app.run(host='0.0.0.0')
if __name__ == "__main__":
    port = int(os.environ.get("PORT", 5000))
    app.run(host='0.0.0.0', port=port)