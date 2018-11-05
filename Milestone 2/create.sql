CREATE TABLE Person (
    id INTEGER PRIMARY KEY,
    name VARCHAR(256) NOT NULL,
    email VARCHAR(256) NOT NULL
);

CREATE TABLE Company (
    id INTEGER PRIMARY KEY,
    name VARCHAR(256) NOT NULL
);

CREATE TABLE University (
    id INTEGER PRIMARY KEY,
    name VARCHAR(256) NOT NULL
);

CREATE TABLE Education (
    id INTEGER PRIMARY KEY,
    person INTEGER NOT NULL REFERENCES Person(id),
    university INTEGER NOT NULL REFERENCES University(id),
    degree_type VARCHAR(256) NOT NULL,
    startdate TIMESTAMP NOT NULL,
    enddate TIMESTAMP
);

CREATE TABLE Experience (
    id INTEGER PRIMARY KEY,
    person INTEGER NOT NULL REFERENCES Person(id),
    company INTEGER NOT NULL REFERENCES Company(id),
    position VARCHAR(256) NOT NULL,
    startdate TIMESTAMP NOT NULL,
    enddate TIMESTAMP
);

CREATE TABLE Referrals (
    id INTEGER NOT NULL PRIMARY KEY,
    sender INTEGER NOT NULL REFERENCES Person(id),
    recipient INTEGER NOT NULL REFERENCES Person(id),
    company INTEGER REFERENCES Company(id),
    status BOOLEAN NOT NULL,
    timestamp TIMESTAMP NOT NULL
);
