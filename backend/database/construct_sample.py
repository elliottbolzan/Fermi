# This file generates a load.sql file from source data.
# Specify the configuration below.

import random
from datetime import datetime, timedelta

NUMBER_OF_USERS = 10000
NUMBER_OF_REFERRALS = 50000 
PROB_REFERRAL_SUCCESS = 3 # 1 in 3 chance of succeeding.
START_DATE = '2010-1-1'
END_DATE = '2019-1-1'

class Company:
    def __init__(self, identifier, name):
        self.identifier = identifier
        self.name = name.replace("'", "''")
    
    def create(self):
        return "INSERT INTO Company VALUES (DEFAULT, \'%s\');\n" % (self.name)

class University:
    def __init__(self, identifier, name):
        self.identifier = identifier
        self.name = name.replace("'", "''")

    def create(self):
        return "INSERT INTO University VALUES (DEFAULT, \'%s\');\n" % (self.name)

class Person:
    def __init__(self, identifier, first, last, company, position):
        self.identifier = identifier
        self.name = first + " " + last
        self.name = self.name.replace("'", "''")
        self.company = company
        self.position = position
    
    def create(self):
        return "INSERT INTO Person VALUES (%d, \'%s\');\n" % (self.identifier, self.name)

def generate():

    universities_raw = load("source/universities.txt")
    companies_raw = load("source/companies.txt")
    jobs = load("source/jobs.txt")
    male = load("source/male.txt")
    female = load("source/female.txt")
    last = load("source/last.txt")
    
    with open("load.sql", "w") as output:

        universities = []
        for i in range(len(universities_raw)):
            university = University(i + 1, universities_raw[i])
            output.write(university.create())
            universities.append(university)
        
        companies = []
        for i in range(len(companies_raw)):
            company = Company(i + 1, companies_raw[i])
            output.write(company.create())
            companies.append(company)

        persons = []
        for i in range(NUMBER_OF_USERS):
            first = randomFrom(female)
            if i % 2:
                first = randomFrom(male)
            person = Person(i + 1, first, randomFrom(last), randomFrom(companies), randomFrom(jobs))
            output.write(person.create())
            persons.append(person)
                
        for i in range(len(persons)):
            person = persons[i]
            output.write("INSERT INTO Experience VALUES (DEFAULT, %s, %s, \'%s\', TIMESTAMP \'%s\', NULL);\n" % (person.identifier, person.company.identifier, person.position, getTimestamp()))

        for person in persons:
            if random.randint(1, 100) >= 15:
                start = getTimestamp()
                end = getTimestamp(start)
                output.write("INSERT INTO Education VALUES (DEFAULT, %s, %s, \'Bachelors\', TIMESTAMP \'%s\', TIMESTAMP \'%s\');\n" % (person.identifier, randomFrom(universities).identifier, start, end))
                if random.randint(1, 100) >= 50:
                    start = getTimestamp(end)
                    end = getTimestamp(start)
                    output.write("INSERT INTO Education VALUES (DEFAULT, %s, %s, \'Masters\', TIMESTAMP \'%s\', TIMESTAMP \'%s\');\n" % (person.identifier, randomFrom(universities).identifier, start, end))
                    if random.randint(1, 100) >= 50:
                        start = getTimestamp(end)
                        end = getTimestamp(start)
                        output.write("INSERT INTO Education VALUES (DEFAULT, %s, %s, \'Doctorate\', TIMESTAMP \'%s\', TIMESTAMP \'%s\');\n" % (person.identifier, randomFrom(universities).identifier, start, end))

        for i in range(NUMBER_OF_REFERRALS):
            A = randomFrom(persons)
            B = randomFrom(persons)
            if A != B:
                success = randomFrom(["requested", "granted", "offered", "denied", "rejected"])
                timestamp = getTimestamp()
                output.write("INSERT INTO Referrals VALUES (DEFAULT, %s, %s, %s, \'%s\', TIMESTAMP \'%s\');\n" % (A.identifier, B.identifier, A.company.identifier, success, timestamp))

def load(filename):
    output = []
    with open(filename, "r") as file:
        for entry in file.readlines():
            output.append(entry.replace("\n", ""))
    return output

def randomFrom(array):
    return array[random.randint(0, len(array) - 1)]

def random_date(start, end):
    return start + timedelta(
        seconds = random.randint(0, int((end - start).total_seconds())),
    )

def getTimestamp(start = START_DATE, end = END_DATE):
    value = random_date(datetime.strptime(start, '%Y-%m-%d'), datetime.strptime(end, '%Y-%m-%d'))
    return datetime.strftime(value, '%Y-%m-%d')

generate()