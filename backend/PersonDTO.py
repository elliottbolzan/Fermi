#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Nov  3 00:08:30 2018

@author: Thara
"""

class PersonDTO():
    def __init__(self, id, name, education, experience, qualities, lastActive):
        self.id = id
        self.name = name
        self.education = education
        self.experience = experience
        self.qualities = qualities
        self.lastActive = lastActive

    def serialize(self): 
        return {
            'id': self.id,
            'name': self.name,
            'education': [x.serialize() for x in self.education],
            'experience': [x.serialize() for x in self.experience],
            'qualities': [x.serialize() for x in self.qualities],
            'last_active': self.lastActive
        }	
