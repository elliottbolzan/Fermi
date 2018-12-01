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

@app.route('/')
def insertFake():
    createUser = PersonDAO()
    myUser = PersonDTO(1, "EllDawg Bolognese")
    userInfo = createUser.insertToPerson(myUser)
    return jsonify(userInfo.serialize())

#works
@app.route('/filter', methods=['POST'])
def filter():
    Person = PersonDAO()
    parameters = request.get_json()
    filtered = Person.filter(parameters)
    print(filtered)
    return jsonify(filtered)
    #print([x.serialize() for x in fakePersonList])

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug = True)