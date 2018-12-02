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
from ReferralDAO import ReferralDAO
from ReferralDAO import ReferralDTO

app = Flask(__name__)
app.secret_key = 'mongoose69'

@app.route('/user/<identifier>', methods=['GET'])
def getUser(identifier = None):
    dao = PersonDAO()
    user = dao.getPerson(identifier)
    print(user)
    return jsonify(user.serialize())

@app.route('/user/create', methods=['POST'])
def createUser():
    dao = PersonDAO()
    content = request.get_json()
    user = dao.createPerson(content['id'], content['name'])
    return jsonify(user.serialize())

@app.route('/user/filter', methods=['POST'])
def filter():
    dao = PersonDAO()
    filtered = dao.filter(request.get_json())
    return jsonify([x.serialize() for x in filtered])

@app.route('/referrals/create', methods=['POST'])
def createReferral():
    dao = ReferralDAO()
    content = request.get_json()
    result = dao.createReferral(ReferralDTO(-1, content['sender'], content['recipient'], content['company'], content['status']))
    return jsonify(result.serialize())

@app.route('/referrals/update', methods=['POST'])
def updateReferral():
    dao = ReferralDAO()
    content = request.get_json()
    result = dao.updateReferral(ReferralDTO(content['id'], content['sender'], content['recipient'], content['company'], content['status']))
    return jsonify(result.serialize())

if __name__ == '__main__':
    app.run(host='0.0.0.0', port = 5000, debug = True)