#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Nov  3 00:30:35 2018

@author: Thara
"""

from flask import Flask

@app.route('/')
def index():
    fakeDTO = UserDTO(1, "EllDawg Bolognese", "eldawg.org")
    insertFake = UserDAO()
    insertFake.insert(fakeDTO)
    
    
    
    