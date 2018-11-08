#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Nov  3 00:30:35 2018

@author: Thara
"""
import json 
from flask import Flask
from flask import jsonify 
from PersonDAO import PersonDAO
from PersonDAO import PersonDTO

app = Flask(__name__)
app.secret_key = 'mongoose69'

@app.route('/example/')
def selectFake():
    selectFake = PersonDAO()
    fakePersonList = selectFake.selectFromPerson()
    #print([x.serialize() for x in fakePersonList])
    return jsonify([x.serialize() for x in fakePersonList])

@app.route('/insert/')
def insertFake():
    fakeDTO = PersonDTO(1, "EllDawg Bolognese", "eldawg.org")
    insertFake = PersonDAO()
    insertFake.insertToPerson(fakeDTO)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
    
    
    
