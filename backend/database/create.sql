-- Create tables.

CREATE TABLE Person (
    id BIGINT PRIMARY KEY,
    name VARCHAR(256) NOT NULL,
    token VARCHAR(256),
    last_active TIMESTAMP
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
    person BIGINT NOT NULL REFERENCES Person(id),
    university INTEGER NOT NULL REFERENCES University(id),
    degree_type VARCHAR(256) NOT NULL,
    startdate TIMESTAMP NOT NULL,
    enddate TIMESTAMP
);

CREATE TABLE Experience (
    id SERIAL PRIMARY KEY,
    person BIGINT NOT NULL REFERENCES Person(id),
    company INTEGER NOT NULL REFERENCES Company(id),
    position VARCHAR(256) NOT NULL,
    startdate TIMESTAMP NOT NULL,
    enddate TIMESTAMP
);

CREATE TABLE Referrals (
    id SERIAL NOT NULL PRIMARY KEY,
    sender BIGINT NOT NULL REFERENCES Person(id),
    recipient BIGINT NOT NULL REFERENCES Person(id),
    company INTEGER REFERENCES Company(id),
    status VARCHAR(256) NOT NULL CHECK (status = 'requested' or status = 'granted' or status = 'offered' or status = 'denied' or status = 'rejected'),
    timestamp TIMESTAMP NOT NULL
);

-- Create triggers and indexes for Person and Referrals.
-- Considerably speeds up filter query.

CREATE OR REPLACE FUNCTION process_update_last_active() RETURNS TRIGGER AS $update_last_active$
    BEGIN
        UPDATE Person SET last_active = CURRENT_TIMESTAMP WHERE id = NEW.sender;
		UPDATE Person SET last_active = CURRENT_TIMESTAMP WHERE id = NEW.recipient;
        RETURN NULL;
    END;
$update_last_active$ LANGUAGE plpgsql;

CREATE TRIGGER update_last_active
	AFTER INSERT OR UPDATE ON Referrals
	    FOR EACH ROW
    	EXECUTE PROCEDURE process_update_last_active();

CREATE INDEX activity ON Person (last_active NULLS LAST);

-- Create views.
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
        AND (referrals.status = 'offered' OR referrals.status = 'granted' OR referrals.status = 'rejected')
        GROUP BY person.id
        ORDER BY value DESC
    ) AS t);

-- Impact: how often people referred by a user get the offer.

CREATE OR REPLACE VIEW impact AS
    (SELECT i.id, i.fraction, ROW_NUMBER () OVER (ORDER BY fraction DESC NULLS LAST) AS rank, ROUND((1 - ROW_NUMBER () OVER (ORDER BY fraction DESC NULLS LAST) / (
        SELECT COUNT(*)
        FROM person
    )::decimal) * 100) AS percentile
    FROM (
        SELECT person.id, 
            (COUNT(case referrals.status when 'offered' then 1 else null end)::decimal / 
            NULLIF(
                (COUNT(case referrals.status when 'offered' then 1 else null end) + 
                COUNT(case referrals.status when 'rejected' then 1 else null end) + 
                COUNT(case referrals.status when 'granted' then 1 else null end)), 
            0)) AS fraction
        FROM person, referrals
        WHERE person.id = referrals.sender
        GROUP BY person.id
        ORDER BY fraction DESC NULLS LAST
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
    (SELECT s.id, s.fraction, ROW_NUMBER () OVER (ORDER BY fraction DESC NULLS LAST) AS rank, ROUND((1 - ROW_NUMBER () OVER (ORDER BY fraction DESC NULLS LAST) / (
        SELECT COUNT(*)
        FROM person
    )::decimal) * 100) AS percentile
    FROM (
        SELECT person.id, 
            (COUNT(case referrals.status when 'offered' then 1 else null end)::decimal / 
            NULLIF(
                (COUNT(case referrals.status when 'offered' then 1 else null end) + 
                COUNT(case referrals.status when 'rejected' then 1 else null end) + 
                COUNT(case referrals.status when 'granted' then 1 else null end)), 
            0)) AS fraction
        FROM person, referrals
        WHERE person.id = referrals.recipient
        GROUP BY person.id
        ORDER BY fraction DESC NULLS LAST
    ) AS s);

-- Qualities: lists the percentile for each user for each quality.

CREATE OR REPLACE VIEW qualities AS
    (SELECT Person.id, 
        Generosity.percentile AS generosity, 
        Impact.percentile AS impact, 
        Popularity.percentile AS popularity, 
        Success.percentile AS success
    FROM Person
        FULL OUTER JOIN Generosity ON Person.id = Generosity.id
        FULL OUTER JOIN Impact ON Person.id = Impact.id
        FULL OUTER JOIN Popularity ON Person.id = Popularity.id
        FULL OUTER JOIN Success ON Person.id = Success.id);