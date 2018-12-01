#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Nov  3 00:30:35 2018

@author: Thara
"""
import json
from flask import Flask, request, jsonify
from PersonDAO import PersonDAO
from PersonDAO import PersonDTO

app = Flask(__name__)
app.secret_key = 'mongoose69'


"""
@app.route('/user/create/', methods = ['GET'])
def userCreate(facebookID, fullName):
    createUser = PersonDAO()
    myUser = PersonDTO(facebookID, fullName, None)
    userInfo = createUser.insertToPerson(myUser)
    
"""
    
#works
@app.route('/select/')
def selectFake():
    selectFake = PersonDAO()
    fakePersonList = selectFake.selectFromPerson()
    #print([x.serialize() for x in fakePersonList])
    return jsonify([x.serialize() for x in fakePersonList])

@app.route('/user/create', methods=['POST'])
def userCreate():
    createUser = PersonDAO()
    content = request.get_json(force = True)
    myUser = PersonDTO(content['id'], content['name'])
    userInfo = createUser.insertToPerson(myUser)
    print(userInfo)
    #return jsonify(userInfo.serialize())

#works
@app.route('/filter', methods=['POST'])
def filter():
    Person = PersonDAO()
    print(request.json)
    filteredPeople = Person.filter(request.json["params"])
    #print(request.json)
    #print([x.serialize() for x in fakePersonList])
    
    return "received"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug = True)
    
    
    
