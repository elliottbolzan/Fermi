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
from ReferralDTO import ReferralDTO
from Authorization import Authorization

app = Flask(__name__)
app.secret_key = 'mongoose69'

unauthorized = "Unauthorized call to Fermi's API. Please use a valid authorization token."

@app.route('/user/<identifier>', methods=['GET'])
def getUser(identifier = None):
    dao = PersonDAO()
    if not Authorization().authorized(request.headers):
        return unauthorized
    user = dao.getPerson(identifier)
    return jsonify(user.serialize())

@app.route('/user/create', methods=['POST'])
def createUser():
    dao = PersonDAO()
    content = request.get_json()
    user = dao.createPerson(content['id'], content['name'], content['token'])
    return jsonify(user.serialize())

@app.route('/user/filter', methods=['POST'])
def filter():
    dao = PersonDAO()
    if not Authorization().authorized(request.headers):
        return unauthorized
    filtered = dao.filter(request.get_json())
    return jsonify([x.serialize() for x in filtered])

@app.route('/referrals/create', methods=['POST'])
def createReferral():
    dao = ReferralDAO()
    if not Authorization().authorized(request.headers):
        return unauthorized
    content = request.get_json()
    result = dao.createReferral(ReferralDTO(-1, content['sender'], content['recipient'], -1, content['status']))
    return jsonify(result.serialize())

@app.route('/referrals/update', methods=['POST'])
def updateReferral():
    dao = ReferralDAO()
    if not Authorization().authorized(request.headers):
        return unauthorized
    content = request.get_json()
    result = dao.updateReferral(ReferralDTO(content['id'], content['sender'], content['recipient'], content['company'], content['status']))
    return jsonify(result.serialize())

if __name__ == '__main__':
    app.run(host='0.0.0.0', port = 5000, debug = True)