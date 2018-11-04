CREATE TABLE Person (
    id INTEGER PRIMARY KEY,
    name VARCHAR(256) NOT NULL,
    email VARCHAR(256) NOT NULL
);

CREATE TABLE Referrals (
    id INTEGER PRIMARY KEY,
    timestamp TIMESTAMP NOT NULL,
    status BOOLEAN NOT NULL,
    recipient INTEGER NOT NULL REFERENCES Person(id),
    sender INTEGER NOT NULL REFERENCES Person(id)
);

CREATE TABLE Education (
    id INTEGER PRIMARY KEY,
    person_id INTEGER NOT NULL,
    university_name VARCHAR(256) NOT NULL,
    degree_type VARCHAR(256) NOT NULL,
    FOREIGN KEY (person_id) REFERENCES Person(id)
);

CREATE TABLE Profession (
    id INTEGER PRIMARY KEY,
    person_id INTEGER NOT NULL,
    company VARCHAR(256) NOT NULL,
    startdate TIMESTAMP NOT NULL,
    enddate TIMESTAMP,
    position VARCHAR(256) NOT NULL,
    FOREIGN KEY (person_id) REFERENCES Person(id)
);