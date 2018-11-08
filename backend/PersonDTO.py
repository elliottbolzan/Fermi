#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Nov  3 00:08:30 2018

@author: Thara
"""

class PersonDTO():
    def __init__(self, id, name, email):
        self.id = id
        self.name = name
        self.email = email

    def serialize(self): 
        return {
            'id': self.id,
            'name': self.name,
            'email': self.email
        }	
