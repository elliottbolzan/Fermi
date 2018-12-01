#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Nov  3 00:08:30 2018

@author: Thara
"""

class PersonDTO():
    def __init__(self, id, name):
        self.id = id
        self.name = name

    def serialize(self): 
        return {
            'id': self.id,
            'name': self.name,
        }	
