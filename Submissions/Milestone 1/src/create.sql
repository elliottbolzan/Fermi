CREATE TABLE Condition
(id INTEGER PRIMARY KEY, 
 name VARCHAR NOT NULL
 );

CREATE TABLE Disease
(id INTEGER REFERENCES Condition(id),
 description VARCHAR, 
 PRIMARY KEY(id)
);

CREATE TABLE Category
(id INTEGER PRIMARY KEY,
 name VARCHAR,
 description VARCHAR
);

CREATE TABLE Symptom
(id INTEGER REFERENCES Condition(id),
 severity INTEGER,
 PRIMARY KEY(id)
);

CREATE TABLE AssociatedWith
(symptomid INTEGER REFERENCES Symptom(id),
 diseaseid INTEGER REFERENCES Disease(id),
 PRIMARY KEY(symptomid, diseaseid)
);

CREATE TABLE OfType
(diseaseid INTEGER REFERENCES Disease(id),
 categoryid INTEGER REFERENCES Category(id),
 PRIMARY KEY(diseaseid, categoryid)
);

CREATE TABLE Profile
(id INTEGER PRIMARY KEY,
 age INTEGER NOT NULL,
 gender CHAR(4) NOT NULL CHECK (gender = 'F' or gender = 'M' or gender = 'B')
 );

CREATE TABLE Has
(profileid INTEGER REFERENCES Profile(id),
 conditionid INTEGER REFERENCES Condition(id),
 PRIMARY KEY(profileid, conditionid)
);