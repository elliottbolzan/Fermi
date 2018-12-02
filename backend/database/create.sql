CREATE TABLE Person (
    id INTEGER PRIMARY KEY,
    name VARCHAR(256) NOT NULL
);

CREATE TABLE Company (
    id SERIAL PRIMARY KEY,
    name VARCHAR(256) NOT NULL
);

CREATE TABLE University (
    id SERIAL PRIMARY KEY,
    name VARCHAR(256) NOT NULL
);

CREATE TABLE Education (
    id SERIAL PRIMARY KEY,
    person INTEGER NOT NULL REFERENCES Person(id),
    university INTEGER NOT NULL REFERENCES University(id),
    degree_type VARCHAR(256) NOT NULL,
    startdate TIMESTAMP NOT NULL,
    enddate TIMESTAMP
);

CREATE TABLE Experience (
    id SERIAL PRIMARY KEY,
    person INTEGER NOT NULL REFERENCES Person(id),
    company INTEGER NOT NULL REFERENCES Company(id),
    position VARCHAR(256) NOT NULL,
    startdate TIMESTAMP NOT NULL,
    enddate TIMESTAMP
);

CREATE TABLE Referrals (
    id SERIAL NOT NULL PRIMARY KEY,
    sender INTEGER NOT NULL REFERENCES Person(id),
    recipient INTEGER NOT NULL REFERENCES Person(id),
    company INTEGER REFERENCES Company(id),
    status VARCHAR(256) NOT NULL CHECK (status = 'requested' or status = 'granted' or status = 'offered' or status = 'denied' or status = 'rejected'),
    timestamp TIMESTAMP NOT NULL
);

-- Generosity: how often a user refers people.

CREATE OR REPLACE VIEW generosity AS
    (SELECT t.id, t.value, ROW_NUMBER () OVER (ORDER BY value DESC) AS rank, ROUND((1 - ROW_NUMBER () OVER (ORDER BY value DESC) / (
        SELECT COUNT(*)
        FROM person
    )::decimal) * 100) AS percentile
    FROM (
        SELECT person.id, COUNT(*) AS value
        FROM person, referrals
        WHERE person.id = referrals.sender
        GROUP BY person.id
        ORDER BY value DESC
    ) AS t);

-- Impact: how often people referred by a user get the offer.

CREATE OR REPLACE VIEW impact AS
    (SELECT i.id, i.fraction, ROW_NUMBER () OVER (ORDER BY fraction DESC) AS rank, ROUND((1 - ROW_NUMBER () OVER (ORDER BY fraction DESC) / (
        SELECT COUNT(*)
        FROM person
    )::decimal) * 100) AS percentile
    FROM (
        SELECT person.id, 
        COALESCE(
            (COUNT(case referrals.status when 'offered' then 1 else null end)::decimal / 
            NULLIF(
                (COUNT(case referrals.status when 'offered' then 1 else null end) + 
                COUNT(case referrals.status when 'rejected' then 1 else null end) + 
                COUNT(case referrals.status when 'granted' then 1 else null end)), 
            0)), 
        0) AS fraction
        FROM person, referrals
        WHERE person.id = referrals.sender
        GROUP BY person.id
        ORDER BY fraction DESC
    ) AS i);

-- Popularity: how often a user has been referred.

CREATE OR REPLACE VIEW popularity AS
    (SELECT t.id, t.value, ROW_NUMBER () OVER (ORDER BY value DESC) AS rank, ROUND((1 - ROW_NUMBER () OVER (ORDER BY value DESC) / (
        SELECT COUNT(*)
        FROM person
    )::decimal) * 100) AS percentile
    FROM (
        SELECT person.id, COUNT(*) AS value
        FROM person, referrals
        WHERE person.id = referrals.recipient
        GROUP BY person.id
        ORDER BY value DESC
    ) AS t);

-- Success: how often a user gets the job after having been referred.

CREATE OR REPLACE VIEW success AS
    (SELECT s.id, s.fraction, ROW_NUMBER () OVER (ORDER BY fraction DESC) AS rank, ROUND((1 - ROW_NUMBER () OVER (ORDER BY fraction DESC) / (
        SELECT COUNT(*)
        FROM person
    )::decimal) * 100) AS percentile
    FROM (
        SELECT person.id, 
        COALESCE(
            (COUNT(case referrals.status when 'offered' then 1 else null end)::decimal / 
            NULLIF(
                (COUNT(case referrals.status when 'offered' then 1 else null end) + 
                COUNT(case referrals.status when 'rejected' then 1 else null end) + 
                COUNT(case referrals.status when 'granted' then 1 else null end)), 
            0)), 
        0) AS fraction
        FROM person, referrals
        WHERE person.id = referrals.recipient
        GROUP BY person.id
        ORDER BY fraction DESC
    ) AS s);

-- Qualities: lists the percentile for each user for each quality.

CREATE OR REPLACE VIEW qualities AS
    (SELECT generosity.id, 
        generosity.percentile AS generosity, 
        impact.percentile AS impact, 
        popularity.percentile AS popularity, 
        success.percentile AS success
    FROM generosity 
        JOIN impact ON generosity.id = impact.id
        JOIN popularity ON generosity.id = popularity.id
        JOIN success ON generosity.id = success.id);