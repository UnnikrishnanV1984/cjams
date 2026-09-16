DELETE FROM cjams.schoollistreference
WHERE county IN (
    'Allegany',
    'Annapolis',
    'Anne Arundel',
    'Baltimore City',
    'Baltimore',
    'Caroline',
    'Carroll',
    'Cecil',
    'Charles',
    'Dorchester',
    'Frederick',
    'Garrett',
    'Harford',
    'Howard',
    'Kent',
    'Montgomery',
    'Prince Georges',
    'Queen Annes',
    'Severna',
    'Somerset County',
    'St Marys',
    'Talbot County',
    'Washington',
    'Wicomico',
    'Worcester'
);



--Allegany 

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Allegany High School', '900 Seton Drive', 'Cumberland', 'Maryland', '21502', 'Allegany', '301-777-8110', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Beall Elementary School', '3 East College Avenue', 'Frostburg', 'Maryland', '21532', 'Allegany', '301-689-3636', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Bel Air Elementary School', '14401 Barton Boulevard', 'Cumberland', 'Maryland', '21502', 'Allegany', '301-729-2992', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Braddock Middle School', '909 Holland Street', 'Cumberland', 'Maryland', '21502', 'Allegany', '301-777-7990', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Cash Valley Elementary School', '10601 Cash Valley Rd. NW', 'LaVale', 'Maryland', '21502', 'Allegany', '301-724-6632', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Center for Career & Technical Education', '14211 McMullen Highway', 'Cresaptown', 'Maryland', '21502', 'Allegany', '301-729-6486', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Cresaptown Elementary School', '13202 Sixth Avenue', 'Cresaptown', 'Maryland', '21502', 'Allegany', '301-729-0212', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Flintstone Elementary School', '22000 National Pike NE', 'Flinstone', 'Maryland', '21530', 'Allegany', '301-478-2434', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Fort Hill High School', '500 Greenway Avenue', 'Cumberland', 'Maryland', '21502', 'Allegany', '301-777-2570', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Frost Elementary School', '260 Shaw Street', 'Frostburg', 'Maryland', '21532', 'Allegany', '301-689-5168', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('George''s Creek Elementary School', '15600 Lower George''s Creek Rd', 'Lonaconing', 'Maryland', '21539', 'Allegany', '301-463-6202', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('John Humbird Elementary School', '120 East Mary Street', 'Cumbarland', 'Maryland', '21502', 'Allegany', '301-724-8842', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Mount Savage School (K-8)', '13201 New School Road, NW', 'Mt. Savage', 'Maryland', '21545', 'Allegany', '301-264-3220', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Mountain Ridge High School', '100 Dr. Nancy S. Grasmick Lane', 'Frostburg', 'Maryland', '21532', 'Allegany', '301-689-3377', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Northeast Elementary School', '11001 Forest Avenue', 'Cumberland', 'Maryland', '21502', 'Allegany', '301-724-3285', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Parkside Elementary School', '50 Parkside Boulevard', 'LaVale', 'Maryland', '21502', 'Allegany', '301-729-0085', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('RESTART Program at Eckhart School', '17000 National Hwy. SW', 'Frostburg', 'Maryland', '21532', 'Allegany', '301-689-3483', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('South Penn Elementary School', '500 East Second Street', 'Cumberland', 'Maryland', '21502', 'Allegany', '301-777-1755', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Washington Middle School', '200 N. Massachusetts Avenue', 'Cumberland', 'Maryland', '21502', 'Allegany', '301-777-5360', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('West Side Elementary School', '425 Paca Street', 'Cumberland', 'Maryland', '21502', 'Allegany', '301-724-0340', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Westernport Elementary School', '172 Church Street', 'Westernport', 'Maryland', '21562', 'Allegany', '301-359-0511', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Westmar Middle School', '16915 Lower George''s Creek Road', 'Lonaconing', 'Maryland', '21539', 'Allegany', '301-463-5751', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Sheppard Pratt School (Cumberland)', '10100 Country Club Road SE', 'Cumberland', 'Maryland', '21502', 'Allegany', '301-777-2258', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

--Anne Arundel
INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Annapolis Elementary School', '180 Green Street', 'Annapolis', 'Maryland', '21401', 'Anne Arundel', '410-222-1600', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Arnold Elementary School', '95 Joyce Lane East', 'Arnold', 'Maryland', '21012', 'Anne Arundel', '410-757-4400', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Belle Grove Elementary School', '4502 Belle Grove Road', 'Baltimore', 'Maryland', '21225', 'Anne Arundel', '410-222-6589', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Belvedere Elementary School', '360 Broadwater Road', 'Arnold', 'Maryland', '21012', 'Anne Arundel', '410-975-9432', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Benfield Elementary School', '365 Lynwood Drive', 'Severna Park', 'Maryland', '21146', 'Anne Arundel', '410-222-6555', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Bodkin Elementary School', '8320 Ventnor Road', 'Pasadena', 'Maryland', '21122', 'Anne Arundel', '410-437-0464', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Broadneck Elementary School', '470 Shore Acres Road', 'Arnold', 'Maryland', '21012', 'Anne Arundel', '410-222-1680', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Brock Bridge Elementary School', '405 Brock Bridge Road', 'Laurel', 'Maryland', '20724', 'Anne Arundel', '301-498-6280', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Brooklyn Park Elementary School', '200 14th Avenue', 'Baltimore', 'Maryland', '21225', 'Anne Arundel', '410-222-6590', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Cape St. Claire Elementary School', '931 Blue Ridge Drive', 'Annapolis', 'Maryland', '21409', 'Anne Arundel', '410-222-1685', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Carrie Weedon Early Education Center', '911 Galesville Road', 'Galesville', 'Maryland', '20765', 'Anne Arundel', '410-222-1685', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Central Elementary School', '130 Stepney Lane', 'Edgewater', 'Maryland', '21037', 'Anne Arundel', '410-222-1075', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Crofton Elementary School', '1405 Duke of Kent Drive', 'Crofton', 'Maryland', '21114', 'Anne Arundel', '410-222-5800', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Crofton Meadows Elementary School', '2020 Tilghman Drive', 'Crofton', 'Maryland', '21114', 'Anne Arundel', '410-721-9453', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Crofton Woods Elementary School', '1750 Urby Drive', 'Crofton', 'Maryland', '21114', 'Anne Arundel', '410-222-5805', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Davidsonville Elementary School', '962 W. Central Avenue', 'Davidsonville', 'Maryland', '21035', 'Anne Arundel', '410-222-1655', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Deale Elementary School', '759 Masons Beach Road', 'Deale', 'Maryland', '20751', 'Anne Arundel', '410-222-1695', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Eastport Elementary School', '420 Fifth Street', 'Annapolis', 'Maryland', '21403', 'Anne Arundel', '410-222-1605', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Edgewater Elementary School', '121 Washington Road', 'Edgewater', 'Maryland', '21037', 'Anne Arundel', '410-956-0830', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Ferndale Early Education Center', '105 Packard Avenue', 'Glen Burnie', 'Maryland', '21061', 'Anne Arundel', '410-590-4790', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Folger Mckinsey Elementary School', '175 Arundel Beach Road', 'Severna Park', 'Maryland', '21146', 'Anne Arundel', '410-222-6560', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Fort Smallwood Elementary School', '1720 Poplar Ridge Road', 'Pasadena', 'Maryland', '21122', 'Anne Arundel', '410-222-6450', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Four Seasons Elementary School', '979 Waugh Chapel Road', 'Gambrills', 'Maryland', '21054', 'Anne Arundel', '410-222-6501', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Freetown Elementary School', '7904 Freetown Road', 'Glen Burnie', 'Maryland', '21060', 'Anne Arundel', '410-787-5610', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('George Cromwell Elementary School', '221 Olen Drive', 'Glen Burnie', 'Maryland', '21060', 'Anne Arundel', '410-787-6100', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Georgetown East Elementary School', '111 Dogwood Road', 'Annapolis', 'Maryland', '21403', 'Anne Arundel', '410-222-1610', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Germantown Elementary School', '200 Windell Avenue', 'Annapolis', 'Maryland', '21401', 'Anne Arundel', '410-222-1615', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Glen Burnie Park Elementary School', '500 Marlboro Road', 'Glen Burnie', 'Maryland', '21061', 'Anne Arundel', '410-766-9220', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Glendale Elementary School', '105 Carroll Road', 'Glen Burnie', 'Maryland', '21060', 'Anne Arundel', '410-787-1410', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Hebron-Harman Elementary School', '7660 Ridge Chapel Road', 'Hanover', 'Maryland', '21076', 'Anne Arundel', '410-859-4510', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('High Point Elementary School', '7789 Edgewood Avenue', 'Pasadena', 'Maryland', '21122', 'Anne Arundel', '410-222-6454', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Hillsmere Elementary School', '3052 Arundel on the Bay Road', 'Annapolis', 'Maryland', '21403', 'Anne Arundel', '443-482-9280', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Hilltop Elementary School', '415 Melrose Avenue', 'Glen Burnie', 'Maryland', '21061', 'Anne Arundel', '410-424-2400', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Jacobsville Elementary School', '3801 Mountain Avenue', 'Pasadena', 'Maryland', '21122', 'Anne Arundel', '410-222-6460', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Jessup Elementary School', '2798 Champion Forest Avenue', 'Jessup', 'Maryland', '20794', 'Anne Arundel', '410-799-1200', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Jones Elementary School', '122 Hoyle Lane', 'Severna Park', 'Maryland', '21146', 'Anne Arundel', '410-222-6565', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Lake Shore Elementary School', '4531 Mountain Road', 'Pasadena', 'Maryland', '21122', 'Anne Arundel', '410-222-6465', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Lothian Elementary School', '5175 Solomons Island Road', 'Lothian', 'Maryland', '20711', 'Anne Arundel', '410-867-3900', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Manor View Elementary School', '2900 MacArthur Road', 'Ft. Meade', 'Maryland', '20755', 'Anne Arundel', '410-222-6504', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Marley Elementary School', '715 Cooper Road', 'Glen Burnie', 'Maryland', '21060', 'Anne Arundel', '410-424-3200', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Maryland City Elementary School', '3359 Crumpton South', 'Laurel', 'Maryland', '20724', 'Anne Arundel', '301-725-4256', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Mayo Elementary School', '1260 Mayo Ridge Road', 'Edgewater', 'Maryland', '21037', 'Anne Arundel', '410-798-9830', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Meade Heights Elementary School', '1925 Reece Road', 'Ft. Meade', 'Maryland', '20755', 'Anne Arundel', '410-222-6509', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Millersville Elementary School', '1601 Millersville Road', 'Millersville', 'Maryland', '21108', 'Anne Arundel', '410-222-3800', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Mills-Parole Elementary School', '1 George and Marion Phelps Lane', 'Annapolis', 'Maryland', '21401', 'Anne Arundel', '410-222-1626', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Nantucket Elementary School', '2350 Nantucket Drive', 'Crofton', 'Maryland', '21114', 'Anne Arundel', '410-451-6120', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('North Glen Elementary School', '615 West Furnace Branch', 'Glen Burnie', 'Maryland', '21061', 'Anne Arundel', '410-222-6416', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Oak Hill Elementary School', '34 Truckhouse Road', 'Severna Park', 'Maryland', '21146', 'Anne Arundel', '410-222-6568', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Oakwood Elementary School', '330 Oak Manor Drive', 'Glen Burnie', 'Maryland', '21061', 'Anne Arundel', '410-222-6420', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('The Harbour School at Annapolis', '1277 Green Holly Drive', 'Annapolis', 'Maryland', '21409', 'Anne Arundel', '410-974-4248', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('High Road School of Anne Arundel County', '1131 Benfield Boulevard', 'Millersville', 'Maryland', '21108', 'Anne Arundel', '410-846-5282', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('The Pathways School- Anne Arundel', '1819 Bay Ridge Avenue, Annapolis', ' Maryland', '21403', '410-295-1539', 'Anne Arundel', '410-295-1539', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Sheppard Pratt School (Millersville Elementary)', '1601 Millersville Road', 'Millersville', 'Maryland', '21108', 'Anne Arundel', '410-222-3800', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Sheppard Pratt School (Severn River Middle)', '241 Peninsula Farm Road', 'Arnold', 'Maryland', '21012', 'Anne Arundel', '410-544-0922', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Sheppard Pratt School (Severna Park High School)', '60 Robinson Road, 21146', ' Severna Park', 'Maryland', '21146', 'Anne Arundel', '410-544-0900', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('The Summit School', '664 East Centeral Avenue', 'Edgewater', 'Maryland', '21037', 'Anne Arundel', '410-798-0005', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;



--Baltimore City
INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Cecil Elementary School', '2000 Cecil Avenue', 'Baltimore', 'Maryland', '21218', 'Baltimore City', '410-396-6385', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('City Springs Elementary/Middle School', '100 S Caroline Street', 'Baltimore', 'Maryland', '21231', 'Baltimore City', '410-396-9165', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('James McHenry Elementary/Middle School', '31 S Schroeder Street', 'Baltimore', 'Maryland', '21223', 'Baltimore City', '410-396-1621', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Lakeland Elementary/Middle School', '2921 Stranden Road', 'Baltimore', 'Maryland', '21230', 'Baltimore City', '410-396-1406', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Tench Tilghman Elementary/Middle School', '600 N Patterson Park Avenue', 'Baltimore', 'Maryland', '21205', 'Baltimore City', '410-396-9247', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Stadium School', '1400 Exeter Hall Avenue', 'Baltimore', 'Maryland', '21218', 'Baltimore City', '443-984-2682', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Johnston Square Elementary School', '1101 Valley Street', 'Baltimore', 'Maryland', '21202', 'Baltimore City', '410-396-1477', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Hilton Elementary School', '3301 Carlisle Avenue', 'Baltimore', 'Maryland', '21216', 'Baltimore City', '410-396-0634', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('George Washington Elementary School', '800 Scott Street', 'Baltimore', 'Maryland', '21230', 'Baltimore City', '410-396-1445', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Wolfe Street Academy', '245 S Wolfe Street', 'Baltimore', 'Maryland', '21231', 'Baltimore City', '410-396-9140', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Commodore John Rodgers Elementary/Middle School', '6820 Fait Avenue', 'Baltimore', 'Maryland', '21224', 'Baltimore City', '410-396-9300', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Sandtown-Winchester Achievement Academy', '701 Gold Street', 'Baltimore', 'Maryland', '21217', 'Baltimore City', '410-396-0800', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Matthew A. Henson Elementary School', '1600 N Payson Street', 'Baltimore', 'Maryland', '21217', 'Baltimore City', '410-396-0776', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Charles Carroll Barrister Elementary School', '1327 Washington Boulevard', 'Baltimore', 'Maryland', '21230', 'Baltimore City', '410-396-5973', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Harlem Park Elementary/Middle School', '1401 W Lafayette Avenue', 'Baltimore', 'Maryland', '21217', 'Baltimore City', '410-396-0633', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Harford Heights Elementary School', '1919 N Broadway Street', 'Baltimore', 'Maryland', '21213', 'Baltimore City', '410-396-9341', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Dallas F. Nicholas, Sr., Elementary School', '201 E 21st Street', 'Baltimore', 'Maryland', '21218', 'Baltimore City', '410-396-4525', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Montebello Elementary/Middle School', '2040 E 32nd St', 'Baltimore', 'Maryland', '21218', 'Baltimore City', '410-396-6576', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Federal Hill Preparatory Academy', '1040 William Street', 'Baltimore', 'Maryland', '21230', 'Baltimore City', '410-396-1207', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Hampstead Hill Academy', '500 S Linwood Avenue', 'Baltimore', 'Maryland', '21224', 'Baltimore City', '410-396-9146', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Abbottston Elementary School', '1300 Gorsuch Avenue', 'Baltimore', 'Maryland', '21218', 'Baltimore City', '443-984-2685', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Waverly Elementary/Middle School', '3400 Ellerslie Avenue', 'Baltimore', 'Maryland', '21218', 'Baltimore City', '410-396-6394', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Margaret Brent Elementary/Middle School', '100 E 26th Street', 'Baltimore', 'Maryland', '21218', 'Baltimore City', '410-396-6509', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Barclay Elementary/Middle School', '2900 Barclay Street', 'Baltimore', 'Maryland', '21218', 'Baltimore City', '410-396-6387', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Hampden Elementary/Middle School', '3608 Chestnut Avenue', 'Baltimore', 'Maryland', '21211', 'Baltimore City', '410-396-6004', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Dr. Nathan A. Pitts-Ashburton Elementary/Middle School', '3935 Hilton Road', 'Baltimore', 'Maryland', '21215', 'Baltimore City', '410-396-0636', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Gwynns Falls Elementary School', '2700 Gwynns Falls Parkway', 'Baltimore', 'Maryland', '21216', 'Baltimore City', '410-396-0638', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Dorothy I. Height Elementary School', '2011 Linden Avenue', 'Baltimore', 'Maryland', '21217', 'Baltimore City', '410-396-0837', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Park Heights Academy', '2835 Virginia Avenue', 'Baltimore', 'Maryland', '21215', 'Baltimore City', '410-396-0550', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Rosemont Elementary/Middle School', '2777 Presstman Street', 'Baltimore', 'Maryland', '21216', 'Baltimore City', '410-396-0574', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Liberty Elementary School', '3901 Maine Avenue', 'Baltimore', 'Maryland', '21207', 'Baltimore City', '410-396-0571', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Mount Royal Elementary/Middle School', '121 McMechen Street', 'Baltimore', 'Maryland', '21217', 'Baltimore City', '410-396-0864', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Edgewood Elementary School', '1900 Edgewood Street', 'Baltimore', 'Maryland', '21216', 'Baltimore City', '410-396-0532', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Katherine Johnson Global Academy', '1101 Braddish Ave', 'Baltimore', 'Maryland', '21216', 'Baltimore City', '410-396-0581', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Francis Scott Key Elementary/Middle School', '1425 E Fort Avenue', 'Baltimore', 'Maryland', '21230', 'Baltimore City', '410-396-1503', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('North Bend Elementary/Middle School', '181 North Bend Road', 'Baltimore', 'Maryland', '21229', 'Baltimore City', '410-396-0376', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('William Paca Elementary School', '200 N Lakewood Avenue', 'Baltimore', 'Maryland', '21224', 'Baltimore City', '410-396-9148', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Thomas Johnson Elementary/Middle School', '100 E Heath Street', 'Baltimore', 'Maryland', '21230', 'Baltimore City', '410-396-1575', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Fort Worthington Elementary/Middle School', '2710 E Hoffman Street', 'Baltimore', 'Maryland', '21213', 'Baltimore City', '410-396-9161', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Lakewood Elementary School', '2625 Federal Street', 'Baltimore', 'Maryland', '21213', 'Baltimore City', '410-396-9158', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Windsor Hills Elementary/Middle School', '4001 Alto Road', 'Baltimore', 'Maryland', '21216', 'Baltimore City', '410-396-0595', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Wildwood Elementary/Middle School', '621 Wildwood Parkway', 'Baltimore', 'Maryland', '21229', 'Baltimore City', '410-396-0503', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Franklin Square Elementary/Middle School', '1400 W Lexington Street', 'Baltimore', 'Maryland', '21223', 'Baltimore City', '410-396-0795', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Collington Square Elementary/Middle School', '1409 N Collington Avenue', 'Baltimore', 'Maryland', '21213', 'Baltimore City', '410-396-9198', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Moravia Park Elementary School', '6001 Frankford Avenue', 'Baltimore', 'Maryland', '21206', 'Baltimore City', '410-396-9096', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Historic Samuel Coleridge-Taylor Elementary School, The', '507 W Preston Street', 'Baltimore', 'Maryland', '21201', 'Baltimore City', '410-396-0783', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Bay-Brook Elementary/Middle School', '4301 10th Street', 'Baltimore', 'Maryland', '21225', 'Baltimore City', '410-396-1357', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Furman Templeton Preparatory Academy', '1200 Pennsylvania Avenue', 'Baltimore', 'Maryland', '21201', 'Baltimore City', '410-396-0882', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Booker T. Washington Middle School', '1301 McCulloh Street', 'Baltimore', 'Maryland', '21217', 'Baltimore City', '410-396-7734', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Walter P. Carter Elementary/Middle School', '820 E 43rd Street', 'Baltimore', 'Maryland', '21212', 'Baltimore City', '410-396-6271', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Robert W. Coleman Elementary School', '2400 Windsor Avenue', 'Baltimore', 'Maryland', '21216', 'Baltimore City', '410-396-0764', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Billie Holiday Elementary School', '2400 W Mosher Street', 'Baltimore', 'Maryland', '21216', 'Baltimore City', '410-396-0506', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Mary Ann Winterling Elementary School at Bentalou', '220 N Bentalou Street', 'Baltimore', 'Maryland', '21223', 'Baltimore City', '410-396-1385', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Cherry Hill Elementary/Middle School, The Historic', '801 Bridgeview Road', 'Baltimore', 'Maryland', '21225', 'Baltimore City', '410-396-1392', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Arundel Elementary School', '2400 Round Road', 'Baltimore', 'Maryland', '21225', 'Baltimore City', '410-396-1379', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Excel Academy at Francis M. Wood High School', '1001 W Saratoga Street', 'Baltimore', 'Maryland', '21223', 'Baltimore City', '410-396-1290', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Dickey Hill Elementary/Middle School', '5025 Dickey Hill Road', 'Baltimore', 'Maryland', '21207', 'Baltimore City', '410-396-0610', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Maree G. Farring Elementary/Middle School', '300 Pontiac Avenue', 'Baltimore', 'Maryland', '21225', 'Baltimore City', '410-396-1404', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Mary E. Rodman Elementary School', '3510 W Mulberry Street', 'Baltimore', 'Maryland', '21229', 'Baltimore City', '410-396-0508', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Woodhome Elementary/Middle School', '7300 Moyer Avenue', 'Baltimore', 'Maryland', '21234', 'Baltimore City', '410-396-6398', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Furley Elementary School', '5000 Truesdale Avenue', 'Baltimore', 'Maryland', '21206', 'Baltimore City', '410-396-9094', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Curtis Bay Elementary School', '4301 West Bay Avenue', 'Baltimore', 'Maryland', '21225', 'Baltimore City', '410-396-1397', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Hazelwood Elementary/Middle School', '4517 Hazelwood Avenue', 'Baltimore', 'Maryland', '21206', 'Baltimore City', '410-396-9098', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Gardenville Elementary School', '5300 Belair Road', 'Baltimore', 'Maryland', '21206', 'Baltimore City', '410-396-6382', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Garrett Heights Elementary/Middle School', '2800 Ailsa Avenue', 'Baltimore', 'Maryland', '21214', 'Baltimore City', '410-396-6361', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Govans Elementary School', '5801 York Road', 'Baltimore', 'Maryland', '21212', 'Baltimore City', '410-396-6396', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Highlandtown Elementary/Middle School No. 215', '3223 E Pratt Street', 'Baltimore', 'Maryland', '21224', 'Baltimore City', '410-396-9381', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Belmont Elementary School', '1406 N Ellamont Street', 'Baltimore', 'Maryland', '21216', 'Baltimore City', '410-396-0579', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Yorkwood Elementary School', '5931 Yorkwood Road', 'Baltimore', 'Maryland', '21239', 'Baltimore City', '410-396-6364', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Morrell Park Elementary/Middle School', '2601 Tolley Street', 'Baltimore', 'Maryland', '21230', 'Baltimore City', '410-396-3426', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Mount Washington School, The', '1801 Sulgrave Avenue', 'Baltimore', 'Maryland', '21209', 'Baltimore City', '410-396-6354', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Pimlico Elementary/Middle School', '4849 Pimlico Road', 'Baltimore', 'Maryland', '21215', 'Baltimore City', '410-396-0876', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Westport Academy', '2401 Nevada Street', 'Baltimore', 'Maryland', '21230', 'Baltimore City', '410-396-3396', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Violetville Elementary/Middle School', '1207 Pine Heights Avenue', 'Baltimore', 'Maryland', '21229', 'Baltimore City', '410-396-1416', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('John Ruhrah Elementary/Middle School', '701 Rappolla Street', 'Baltimore', 'Maryland', '21224', 'Baltimore City', '410-396-9125', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Holabird Academy', '1500 Imla Street', 'Baltimore', 'Maryland', '21224', 'Baltimore City', '410-396-9086', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('The belair-edison school (elementary)', '3536 Brehms Lane', 'Baltimore', 'Maryland', '21213', 'Baltimore City', '410-396-9150', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('The belair-edison school (middle)', '2800 Brendan Ave', 'Baltimore', 'Maryland', '21213', 'Baltimore City', '410-396-9150', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Thomas Jefferson Elementary/Middle School', '605 Dryden Drive', 'Baltimore', 'Maryland', '21229', 'Baltimore City', '410-396-0534', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Roland Park Elementary/Middle School', '5207 Roland Avenue', 'Baltimore', 'Maryland', '21210', 'Baltimore City', '410-396-6420', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Arlington Elementary School', '3705 W Rogers Avenue', 'Baltimore', 'Maryland', '21215', 'Baltimore City', '410-396-0567', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Glenmount Elementary/Middle School', '6211 Walther Avenue', 'Baltimore', 'Maryland', '21206', 'Baltimore City', '410-396-6366', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Hamilton Elementary/Middle School', '6101 Old Harford Road', 'Baltimore', 'Maryland', '21214', 'Baltimore City', '410-396-6375', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Highlandtown Elementary/Middle School No. 237', '231 S Eaton Street', 'Baltimore', 'Maryland', '21224', 'Baltimore City', '443-642-2792', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Benjamin Franklin High School at Masonville Cove', '1201 Cambria Street', 'Baltimore', 'Maryland', '21225', 'Baltimore City', '410-396-1373', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Graceland Park/O''Donnell Heights Elementary/Middle School', '6300 O''Donnell Street', 'Baltimore', 'Maryland', '21224', 'Baltimore City', '410-396-9083', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Fallstaff Elementary/Middle School', '3801 Fallstaff Road', 'Baltimore', 'Maryland', '21215', 'Baltimore City', '410-396-0682', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Northwood Elementary School', '5201 Loch Raven Boulevard', 'Baltimore', 'Maryland', '21239', 'Baltimore City', '410-396-6377', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Armistead Gardens Elementary/Middle School', '5001 E Eager Street', 'Baltimore', 'Maryland', '21205', 'Baltimore City', '410-396-9090', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Leith Walk Elementary/Middle School', '5915 Glennor Road', 'Baltimore', 'Maryland', '21239', 'Baltimore City', '410-396-6380', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Beechfield Elementary/Middle School', '301 S Beechfield Avenue', 'Baltimore', 'Maryland', '21229', 'Baltimore City', '410-396-0525', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Cross Country Elementary/Middle School', '6100 Cross Country Blvd', 'Baltimore', 'Maryland', '21215', 'Baltimore City', '410-396-0602', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Sinclair Lane Elementary School', '3880 Sinclair Lane', 'Baltimore', 'Maryland', '21213', 'Baltimore City', '410-396-9117', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Medfield Heights Elementary School', '4300 Buchanan Avenue', 'Baltimore', 'Maryland', '21211', 'Baltimore City', '410-396-6460', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Dr. Bernard Harris, Sr., Elementary School', '1400 N Caroline Street', 'Baltimore', 'Maryland', '21213', 'Baltimore City', '410-396-1452', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Callaway Elementary School', '3701 Fernhill Avenue', 'Baltimore', 'Maryland', '21215', 'Baltimore City', '410-396-0604', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Calvin M. Rodwell Elementary/Middle School', '3501 Hillsdale Road', 'Baltimore', 'Maryland', '21207', 'Baltimore City', '410-396-0940', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Frederick Elementary School', '2501 Frederick Avenue', 'Baltimore', 'Maryland', '21223', 'Baltimore City', '410-396-0830', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Empowerment Academy', '851 Braddish Avenue', 'Baltimore', 'Maryland', '21216', 'Baltimore City', '443-984-2381', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('William S. Baer School', '2001 N Warwick Avenue', 'Baltimore', 'Maryland', '21216', 'Baltimore City', '410-396-0833', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Home and Hospital Program', '2000 Edgewood Street', 'Baltimore', 'Maryland', '21216', 'Baltimore City', '410-396-0775', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Claremont School', '100 Kane Street', 'Baltimore', 'Maryland', '21224', 'Baltimore City', '410-545-3380', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Lois T. Murray Elementary/Middle School', '820 E 43rd Street', 'Baltimore', 'Maryland', '21212', 'Baltimore City', '410-396-7463', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Sharp-Leadenhall Elementary/Middle School', '1919 N Broadway Street', 'Baltimore', 'Maryland', '21213', 'Baltimore City', '410-396-4325', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Midtown Academy', '1398 W Mount Royal Avenue', 'Baltimore', 'Maryland', '21217', 'Baltimore City', '410-225-3257', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('New Song Academy', '1530 Presstman Street', 'Baltimore', 'Maryland', '21217', 'Baltimore City', '410-728-2091', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Crossroads School, The', '802 S Caroline Street', 'Baltimore', 'Maryland', '21231', 'Baltimore City', '410-276-4924', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('ConneXions: A Community Based Arts School', '2801 N Dukeland Street', 'Baltimore', 'Maryland', '21216', 'Baltimore City', '443-984-1418', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('City Neighbors Charter School', '4301 Raspe Avenue', 'Baltimore', 'Maryland', '21206', 'Baltimore City', '410-325-2627', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Patterson Park Public Charter School', '27 N Lakewood Avenue', 'Baltimore', 'Maryland', '21224', 'Baltimore City', '410-558-1230', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Southwest Baltimore Charter School', '1300 Herkimer Street', 'Baltimore', 'Maryland', '21223', 'Baltimore City', '443-984-3385', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Green School of Baltimore, The', '2851 Kentucky Avenue', 'Baltimore', 'Maryland', '21213', 'Baltimore City', '410-488-5312', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Baltimore International Academy', '4410 Frankford Avenue', 'Baltimore', 'Maryland', '21206', 'Baltimore City', '410-426-3650', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Baltimore Montessori Public Charter School', '1600 Guilford Avenue', 'Baltimore', 'Maryland', '21202', 'Baltimore City', '410-528-5393', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Reach! Partnership School, The', '2555 Harford Road', 'Baltimore', 'Maryland', '21218', 'Baltimore City', '443-642-2291', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Joseph C. Briscoe Academy', '900 Druid Hill Avenue', 'Baltimore', 'Maryland', '21201', 'Baltimore City', '410-396-0774', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('City Neighbors Hamilton', '5609 Sefton Avenue', 'Baltimore', 'Maryland', '21214', 'Baltimore City', '443-642-2052', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('KIPP Harmony Academy', '2000 Edgewood Street', 'Baltimore', 'Maryland', '21216', 'Baltimore City', '410-291-2583', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Baltimore Leadership School for Young Women', '128 W Franklin Street', 'Baltimore', 'Maryland', '21201', 'Baltimore City', '443-642-2048', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Bard High School Early College Baltimore', '2801 N Dukeland Street', 'Baltimore', 'Maryland', '21216', 'Baltimore City', '443-642-5040', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Elmer A. Henderson: A Johns Hopkins Partnership School', '2100 Ashland Avenue', 'Baltimore', 'Maryland', '21205', 'Baltimore City', '443-642-2060', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Lillie May Carroll Jackson School', '2200 Sinclair Lane', 'Baltimore', 'Maryland', '21213', 'Baltimore City', '443-320-9499', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Tunbridge Public Charter School', '5504 York Road', 'Baltimore', 'Maryland', '21212', 'Baltimore City', '410-323-8692', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Vanguard Collegiate Middle School', '5000 Truesdale Avenue', 'Baltimore', 'Maryland', '21206', 'Baltimore City', '443-642-2069', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Baltimore Collegiate School for Boys', '2525 Kirk Avenue', 'Baltimore', 'Maryland', '21218', 'Baltimore City', '443-642-5320', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('City Neighbors High School', '5609 Sefton Avenue', 'Baltimore', 'Maryland', '21214', 'Baltimore City', '443-642-2119', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Green Street Academy', '125 N Hilton Street', 'Baltimore', 'Maryland', '21229', 'Baltimore City', '443-642-2068', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Baltimore Design School', '1500 Barclay Street', 'Baltimore', 'Maryland', '21202', 'Baltimore City', '443-642-2311', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Creative City Public Charter School', '2810 Shirley Avenue', 'Baltimore', 'Maryland', '21215', 'Baltimore City', '443-642-3600', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Baltimore International Academy West', '4300 Sidehill Road', 'Baltimore', 'Maryland', '21229', 'Baltimore City', '410-291-2440', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Clay Hill Public Charter School', '6410 E Pratt Street', 'Baltimore', 'Maryland', '21224', 'Baltimore City', '410-450-4556', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Edmondson-Westside High School', '501 N Athol Avenue', 'Baltimore', 'Maryland', '21229', 'Baltimore City', '410-396-0685', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Baltimore Polytechnic Institute', '1400 W Cold Spring Lane', 'Baltimore', 'Maryland', '21239', 'Baltimore City', '410-396-7026', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Patterson High School', '100 Kane Street', 'Baltimore', 'Maryland', '21224', 'Baltimore City', '410-396-9276', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Forest Park High School', '3701 Eldorado Avenue', 'Baltimore', 'Maryland', '21207', 'Baltimore City', '410-396-0753', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Western High School', '4600 Falls Road', 'Baltimore', 'Maryland', '21209', 'Baltimore City', '410-396-7040', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Mergenthaler Vocational-Technical High School', '3500 Hillen Road', 'Baltimore', 'Maryland', '21218', 'Baltimore City', '410-396-6496', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Achievement Academy at Harbor City High School', '2201 Pinewood Avenue', 'Baltimore', 'Maryland', '21214', 'Baltimore City', '410-396-6241', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Paul Laurence Dunbar High School', '1400 Orleans Street', 'Baltimore', 'Maryland', '21231', 'Baltimore City', '443-642-4478', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Baltimore School for the Arts', '712 Cathedral Street', 'Baltimore', 'Maryland', '21201', 'Baltimore City', '443-642-5165', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Digital Harbor High School', '1100 Covington Street', 'Baltimore', 'Maryland', '21230', 'Baltimore City', '443-984-1256', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Reginald F. Lewis High School', '6401 Pioneer Drive', 'Baltimore', 'Maryland', '21214', 'Baltimore City', '410-545-1746', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('National Academy Foundation', '540 N Caroline Street', 'Baltimore', 'Maryland', '21205', 'Baltimore City', '443-984-1594', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Academy for College and Career Exploration', '1300 W 36th Street', 'Baltimore', 'Maryland', '21211', 'Baltimore City', '410-396-7607', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Vivien T. Thomas Medical Arts Academy', '100 N Calhoun Street', 'Baltimore', 'Maryland', '21223', 'Baltimore City', '443-984-2831', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Augusta Fells Savage Institute of Visual Arts', '1500 Harlem Avenue', 'Baltimore', 'Maryland', '21217', 'Baltimore City', '410-396-7701', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Coppin Academy', '2500 W North Avenue', 'Baltimore', 'Maryland', '21213', 'Baltimore City', '443-642-5060', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Renaissance Academy', '1301 McCulloh Street', 'Baltimore', 'Maryland', '21217', 'Baltimore City', '443-984-3164', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Frederick Douglass High School', '6900 Park Heights Avenue', 'Baltimore', 'Maryland', '21215', 'Baltimore City', '410-396-7821', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Carver Vocational-Technical High School', '2201 Presstman Street', 'Baltimore', 'Maryland', '21216', 'Baltimore City', '410-396-0553', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Baltimore City College', '3220 The Alameda', 'Baltimore', 'Maryland', '21218', 'Baltimore City', '410-396-6557', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Middle Alternative Program', '2801 North Dukeland Street', 'Baltimore', 'Maryland', '21216', 'Baltimore City', '410-396-1720', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Career Academy', '1500 Harlem Avenue', 'Baltimore', 'Maryland', '21217', 'Baltimore City', '410-291-2759', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Success Academy', '2201 Pinewood Avenue', 'Baltimore', 'Maryland', '21214', 'Baltimore City', '443-642-2101', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Youth Opportunity', '1510 W Lafayette Avenue', 'Baltimore', 'Maryland', '21217', 'Baltimore City', '410-962-1905', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('P-TECH at Carver Vocational-Technical High School', '2201 Presstman Street', 'Baltimore', 'Maryland', '21216', 'Baltimore City', '410-396-0553', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('P-TECH at Paul Laurence Dunbar High School', '1400 Orleans Street', 'Baltimore', 'Maryland', '21231', 'Baltimore City', '443-642-4478', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('P-TECH at Digital', '1100 Covington Street', 'Baltimore', 'Maryland', '21230', 'Baltimore City', '443-984-2415', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Eager Street Academy', '926 Greenmount Avenue', 'Baltimore', 'Maryland', '21202', 'Baltimore City', '410-234-1815', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Evening School (Proposed New Name: The Reengagement Evening Program)', '200 E North Avenue', 'Baltimore', 'Maryland', '21202', 'Baltimore City', '443-642-4220', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('The Secondary Virtual Learning School', '2500 E Northern Parkway', 'Baltimore', 'Maryland', '21214', 'Baltimore City', '443-642-5400', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('The Baltimore Academy', '3800 Frederick Avenue, Baltimore', 'Baltimore', 'Maryland', '21229', 'Baltimore City', '410-233-1400', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Baltimore Lab School', '2220 St. Paul Street', 'Baltimore', 'Maryland', '21218', 'Baltimore City', '410-261-5500', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('The Children''s Guild School of Baltimore', '410 East Jeffrey Stree, Baltimore', 'Baltimore', 'Maryland', '21225', 'Baltimore City', '410-269-7600', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('The Chimes School', '4810 Seton Drive', 'Baltimore', 'Maryland', '21215', 'Baltimore City', '410-358-8270', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Gateway School', '5900 Metro Drive, baltimore', 'Baltimore', 'Maryland', '21215', 'Baltimore City', '410-318-6780', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Kennedy Krieger School: Fairmount Campus', '1750 East Fairmount Avenue', 'Baltimore', 'Maryland', '21231', 'Baltimore City', '443-923-9100', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Kennedy Krieger School: Greenspring Campus', '3825 Greenspring Avenue', 'Baltimore', 'Maryland', '21211', 'Baltimore City', '443-923-87800', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('The Maryland School for the Blind', '3501 Taylor Avenue', 'Baltimore', 'Maryland', '21236', 'Baltimore City', '410-444-5000', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('St. Elizabeth School', '801 Argonne Drive', 'Baltimore', 'Maryland', '21218', 'Baltimore City', '410-889-5054', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Woodbourne School', '1301 Woodbourne Avenue', 'Baltimore', 'Maryland', '21239', 'Baltimore City', '410-433-1000', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;




--Baltimore
INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Arbutus Elementary School', '1300 Sulphur Spring Rd', 'Baltimore', 'Maryland', '21227', 'Baltimore', '443809-1400', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Baltimore Highlands Elementary School', '4200 Annapolis Rd', 'Baltimore', 'Maryland', '21227', 'Baltimore', '443809-0919', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Battle Grove Elementary School', '7828 Saint Patricia Lane', 'Baltimore', 'Maryland', '21222', 'Baltimore', '443-809-7500', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Battle Monument School', '7801 E. Collingham Dr', 'Baltimore', 'Maryland', '21222', 'Baltimore', '443-809-7000', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Bear Creek Elementary School', '1601 Melbourne Rd', 'Baltimore', 'Maryland', '21222', 'Baltimore', '443-809-7007', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Bedford Elementary School', '7320 Campfield Rd, Pikesville', 'Baltimore', 'Maryland', '21207', 'Baltimore', '443-809-1200', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Berkshire Elementary School', '7431 Poplar Ave', 'Baltimore', 'Maryland', '21224', 'Baltimore', '443-809-7008', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Campfield Early Learning Center School', '6834 Alter St', 'Baltimore', 'Maryland', '21207', 'Baltimore', '443-809-1227', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Carney Elementary School', '3131 E Joppa Rd', 'Baltimore', 'Maryland', '21234', 'Baltimore', '443-809-5228', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Carroll Manor Elementary School', '4434 Carroll Manor Rd, Baldwin', 'Baltimore', 'Maryland', '21013', 'Baltimore', '443-809-5947', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Catonsville Elementary School', '106 Bloomsbury Ave, Catonsville', 'Baltimore', 'Maryland', '21228', 'Baltimore', '443-809-0800', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Cedarmere Elementary School', '17 Nicodemus Rd, Reisterstown', 'Baltimore', 'Maryland', '21136', 'Baltimore', '443-809-1100', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Chadwick Elementary School', '1918 Winder Rd', 'Baltimore', 'Maryland', '21244', 'Baltimore', '443-809-1300', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Chapel Hill Elementary School', '5200 Joppa Rd, Perry Hall', 'Baltimore', 'Maryland', '21128', 'Baltimore', '443-809-5119', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Charlesmont Elementary School', '7800 W. Collingham Dr', 'Baltimore', 'Maryland', '21222', 'Baltimore', '443-809-7004', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Chase Elementary School', '11701 Eastern Ave, Reisterstown', 'Baltimore', 'Maryland', '11701', 'Baltimore', '443-809-5940', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Chatsworth School', '222 New Ave', 'Reisterstown', 'Maryland', '21136', 'Baltimore', '443-809-1103', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Chesapeake Terrace Elementary School', '2112 Lodge Farm Rd', 'Baltimore', 'Maryland', '21219', 'Baltimore', '443-809-7505', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Church Lane Elementary Technology School', '3820 Fernside Rd, Randallstown', 'Baltimore', 'Maryland', '21133', 'Baltimore', '443-809-0717', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Colgate Elementary School', '7735 Gough St', 'Baltimore', 'Maryland', '21224', 'Baltimore', '443-809-7010', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Cromwell Valley Elementary Regional Magnet School', '825 Providence Rd, Towson', 'Baltimore', 'Maryland', '21286', 'Baltimore', '443-809-4888', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Deep Creek Elementary School', '1101 East Homberg Ave', 'Baltimore', 'Maryland', '21221', 'Baltimore', '443-809-0110', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Deer Park Elementary School', '9809 Lyons Mill Rd', 'Baltimore', 'Maryland', '21117', 'Baltimore', '443-809-0723', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Dogwood Elementary School', '7215 Dogwood Rd', 'Baltimore', 'Maryland', '21244', 'Baltimore', '443-809-6808', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Dundalk Elementary School', '2717 Playfield St, Dundalk', 'Baltimore', 'Maryland', '21222', 'Baltimore', '443-809-7013', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Edgemere Elementary School', '7201 North Point Rd', 'Baltimore', 'Maryland', '21219', 'Baltimore', '443-809-7507', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Edmondson Heights Elementary School', '1600 Langford Rd', 'Baltimore', 'Maryland', '21207', 'Baltimore', '443-809-0818', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Elmwood Elementary School', '531 Dale Ave', 'Baltimore', 'Maryland', '21206', 'Baltimore', '443-809-5232', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Essex Elementary School', '100 Mace Ave', 'Baltimore', 'Maryland', '21221', 'Baltimore', '443-809-0117', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Featherbed Lane Elementary School', '6700 Richardson Rd', 'Baltimore', 'Maryland', '21207', 'Baltimore', '443-809-1302', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Fifth District Elementary School', '3725 Mount Carmel Rd, Upperco', 'Baltimore', 'Maryland', '21155', 'Baltimore', '443-809-1726', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Fort Garrison Elementary School', '3310 Woodvalley Dr', 'Baltimore', 'Maryland', '21208', 'Baltimore', '443-809-1203', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Franklin Elementary School', '33 Cockeys Mill Rd, Reisterstown', 'Baltimore', 'Maryland', '21136', 'Baltimore', '443-809-1111', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Fullerton Elementary School', '4400 Fullerton Ave', 'Baltimore', 'Maryland', '21236', 'Baltimore', '443-809-5234', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Glenmar Elementary School', '9700 Community Dr', 'Baltimore', 'Maryland', '21220', 'Baltimore', '443-809-0127', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Glyndon Elementary School', '445 Glyndon Dr, Reisterstown', 'Baltimore', 'Maryland', '21136', 'Baltimore', '443-809-1130', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Grange Elementary School', '2000 Church Rd, Dundalk', 'Baltimore', 'Maryland', '21222', 'Baltimore', '443-809-7043', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Gunpowder Elementary School', '9540 Holiday Manor Rd', 'Baltimore', 'Maryland', '21236', 'Baltimore', '443-809-5121', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Halethorpe Elementary School', '4300 Maple Ave', 'Baltimore', 'Maryland', '21227', 'Baltimore', '443-809-1406', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Halstead Academy School', '1111 Halstead Rd', 'Baltimore', 'Maryland', '21234', 'Baltimore', '443-809-3210', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Hampton Elementary School', '1115 Charmurh Rd, Lutherville', 'Baltimore', 'Maryland', '21093', 'Baltimore', '443-809-3205', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Harford Hills Elementary School', '8902 Old Harford Rd', 'Baltimore', 'Maryland', '21234', 'Baltimore', '443-809-5236', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Hawthorne Elementary School', '125 Kingston Rd', 'Baltimore', 'Maryland', '21220', 'Baltimore', '443-809-0138', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Hebbville Elementary School', '3335 Wasington Ave', 'Baltimore', 'Maryland', '21244', 'Baltimore', '443-809-0708', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Hernwood Elementary School', '9919 Marriottsville Rd, Randallstown', 'Baltimore', 'Maryland', '21133', 'Baltimore', '443-809-0732', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Hillcrest Elementary School', '1500 Frederick Rd, Catonsville', 'Baltimore', 'Maryland', '21228', 'Baltimore', '443-809-0820', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Honeygo Elementary School', '4816 E Joppa Rd, Perry Hall', 'Baltimore', 'Maryland', '21128', 'Baltimore', '443-809-8700', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Jacksonville Elementary School', '3400 Hillendale Heights Rd, Phoenix', 'Baltimore', 'Maryland', '21131', 'Baltimore', '443-809-7880', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Johnnycake Elementary School', '5910 Craigmont Rd', 'Baltimore', 'Maryland', '21228', 'Baltimore', '443-809-0823', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Joppa View Elementary School', '8727 Honeygo Boulevard', 'Baltimore', 'Maryland', '21128', 'Baltimore', '443-809-5065', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Kingsville Elementary School', '7300 Sunshine Ave, Kingsville', 'Baltimore', 'Maryland', '21087', 'Baltimore', '443-809-5949', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Lansdowne Elementary School', '2301 Alma Rd', 'Baltimore', 'Maryland', '21227', 'Baltimore', '443-809-1408', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Logan Elementary School', '7601 Dunmanway, Dundalk', 'Baltimore', 'Maryland', '21222', 'Baltimore', '443-809-7052', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Lutherville Laboratory School', '1700 York Rd, Lutherville', 'Baltimore', 'Maryland', '21093', 'Baltimore', '443-809-7800', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Lyons Mill Elementary School', '9435 Lyons Mill Rd, Owings Mills', 'Baltimore', 'Maryland', '21117', 'Baltimore', '443-809-1719', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Mars Estates Elementary School', '1500 Homberg Ave', 'Baltimore', 'Maryland', '21221', 'Baltimore', '443-809-0154', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Martin Boulevard Elementary School', '210 Riverton Rd', 'Baltimore', 'Maryland', '21220', 'Baltimore', '443-809-0158', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Mays Chapel Elementary School', '12250 Roundwood Rd, Timonium', 'Baltimore', 'Maryland', '21093', 'Baltimore', '443-809-4134', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('McCormick Elementary School', '5101 Hazelwood Ave', 'Baltimore', 'Maryland', '21206', 'Baltimore', '443-809-0500', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Middleborough Elementary School', '313 West Rd', 'Baltimore', 'Maryland', '21221', 'Baltimore', '443-809-0161', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Middlesex Elementary School', '142 Bennett Rd', 'Baltimore', 'Maryland', '21221', 'Baltimore', '443-809-0469', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Milbrook Elementary School', '4300 Crest Heights Rd', 'Baltimore', 'Maryland', '21215', 'Baltimore', '443-809-1225', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('New Town Elementary School', '4924 New Town Blvd, Owings Mills', 'Baltimore', 'Maryland', '21117', 'Baltimore', '443-809-1541', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Norwood Elementary School', '1700 Delvale Ave', 'Baltimore', 'Maryland', '21222', 'Baltimore', '443-809-7055', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Oakleigh Elementary School', '1900 White Oak Ave', 'Baltimore', 'Maryland', '21234', 'Baltimore', '443-809-5238', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Oliver Beach Elementary School', '12912 Cunninghill Cove Rd', 'Baltimore', 'Maryland', '12912', 'Baltimore', '443-809-5943', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Orems Elementary School', '711 Highvilla Rd', 'Baltimore', 'Maryland', '21221', 'Baltimore', '443-809-0172', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Owings Mills Elementary School', '10824 Reisterstown Rd, Owings Mills', 'Baltimore', 'Maryland', '21117', 'Baltimore', '443-809-1710', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Padonia International Elementary School', '9834 Greenside Dr, Cockeysville', 'Baltimore', 'Maryland', '21030', 'Baltimore', '443-809-7646', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Perry Hall Elementary School', '9021 Belair Rd, Perry Hall', 'Baltimore', 'Maryland', '21236', 'Baltimore', '443-809-5105', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Pine Grove Elementary School', '2701 Summit Ave', 'Baltimore', 'Maryland', '21234', 'Baltimore', '443-809-5268', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Pinewood Elementary School', '200 Rickswood Rd, Timonium', 'Baltimore', 'Maryland', '21093', 'Baltimore', '443-809-7663', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Pleasant Plains Elementary School', '8300 Pleasant Plains Rd', 'Baltimore', 'Maryland', '21286', 'Baltimore', '443-809-3549', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Pot Spring Elementary School', '2410 Springlake Dr, Timonium', 'Baltimore', 'Maryland', '21093', 'Baltimore', '443-809-7648', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Powhatan Elementary School', '3300 Kelox Rd', 'Baltimore', 'Maryland', '21207', 'Baltimore', '443-809-1330', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Prettyboy Elementary School', '19810 Middletown Rd, Freeland', 'Baltimore', 'Maryland', '21053', 'Baltimore', '443-809-1900', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Randallstown Elementary School', '9013 Liberty Rd, Randallstown', 'Baltimore', 'Maryland', '21133', 'Baltimore', '443-809-0746', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Red House Run Elementary School', '1717 Weyburn Rd, Rosedale', 'Baltimore', 'Maryland', '21237', 'Baltimore', '443-809-0506', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Reisterstown Elementary School', '223 Walgrove Rd, Reisterstown', 'Baltimore', 'Maryland', '21136', 'Baltimore', '443-809-1133', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Relay Elementary School', '5885 Selford Rd', 'Baltimore', 'Maryland', '21227', 'Baltimore', '443-809-1426', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Riderwood Elementary School', '1711 Landrake Rd, Towson', 'Baltimore', 'Maryland', '21204', 'Baltimore', '443-809-3568', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Riverview Elementary School', '3298 Kessler Rd', 'Baltimore', 'Maryland', '21227', 'Baltimore', '443-809-1428', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Rodgers Forge Elementary School', '250 Dumbarton Rd', 'Baltimore', 'Maryland', '21212', 'Baltimore', '443-809-3582', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Rossville Elementary School', '7649 Gum Spring Rd', 'Baltimore', 'Maryland', '21237', 'Baltimore', '443-809-8519', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Sandalwood Elementary School', '900 S Marlyn Ave', 'Baltimore', 'Maryland', '21221', 'Baltimore', '443-809-0174', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Sandy Plains Elementary School', '8330 Kavanagh Rd', 'Baltimore', 'Maryland', '21222', 'Baltimore', '443-809-7070', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Scotts Branch Elementary School', '8220 Tawnmoore Rd', 'Baltimore', 'Maryland', '21244', 'Baltimore', '443-809-0761', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Seneca Elementary School', '545 Carrollwood Rd', 'Baltimore', 'Maryland', '21220', 'Baltimore', '443-809-5945', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Seven Oaks Elementary School', '9220 Seven Courts Rd', 'Baltimore', 'Maryland', '21234', 'Baltimore', '443-809-6257', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Seventh District Elementary School', '20300 York Rd, Parkton', 'Baltimore', 'Maryland', '21120', 'Baltimore', '443-809-1902', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Shady Spring Elementary School', '8868 Goldenwood Rd', 'Baltimore', 'Maryland', '21237', 'Baltimore', '443-809-0509', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Sparks Elementary School', '601 Belfast Rd, Sparks', 'Baltimore', 'Maryland', '21152', 'Baltimore', '443-809-7900', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Stoneleigh Elementary School', '900 Pemberton Rd', 'Baltimore', 'Maryland', '21212', 'Baltimore', '443-809-3600', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Summit Park Elementary School', '6920 Diana Rd', 'Baltimore', 'Maryland', '21209', 'Baltimore', '410-887-1210', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Sussex Elementary School', '515 S. Woodward Dr', 'Baltimore', 'Maryland', '21221', 'Baltimore', '443-809-0182', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Timber Grove Elementary School', '701 Academy Ave, Owings Mills', 'Baltimore', 'Maryland', '21117', 'Baltimore', '443-809-1714', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Timonium Elementary School', '2001 Eastridge Rd, Timonium', 'Baltimore', 'Maryland', '21093', 'Baltimore', '443-809-7661', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Victory Villa Elementary School', '500 Compass Rd', 'Baltimore', 'Maryland', '21220', 'Baltimore', '443-809-0184', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Villa Cresta Elementary School', '2600 Rader Ave', 'Baltimore', 'Maryland', '21234', 'Baltimore', '443-809-5277', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Vincent Farm Elementary School', '6019 Ebenezer Rd, White Marsh', 'Baltimore', 'Maryland', '21162', 'Baltimore', '443-809-2983', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Warren Elementary School', '900 Bosley Rd, Cockeysvile', 'Baltimore', 'Maryland', '21030', 'Baltimore', '443-809-7665', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Watershed Public Charter School', '6946 Dogwood RD, Windsor Mill', 'Baltimore', 'Maryland', '21244', 'Baltimore', '443-809-2100', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Wellwood International School', '2901 Smith Ave', 'Baltimore', 'Maryland', '21208', 'Baltimore', '443-809-1212', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('West Towson Elementary School', '6914 North Charles St, Towson', 'Baltimore', 'Maryland', '21204', 'Baltimore', '443-809-3869', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Westchester Elementary School', '2300 Old Frederick Rd', 'Baltimore', 'Maryland', '21228', 'Baltimore', '443-809-1088', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Westowne Elementary School', '401 Harlem Lane, Catonsville', 'Baltimore', 'Maryland', '21228', 'Baltimore', '443-809-0854', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Winand Elementary School', '8301 Scotts Level Rd', 'Baltimore', 'Maryland', '21208', 'Baltimore', '443-809-0763', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Winfield Elementary School', '8300 Carlson Lane', 'Baltimore', 'Maryland', '21244', 'Baltimore', '443-809-0766', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Woodbridge Elementary School', '1410 Pleasant Valley Dr', 'Baltimore', 'Maryland', '21228', 'Baltimore', '443-809-0857', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Woodholme Elementary School', '300 Mount WIlson Lane', 'Baltimore', 'Maryland', '21208', 'Baltimore', '443-809-6700', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Woodmoor Elementary School', '3200 Elba Dr', 'Baltimore', 'Maryland', '21207', 'Baltimore', '443-809-1318', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Arbutus Middle School', '5525 Shelbourne Rd', 'Baltimore', 'Maryland', '21227', 'Baltimore', '443809-1401', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Catonsville Middle School', '2301 Edmonson Ave, Catonsville', 'Baltimore', 'Maryland', '21228', 'Baltimore', '443-809-0803', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Cockeysville Middle School', '10401 Greenside Dr, Cockeysville', 'Baltimore', 'Maryland', '21030', 'Baltimore', '443-809-7626', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Crossroads Center School', '11640 Crossroads Cir', 'Baltimore', 'Maryland', '11640', 'Baltimore', '443-809-2275', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Deep Creek Middle School', '1000 S Marlyn Ave', 'Baltimore', 'Maryland', '21221', 'Baltimore', '443-809-0112', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Deer Park Middle Magnet School', '9830 Winands RD, Randallstown', 'Baltimore', 'Maryland', '21133', 'Baltimore', '443-809-0726', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Dumbarton Middle School', '300 Dumbarton Rd', 'Baltimore', 'Maryland', '21212', 'Baltimore', '443-809-3176', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Dundalk Middle School', '7400 Dunmanway, Dundalk', 'Baltimore', 'Maryland', '21222', 'Baltimore', '443-809-7018', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Franklin Middle School', '10 Cockeys Mill Rd, Reisterstown', 'Baltimore', 'Maryland', '21136', 'Baltimore', '443-809-1114', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('General John Stricker Middle School', '7855 Trappe Rd', 'Baltimore', 'Maryland', '21222', 'Baltimore', '443-809-7038', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Golden Ring Middle School', '6700 Kenwood Ave, Rosedale', 'Baltimore', 'Maryland', '21237', 'Baltimore', '443-809-0131', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Hereford Middle School', '712 Corbett RD, Herford', 'Baltimore', 'Maryland', '21111', 'Baltimore', '443-809-7901', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Holabird Middle School', '1701 Delvale Ave', 'Baltimore', 'Maryland', '21222', 'Baltimore', '443-809-7049', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Lansdowne Middle School', '2400 Lansdowne Rd', 'Baltimore', 'Maryland', '21227', 'Baltimore', '443-809-1411', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Loch Raven Technical Academy School', '8101 LaSalle Rd', 'Baltimore', 'Maryland', '21286', 'Baltimore', '443-809-3518', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Meadowood Education Center', '1849 Gwynn Oak Ave', 'Baltimore', 'Maryland', '21207', 'Baltimore', '443-809-6888', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Middle River Middle School', '800 Middle River Rd', 'Baltimore', 'Maryland', '21220', 'Baltimore', '443-809-0165', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Northwest Academy of Health Sciences School', '4627 Old Court Rd', 'Baltimore', 'Maryland', '21208', 'Baltimore', '443-809-0742', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Nottingham Middle School', '5210 King Ave, Nottingham', 'Baltimore', 'Maryland', '21237', 'Baltimore', '443-809-8900', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Parkville Middle School', '8711 Avondale Rd', 'Baltimore', 'Maryland', '21234', 'Baltimore', '443-809-5250', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Perry Hall Middle School', '4300 Ebenezer Rd, Perry Halld', 'Baltimore', 'Maryland', '21236', 'Baltimore', '443-809-5100', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Pikesville Middle School', '7701 Seven Mile Lane, Pikesville', 'Baltimore', 'Maryland', '21208', 'Baltimore', '443-809-1207', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Pine Grove Middle School', '9200 Old Harford Rd', 'Baltimore', 'Maryland', '21234', 'Baltimore', '443-809-5271', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Ridgely Middle School', '121 Ridgely Rd, Lutherville', 'Baltimore', 'Maryland', '21093', 'Baltimore', '443-809-7650', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Rosedale Center Middle/High School', '7090 Golden Ring Rd Ste. 103, Rosedale', 'Baltimore', 'Maryland', '21237', 'Baltimore', '443-809-0133', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Southwest Academy School', '6200 Johnnycake RD', 'Baltimore', 'Maryland', '21207', 'Baltimore', '443-809-0825', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Sparrows Point Middle School', '7400 North Point Rd', 'Baltimore', 'Maryland', '21219', 'Baltimore', '443-809-7524', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Stemmers Run Middle School', '201 Stemmers Run Rd', 'Baltimore', 'Maryland', '21221', 'Baltimore', '443-809-0177', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Sudbrook Magnet Middle School', '4300 Bedford Rd', 'Baltimore', 'Maryland', '21208', 'Baltimore', '443-809-6720', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Windsor Mill Middle School', '8300 Windsor Mill RD', 'Baltimore', 'Maryland', '21244', 'Baltimore', '443-809-0618', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Woodlawn Middle School', '3033 Saint Lukes Lane', 'Baltimore', 'Maryland', '21207', 'Baltimore', '443-809-1304', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Catonsville High School', '421 Bloomsbury Ave, Catonsville', 'Baltimore', 'Maryland', '21228', 'Baltimore', '443-809-0808', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Chesapeake High School STEM Academy', '1801 Turkey Point Rd', 'Baltimore', 'Maryland', '21221', 'Baltimore', '443-809-0100', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Dulaney High School', '255 Padonia Rd, Timonium', 'Baltimore', 'Maryland', '21093', 'Baltimore', '443-809-7633', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Dundalk High School', '1901 Delvale Ave, Dundalk', 'Baltimore', 'Maryland', '21222', 'Baltimore', '443-809-7023', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Eastern Technical High School', '1100 Mace Ave', 'Baltimore', 'Maryland', '21221', 'Baltimore', '443-809-0190', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Franklin High School', '12000 Reisterstown Rd, Reisterstown', 'Baltimore', 'Maryland', '21136', 'Baltimore', '443-809-1119', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('George Washington Carver Center for Arts and Technology School', '938 York Rd', 'Baltimore', 'Maryland', '21204', 'Baltimore', '443-809-2775', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Hereford High School', '17301 York Rd, Herford', 'Baltimore', 'Maryland', '21111', 'Baltimore', '443-809-1905', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Kenwood High School', '501 Stemmers Run', 'Baltimore', 'Maryland', '21221', 'Baltimore', '443-809-0153', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Lansdowne High School', '3800 Hollins Ferry Rd', 'Baltimore', 'Maryland', '21227', 'Baltimore', '443-809-1415', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Loch Raven High School', '1212 Cowpens Ave', 'Baltimore', 'Maryland', '21286', 'Baltimore', '443-809-3525', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Milford Mill Academy School', '3800 Washington Ave, Windsor Mill', 'Baltimore', 'Maryland', '21244', 'Baltimore', '443-809-0660', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('New Town High School', '4931 New Town Blvd, Owings Mills', 'Baltimore', 'Maryland', '21117', 'Baltimore', '443-809-1614', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Overlea High School', '5401 Kenwood Ave', 'Baltimore', 'Maryland', '21206', 'Baltimore', '443-809-5241', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Owings Mills High School', '124 S Tollgate Rd, Owings Mills', 'Baltimore', 'Maryland', '21117', 'Baltimore', '443-809-1700', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Parkville High School', '2600 Putty Hill Ave', 'Baltimore', 'Maryland', '21234', 'Baltimore', '443-809-5257', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Patapsco High School and Center for the Arts', '8100 Wise Ave', 'Baltimore', 'Maryland', '21222', 'Baltimore', '443-809-7062', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Perry Hall High School', '4601 Ebenezer Rd, Perry Hall', 'Baltimore', 'Maryland', '21236', 'Baltimore', '443-809-5116', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Pikesville High School', '7621 Labyrinth Rd, Pikesville', 'Baltimore', 'Maryland', '21208', 'Baltimore', '443-809-1217', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Randallstown High School', '4000 Offutt Rd, Randallstown', 'Baltimore', 'Maryland', '21133', 'Baltimore', '443-809-0748', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Rosedale Center Middle/High School', '7090 Golden Ring., Ste. 103', 'Baltimore', 'Maryland', '21237', 'Baltimore', '443-809-0133', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Sollers Point Technical High School', '1901 Delvale Ave', 'Baltimore', 'Maryland', '21222', 'Baltimore', '443-809-7075', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Sparrows Point High School', '7400 North Point Blvd', 'Baltimore', 'Maryland', '21219', 'Baltimore', '443-809-7517', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Towson High School', '69 Cedar Ave, Towson', 'Baltimore', 'Maryland', '21286', 'Baltimore', '443-809-3608', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Western School Of Technology', '100 Kenwood Ave, Catonsville', 'Baltimore', 'Maryland', '21228', 'Baltimore', '443-809-0840', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Woodlawn High School', '1801 Woodlawn Dr', 'Baltimore', 'Maryland', '21207', 'Baltimore', '443-809-1309', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Battle Monument School', '7801 E. Collingham Dr', 'Baltimore', 'Maryland', '21222', 'Baltimore', '443-809-7000', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Catonsville Center for Alternative Studies', '901 S Rolling Rd, Catonsville', 'Baltimore', 'Maryland', '21228', 'Baltimore', '443-809-0934', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Maiden Choice School', '4901 Shelbourne Rd', 'Baltimore', 'Maryland', '21227', 'Baltimore', '443-809-1431', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Ridge Ruxton School', '6916 N Charles St', 'Baltimore', 'Maryland', '21204', 'Baltimore', '443-809-3594', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('White Oak School', '8401 Leefield Rd', 'Baltimore', 'Maryland', '21234', 'Baltimore', '443-809-5379', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('The Arrow Center for Education Tangram', '8830 Orchard Tree Lane', 'Baltimore', 'Maryland', '21286', 'Baltimore', '443-798-6310', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('The Arrow Center for Education', '311 International Circle, Cockeysville', 'Baltimore', 'Maryland', '21030', 'Baltimore', '443-588-7350', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Children''s Home Diagnostic Center School', '205 Bloomsbury Avenue, Catonsville', 'Baltimore', 'Maryland', '21228', 'Baltimore', '410-744-1083', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('The Harbour School at Baltimore', '11251 Dolfield Boulebard, Owings Mills', 'Baltimore', 'Maryland', '21117', 'Baltimore', '443-394-3760', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('High Road School of Baltimore', '11685 Crossroads Circle, Suites S-U, White Marsh', 'Baltimore', 'Maryland', '11685', 'Baltimore', '410-282-8500', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('JEWELS school', '31 Walker Ave, Baltmore', 'Baltimore', 'Maryland', '21208', 'Baltimore', '410-415-3515', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('New Direction Academy', '970 Old Harford rd, Baltimore0', 'Baltimore', 'Maryland', '21234', 'Baltimore', '410-663-8500', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('The Pathways School-Catonsville', '405 Frederick Road, Suite 100, Catonsville', 'Baltimore', 'Maryland', '21228', 'Baltimore', '410-387-4601', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('The Shafer Center for Early Intervention', '11500 Cronridge Dr, Suites 130-136, Owings Mill', 'Baltimore', 'Maryland', '21117', 'Baltimore', '410-517-1113', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Sheppard Pratt School (Hunt Valley)', '11201 Pepper Road, Hunt Valley', 'Baltimore', 'Maryland', '21030', 'Baltimore', '410-527-9505', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Sheppard Pratt School (Glyndon)', '407 Central Avenue, Reisterstown', 'Baltimore', 'Maryland', '21136', 'Baltimore', '410-517-5400', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Sheppard Pratt School and Residential Treatment Center', '6501 North Charles Street, A Building, Towson', 'Baltimore', 'Maryland', '21204', 'Baltimore', '410-938-4600', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('The Strawbridge School', '3300 Gaither Road', 'Baltimore', 'Maryland', '21244', 'Baltimore', '410-922-2100', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('The Trellis School', '14550 A York Rd, 14600 York Road, Sparks', 'Baltimore', 'Maryland', '21152', 'Baltimore', '443-330-7900', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Villa Maria School at Dulaney Valley', '2300 Dulaney Valley Road, 2600 Pot Spring Road, Timonium', 'Baltimore', 'Maryland', '21234', 'Baltimore', '667-600-3100', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Villa Maria Scholl Type III Diagnostic Program', '2600 Pot Spring Road, Timonium', 'Baltimore', 'Maryland', '21234', 'Baltimore', '667-600-3060', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Youth in Transition School', '7205 and 7310 Rutherford Road', 'Baltimore', 'Maryland', '21244', 'Baltimore', '443-780-1439', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;





--Caroline
INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Denton Elementary School', '303 Sharp Rd', 'Denton', 'Maryland', '21629', 'Caroline', '410-479-1660', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Federalsburg Elementary School', '302 S University Ave', 'Federalsburg', 'Maryland', '21632', 'Caroline', '410-479-2761', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Greensboro Elementary School', '627 N Main Street', 'Greensboro', 'Maryland', '21639', 'Caroline', '410-479-3885', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Preston Elementary School', '225 Main Street', 'Preston', 'Maryland', '21655', 'Caroline', '410-479-2897', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Ridgely Elementary School', '118 N Central Ave', 'Ridgely', 'Maryland', '21660', 'Caroline', '410-479-3243', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Colonel Richardson Middle School', '25390 Richardson Road', 'Federalsburg', 'Maryland', '21632', 'Caroline', '410-479-1462', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Lockerman Middle School', '410 Lockerman Street', 'Denton', 'Maryland', '21629', 'Caroline', '410-479-2760', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Caroline Career & Technology Center', '10855 Central Ave', 'Ridgely', 'Maryland', '21660', 'Caroline', '410-479-0100', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Colonel Richardson High School', '25320 Richardson Road', 'Federalsburg', 'Maryland', '21632', 'Caroline', '410-479-3678', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('North Caroline High School', '10990 River Road', 'Ridgely', 'Maryland', '21660', 'Caroline', '410-479-2332', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('The Benedictine School', '14299 Benedictine Lane', 'Ridgely', 'Maryland', '21660', 'Caroline', '410-634-2112', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;





--Carroll
INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Carrolltowne Elementary School', '6542 Ridge Road', 'Sykesville', 'Maryland', '21784', 'Carroll', '410-751-3530', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Cranberry Station Elementary School', '505 North Center St.', 'Westminter', 'Maryland', '21157', 'Carroll', '410-386-4440', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Ebb Valley Elementary School', '3100 Swiper Road', 'Manchester', 'Maryland', '21102', 'Carroll', '410-386-1550', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Eldersburg Elementary School', '1021 Johnsville Road', 'Sykesville', 'Maryland', '21784', 'Carroll', '410-751-3520', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Elmer A. Wolfe Elementary School', 'North Main St.', 'Union Bridge', 'Maryland', '21791', 'Carroll', '410-751-3307', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Freedom District Elementary School', '5626 Sykesville Road', 'Sykesville', 'Maryland', '21784', 'Carroll', '410-751-3525', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Friendship Valley Elementary School', '1100 Gist Road', 'Westminster', 'Maryland', '21157', 'Carroll', '410-751-3650', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Hampstead Elementary School', '3737 Shiloh Road', 'Hampstead', 'Maryland', '21074', 'Carroll', '410-751-3420', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Linton Springs Elementary School', '375 Ronsdale Road', 'Sykesville', 'Maryland', '21784', 'Carroll', '410-751-3280', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Manchester Elementary School', '3224 York Street', 'Manchester', 'Maryland', '21102', 'Carroll', '410-751-3410', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Mechanicsville Elementary School', '3838 Sykesville Road', 'Sykesville', 'Maryland', '21784', 'Carroll', '410-751-3516', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Mt. Airy Elementary School', '405 N. Main Street', 'Mount Airy', 'Maryland', '21771', 'Carroll', '410-751-3540', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Parr''s Ridge Elementary School', '202 Watersville Road', 'Mount Airy', 'Maryland', '21771', 'Carroll', '410-751-3559', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Piney Ridge Elementary School', '6315 Freedom Avenue', 'Sykesville', 'Maryland', '21784', 'Carroll', '410-751-3535', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Robert Moton Elementary School', '1413 Washington Road', 'Westminster', 'Maryland', '21157', 'Carroll', '410-751-3610', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Runnymede Elementary School', '3000 Langdon Drive', 'Westminster', 'Maryland', '21157', 'Carroll', '410-751-3203', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Sandymount Elementary School', '2222 Old Westminster Pike', 'Finksburg', 'Maryland', '21048', 'Carroll', '410-751-3215', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Spring Garden Elementary School', '700 Boxwood Drive', 'Hampstead', 'Maryland', '21074', 'Carroll', '410-751-3433', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Taneytown Elementary School', '100 Kings Drive', 'Taneytown', 'Maryland', '21787', 'Carroll', '410-751-3260', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Westminster Elementary School', '811 Uniontown Road', 'Westminster', 'Maryland', '21157', 'Carroll', '410-751-3222', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('William Winchester Elementary School', '70 Monroe Street', 'Westminster', 'Maryland', '21157', 'Carroll', '410-751-3230', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Winfield Elementary School', '4401 Salem Bottom Road', 'Westminster', 'Maryland', '21157', 'Carroll', '410-751-3242', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('East Middle School', '121 Longwell Avenue', 'Westminster', 'Maryland', '21157', 'Carroll', '410-751-3242', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Mt. Airy Middle School', '102 Watersville Road', 'Mount Airy', 'Maryland', '21771', 'Carroll', '410-751-3554', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('North Carroll Middle School', '2401 Hanover Pike', 'Hampstead', 'Maryland', '21074', 'Carroll', '410-751-3440', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Northwest Middle School', '99 Kings Drive', 'Taneytown', 'Maryland', '21787', 'Carroll', '410-751-3270', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Oklahoma Road Middle School', '6300 Oklahoma Road', 'Sykesville', 'Maryland', '21784', 'Carroll', '410-751-3600', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Shiloh Middle School', '3675 Willow Street', 'Hampstead', 'Maryland', '21074', 'Carroll', '410-386-4570', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Sykesville Middle School', '7301 Springfield Avenue', 'Sykesville', 'Maryland', '21784', 'Carroll', '410-751-3545', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('West Middle School', '60 Monroe Street', 'Westminster', 'Maryland', '21157', 'Carroll', '410-751-3661', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Century High School', '355 Ronsdale Road', 'Sykesville', 'Maryland', '21784', 'Carroll', '410-386-4400', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Francis Scott Key High School', '3825 Bark Hill Road', 'Union Bridge', 'Maryland', '21791', 'Carroll', '410-751-3320', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Liberty High School', '5855 Bartholow Road', 'Eldersburg', 'Maryland', '21784', 'Carroll', '410-751-3560', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Manchester Valley High School', '3300 Maple Grove Road', 'Manchester', 'Maryland', '21102', 'Carroll', '410-386-1673', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('South Carroll High School', '1300 W. Old Liberty Road', 'Sykesville', 'Maryland', '21784', 'Carroll', '410-751-3575', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Westminster High School', '1225 Washington Road', 'Wesminster', 'Maryland', '21157', 'Carroll', '410-751-3630', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Winters Mill High School', '560 Gorsuch Road', 'Westminster', 'Maryland', '21157', 'Carroll', '410-386-1500', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Carroll County Career and Technology Cente', '1229 Washington Road', 'Westminster', 'Maryland', '21157', 'Carroll', '410-751-3669', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Carroll Springs School', '495 South Center Street', 'Westminster', 'Maryland', '21157', 'Carroll', '410-751-3620', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Gateway School', '45 Kate Wagner Road', 'Westminster', 'Maryland', '21157', 'Carroll', '410-751-3691', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Silver Oak Academy', '999 Crouse Mill road', 'Keymar', 'Maryland', '21757', 'Carroll', '410-775-1745', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;




--Charles

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Arthur Middleton Elementary School', '1109 Copley Avenue', 'Waldorf', 'Maryland', '20602', 'Charles', '301-753-1749', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Berry Elementary School', '10155 Berry Road', 'Waldorf', 'Maryland', '20603', 'Charles', '301-753-1782', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Billingsley Elementary School', '10069 Billingsley Road', 'White Plains', 'Maryland', '20695', 'Charles', '301-753-2088', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('C. Paul Barnhart Elementary School', '4800 Lancaster Circle', 'Waldorf', 'Maryland', '20603', 'Charles', '301-753-1781', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Daniel of St. Thomas Jenifer Elementary School', '2820 Jenifer School Lane', 'Waldorf', 'Maryland', '20603', 'Charles', '301-753-1768', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Dr. Gustavus Brown Elementary School', '421 Univerity Drive', 'Waldorf', 'Maryland', '20603', 'Charles', '301-753-1741', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Dr. James Craik Elementary School', '7725 Marshall Corner Road', 'Pomfret', 'Maryland', '20675', 'Charles', '301-753-1742', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Dr. Samuel A. Mudd Elementary School', '820 Stone Avenue', 'Waldorf', 'Maryland', '20603', 'Charles', '301-753-1762 ', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Dr. Thomas L. Higdon Elementary School', '12872 Rock Point Road', 'Newburg', 'Maryland', '20664', 'Charles', '301-753-1766', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Eva Turner Elementary School', '1000 Bannister Circle', 'Waldorf', 'Maryland', '20603', 'Charles', '301-753-1765', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Gale-Bailey Elementary School', '4740 Pisgah-Marbury Road', 'Marbury', 'Maryland', '20658', 'Charles', '301-753-1743', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Indian Head Elementary School', '4200 Indian Head Highway', 'Indian Head', 'Maryland', '20640', 'Charles', '301-753-1746', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('J.C. Parks Elementary School', '3505 Livingston Road', 'Indian Head', 'Maryland', '20640', 'Charles', '301-753-1763', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('J.P. Ryon Elementary School', '12140 Vivian Adams Drive', 'Waldorf', 'Maryland', '20603', 'Charles', '301-753-1764', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Malcolm Elementary School', '14760 Poplar Hill Road', 'Waldorf', 'Maryland', '20603', 'Charles', '301-753-1747', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Mary B. Neal Elementary School', '12105 St. Georges Drive', 'Waldorf', 'Maryland', '20603', 'Charles', '301-753-2086', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Mary H. Matula Elementary School', '6025 Radio Station Road', 'La Plata', 'Maryland', '20646', 'Charles', '301-753-1780 ', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Mt. Hope/Nanjemoy Elementary School', '9275 Ironsides Road', 'Nanjemoy', 'Maryland', '20662', 'Charles', '301-753-1761', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('T.C. Martin Elementary School', '6315 Oliver Shop Road', 'Bryantown', 'Maryland', '20617', 'Charles', '301-753-1748', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Walter J. Mitchell Elementary School', '400 Willow Lane', 'La Plata', 'Maryland', '20646', 'Charles', '301-753-1760', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('William A. Diggs Elementary School', '2615 Davis Road', 'Waldorf', 'Maryland', '20603', 'Charles', '301-753-2081', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('William B. Wade Elementary School', '2300 Smallwood Drive West', 'Waldorf', 'Maryland', '20603', 'Charles', '301-753-1769', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Benjamin Stoddert Middle School', '2040 St. Thomas Drive', 'Waldorf', 'Maryland', '20603', 'Charles', '301-753-1788', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('General Smallwood Middle School', '4990 Indian Head Highway', 'Indian Head', 'Maryland', '20640', 'Charles', '301-753-1786', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('John Hanson Middle School', '3165 John Hanson Drive', 'Waldorf', 'Maryland', '20603', 'Charles', '301-753-1783', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Mattawoman Middle School', '10145 Berry Road', 'Waldorf', 'Maryland', '20603', 'Charles', '301-753-1789', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Matthew Henson Middle School', '3535 Livingston Road', 'Indian Head', 'Maryland', '20640', 'Charles', '301-753-1784', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Milton M. Somers Middle School', '300 Willow Lane', 'La Plata', 'Maryland', '20646', 'Charles', '301-753-1787', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Piccowaxen Middle School', '12834 Rock Point Road', 'Newburg', 'Maryland', '20664', 'Charles', '301-753-1785', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Theodore G. Davis Middle School', '2495 Davis Road', 'Waldorf', 'Maryland', '20603', 'Charles', '301-753-2082', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Phoenix International School of the Arts (PISOTA)', '95 Catalpa Drive', 'La Plata', 'Maryland', '20646', 'Charles', '301-753-2098', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Henry E. Lackey High School', '3000 Chicamuxen Road', 'Indian Head', 'Maryland', '20640', 'Charles', '301-753-1753', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('La Plata High School', '6035 Radio Station Road', 'La Plata', 'Maryland', '20646', 'Charles', '301-753-1754', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Maurice J. McDonough High School', '7165 Marshall Corner Road', 'Pomfret', 'Maryland', '20675', 'Charles', '301-753-1755', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('North Point High School', '2500 Davis Road', 'Waldorf', 'Maryland', '20603', 'Charles', '301-753-1759', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('St. Charles High School', '5305 Piney Church Road', 'Waldorf', 'Maryland', '20603', 'Charles', '301-753-2090', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Thomas Stone High School', '3785 Leonardtown Road', 'Waldorf', 'Maryland', '20603', 'Charles', '301-753-1756', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Westlake High School', '3300 Middletown Road', 'Waldorf', 'Maryland', '20603', 'Charles', '301-753-1758', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference
("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES 
('Early Learning Center, La Plata', '8730 Mitchell Road', 'La Plata', 'Maryland', '20646', 'Charles', '240-776-5804', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Early Learning Center, Waldorf', '3155 John Hanson Drive', 'Waldorf', 'Maryland', '20603', 'Charles', '240-776-5803', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('F.B. Gwynn Educational Center', '5998 Radio Station Road', 'La Plata', 'Maryland', '20646', 'Charles', '301-753-1745', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('James E. Richmond Science Center', '5305 Piney Church Road', 'Waldorf', 'Maryland', '20603', 'Charles', '301-934-7464', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Charles County Judy Center', '820 Stone Avenue', 'Waldorf', 'Maryland', '20603', 'Charles', '(240) 776-5905', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Nanjemoy Creek Environmental Education Center', '5300 Turkey Tayac Place', 'Nanjemoy', 'Maryland', '20662', 'Charles', '301-743-3526', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Robert D. Stethem Educational Center', '7775 Marshall Corner Road', 'Pomfret', 'Maryland', '20675', 'Charles', '301-753-1757', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;


--Cecil

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Bainbridge Elementary School', '41 Preston Drive', 'Port Deposit', 'Maryland', '21904', 'Cecil', '410-996-6030', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Bay View Elementary School', '910 North East Road', 'North East', 'Maryland', '21901', 'Cecil', '410-996-6230', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Calvert Elementary School', '79 Brick Meetinghouse Road', 'Rising Sun', 'Maryland', '21911', 'Cecil', '410-658-5335', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Cecil Manor Elementary School', '971 Elk Mills Road', 'Elkton', 'Maryland', '21921', 'Cecil', '410-996-5090', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Cecilton Elementary School', '251 West Main Street', 'Cecilton', 'Maryland', '21913', 'Cecil', '410-275-1000', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Charlestown Elementary School', '550 Baltimore Street', 'Charlestown', 'Maryland', '21914', 'Cecil', '410-996-6240', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Chesapeake Elementary School', '2801 Augustine Herman Highway', 'Chesapeake City', 'Maryland', '21915', 'Cecil', '410-885-2085', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Conowingo Elementary School', '471 Rowlandsville Road', 'Conowingo', 'Maryland', '21918', 'Cecil', '410-996-6040', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Elk Neck Elementary School', '41 Racine School Road', 'Elkton', 'Maryland', '21921', 'Cecil', '410-996-5030', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Gilpin Manor Elementary School', '203 Newark Avenue', 'Elkton', 'Maryland', '21921', 'Cecil', '410-996-5040', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Holly Hall Elementary School', '233 Whitehall Road', 'Elkton', 'Maryland', '21921', 'Cecil', '410-996-5050', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Kenmore Elementary School', '2475 Singerly Road', 'Elkton', 'Maryland', '21921', 'Cecil', '410-996-5060', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Leeds Elementary School', '615 Deaver Road', 'Elkton', 'Maryland', '21921', 'Cecil', '410-996-5070', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('North East Elementary School', '301 Thomas Avenue', 'North East', 'Maryland', '21901', 'Cecil', '410-996-6220', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Perryville Elementary School', '901 Maywood Avenue', 'Perryville', 'Maryland', '21903', 'Cecil', '410-642-6540', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Rising Sun Elementary School', '500 Hopewell Road', 'Rising Sun', 'Maryland', '21911', 'Cecil', '410-658-5925', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Thomson Estates Elementary School', '203 E. Thomson Drive', 'Elkton', 'Maryland', '21921', 'Cecil', '410-996-5080', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Bohemia Manor Middle School', '2757 Augustine Herman Highway', 'Chesapeake City', 'Maryland', '21915', 'Cecil', '410-885-2095', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Cherry Hill Middle School', '2535 Singerly Road', 'Elkton', 'Maryland', '21921', 'Cecil', '410-996-5020', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Elkton Middle School', '615 North Street', 'Elkton', 'Maryland', '21921', 'Cecil', '410-996-5010', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('North East Middle School', '200 East Cecil Avenue', 'North East', 'Maryland', '21901', 'Cecil', '410-996-6210', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Perryville Middle School', '850 Aiken Avenue', 'Perryville', 'Maryland', '21903', 'Cecil', '410-996-6010', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Rising Sun Middle School', '289 Pearl Street', 'Rising Sun', 'Maryland', '21911', 'Cecil', '410-658-5535', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Bohemia Manor High School', '2755 Augustine Herman Hwy', 'Chesapeake City', 'Maryland', '21915', 'Cecil', '410-885-2075', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Cecil County School of Technology', '912 Appleton Road', 'Elkton', 'Maryland', '21921', 'Cecil', '410-392-8879', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Elkton High School', '110 James Street', 'Elkton', 'Maryland', '21921', 'Cecil', '410-996-5000', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('North East High School', '300 Irishtown Road', 'North East', 'Maryland', '21901', 'Cecil', '410-996-6200', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Perryville High School', '1696 Perryville Road', 'Perryville', 'Maryland', '21903', 'Cecil', '410-996-6000', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Rising Sun High School', '100 Tiger Drive', 'North East', 'Maryland', '21901', 'Cecil', '410-658-9115', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('High Road School of Cecil County', '3035 Singerly Road', 'Elkton', 'Maryland', '21921', 'Cecil', '410-398-6900', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Shorehaven School', '1040 Singerly Road', 'Elkton', 'Maryland', '21921', 'Cecil', '410-398-1800', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;


--Dorchester

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Choptank Elementary School', '1103 Mace''s Lane Road', 'Cambridge', 'Maryland', '21613', 'Dorchester', '(410) 228-4950', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Hurlock Elementary School', '301 Charles Street', 'Hurlock', 'Maryland', '21643', 'Dorchester', '(410) 943-3303', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Maple Elementary School', '5225 Egypt Road', 'Cambridge', 'Maryland', '21613', 'Dorchester', '(410) 228-8577', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Sandy Hill Elementary School', '1503 Glasgow Street', 'Cambridge', 'Maryland', '21613', 'Dorchester', '(410) 228-7978', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('South Dorchester School', '3485 Golden Hill Road', 'Church Creek', 'Maryland', '21622', 'Dorchester', '(410) 901-6934', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Vienna Elementary School', '4905 Ocean Gateway', 'Vienna', 'Maryland', '21869', 'Dorchester', '(410) 943-3775', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Warwick Elementary School', '155 Main Street', 'Secretary', 'Maryland', '21664', 'Dorchester', '(410) 943-3588', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Mace''s Lane Middle School', '1101 Mace''s Lane Road', 'Cambridge', 'Maryland', '21613', 'Dorchester', '(410) 228-2111', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('North Dorchester Middle School', '5745 Cloverdale Road', 'Hurlock', 'Maryland', '21643', 'Dorchester', '(410) 943-3322', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Cambridge-South Dorchester High School', '2475 Cambridge Beltway', 'Cambridge', 'Maryland', '21613', 'Dorchester', '(410) 228-9224', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('North Dorchester High School', '5875 Cloverdale Road', 'Hurlock', 'Maryland', '21643', 'Dorchester', '(410) 943-4511', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Dorchester Career & Technology Center', '2465 Cambridge Beltway', 'Cambridge', 'Maryland', '21613', 'Dorchester', '(410) 901-6950', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;


--Frederick

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Ballenger Creek Elementary School', '5250 Kingsbrook Drive', 'Frederick', 'Maryland', '21703', 'Frederick', '227-203-1880', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Blue Heron Elementary School', '7100 Eaglehead Drive', 'New Market', 'Maryland', '21774', 'Frederick', '227-203-1820', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Brunswick Elementary School', '400 Central Avenue', 'Brunswick', 'Maryland', '21716', 'Frederick', '227-203-1860', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Butterfly Ridge Elementary School', '601 Contender Way', 'Frederick', 'Maryland', '21703', 'Frederick', '227-203-1840', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Carroll Manor Elementary School', '5624 Adamstown Road', 'Adamstown', 'Maryland', '21710', 'Frederick', '227-203-1900', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Centerville Elementary School', '3601 Carriage Hill Drive', 'Frederick', 'Maryland', '21704', 'Frederick', '227-203-1780', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Deer Crossing Elementary School', '10601 Finn Drive', 'New Market', 'Maryland', '21774', 'Frederick', '227-203-1760', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Emmitsburg Elementary School', '300 S. Seton Avenue', 'Emmitsburg', 'Maryland', '21727', 'Frederick', '227-203-1720', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Glade Elementary School', '9525 Glade Road', 'Walkersville', 'Maryland', '21793', 'Frederick', '227-203-1700', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Green Valley Elementary School', '11501 Fingerboard Road', 'Monrovia', 'Maryland', '21770', 'Frederick', '227-203-1680', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Hillcrest Elementary School', '1285 Hillcrest Drive', 'Frederick', 'Maryland', '21703', 'Frederick', '227-203-1660', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Kemptown Elementary School', '3456 Kemptown Church Road', 'Monrovia', 'Maryland', '21770', 'Frederick', '227-203-1640', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Lewistown Elementary School', '11119 Hessong Bridge Road', 'Thurmont', 'Maryland', '21788', 'Frederick', '227-203-1620', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Liberty Elementary School', '11820 Liberty Road', 'Frederick', 'Maryland', '21701', 'Frederick', '227-203-1540', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Lincoln Elementary School', '200 Madison Street', 'Frederick', 'Maryland', '21701', 'Frederick', '227-203-1580', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Middletown Elementary School', '201 East Green Street', 'Middletown', 'Maryland', '21769', 'Frederick', '227-203-1560', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Middletown Primary School', '403 Franklin Street', 'Middletown', 'Maryland', '21769', 'Frederick', '227-203-1540', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Monocacy Elementary School', '7421 Hayward Road', 'Frederick', 'Maryland', '21702', 'Frederick', '227-203-1520', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Myersville Elementary School', '429 Main Street', 'Myersville', 'Maryland', '21773', 'Frederick', '227-203-1500', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('New Market Elementary School', '93 West Main Street', 'New Market', 'Maryland', '21774', 'Frederick', '227-203-1460', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('New Midway', '12226 Woodsboro Pike', 'Keymar', 'Maryland', '21757', 'Frederick', '227-203-1440', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Woodsboro', '101 Liberty Road', 'Woodsboro', 'Maryland', '21798', 'Frederick', '227-203-1100', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('North Frederick Elementary School', '1010 Fairview Avenue', 'Frederick', 'Maryland', '21701', 'Frederick', '227-203-1380', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Oakdale Elementary School', '5830 Oakdale School Road', 'Ijamsville', 'Maryland', '21754', 'Frederick', '227-203-1420', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Orchard Grove Elementary School', '5898 Hannor Drive', 'Frederick', 'Maryland', '21703', 'Frederick', '227-203-1400', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Parkway Elementary School', '300 Carrol Parkway', 'Frederick', 'Maryland', '21701', 'Frederick', '227-203-1300', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Spring Ridge Elementary School', '9051 Ridgefield Drive', 'Frederick', 'Maryland', '21701', 'Frederick', '227-203-1340', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Sugarloaf Elementary School', '3400 Stone Barn Drive', 'Frederick', 'Maryland', '21704', 'Frederick', '227-203-1320', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Thurmont Elementary School', '805 East Main Street', 'Thurmont', 'Maryland', '21788', 'Frederick', '227-203-1240', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Thurmont Primary Elementary School', '7989 Rocky Ridge Road', 'Thurmont', 'Maryland', '21788', 'Frederick', '227-203-1280', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Tuscarora Elementary School', '6321 Lambert Drive', 'Frederick', 'Maryland', '21703', 'Frederick', '227-203-1260', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Twin Ridge Elementary School', '1106 Leafy Hollow Circle', 'Mount Airy', 'Maryland', '21771', 'Frederick', '227-203-1240', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Urbana Elementary School', '3554 Urbana Pike', 'Frederick', 'Maryland', '21704', 'Frederick', '227-203-1220', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Valley Elementary School', '3519 Jefferson Pike', 'Jefferson', 'Maryland', '21755', 'Frederick', '227-203-1200', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Walkersville Elementary School', '83 West Frederick Street', 'Walkersville', 'Maryland', '21793', 'Frederick', '227-203-1180', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Waverley Elementary School', '201 Waverley Drive', 'Frederick', 'Maryland', '21702', 'Frederick', '227-203-1160', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Whittier Elementary School', '2400 Whittier Drive', 'Frederick', 'Maryland', '21702', 'Frederick', '227-203-1140', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Wolfsville Elementary School', '12520 Wolfsville Road', 'Myersville', 'Maryland', '21773', 'Frederick', '227-203-1120', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Ballenger Creek Middle School', '5525 Ballenger Creek Pike', 'Frederick', 'Maryland', '21703', 'Frederick', '227-203-2150', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Brunswick Middle School', '301 Cummings Drive', 'Brunswick', 'Maryland', '21716', 'Frederick', '227-203-2200', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Crestwood Middle School', '7100 Foxcroft Drive', 'Frederick', 'Maryland', '21703', 'Frederick', '227-203-2250', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Governor Thomas Johnson', '1799 Schifferstadt Blvd', 'Frederick', 'Maryland', '21702', 'Frederick', '227-203-2550', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Middletown Middle School', '100 Martha Mason Street', 'Middletown', 'Maryland', '21769', 'Frederick', '227-203-2300', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Monocacy Middle School', '8009 Opossumtown Pike', 'Frederick', 'Maryland', '21702', 'Frederick', '227-203-2350', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('New Market Middle School', '125 West Main Street', 'New Market', 'Maryland', '21774', 'Frederick', '227-203-2400', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Oakdale Middle School', '5810 Oakdale School Road', 'Ijamsville', 'Maryland', '21754', 'Frederick', '227-203-2450', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Thurmont Middle School', '408 East Main Street', 'Thurmont', 'Maryland', '21788', 'Frederick', '227-203-2500', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Urbana Middle School', '3511 Pontius Court', 'Ijamsville', 'Maryland', '21754', 'Frederick', '227-203-2600', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Walkersville Middle School', '55 West Frederick Street', 'Walkersville', 'Maryland', '21793', 'Frederick', '227-203-2650', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('West Frederick Middle School', '515 West Patrick Street', 'Frederick', 'Maryland', '21701', 'Frederick', '227-203-2700', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Windsor Knolls Middle School', '11150 Windsor Road', 'Ijamsville', 'Maryland', '21754', 'Frederick', '227-203-2750', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Brunswick High School', '101 Cummings Drive', 'Brunswick', 'Maryland', '21716', 'Frederick', '227-203-3200', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Career & Technology Center', '7922 Opossumtown Pike', 'Frederick', 'Maryland', '21702', 'Frederick', '227-203-3650', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Catoctin High School', '14745 Sabillasville Road', 'Thurmont', 'Maryland', '21788', 'Frederick', '227-203-3150', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Frederick High School', '650 Carroll Parkway', 'Frederick', 'Maryland', '21701', 'Frederick', '227-203-3300', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Frederick County Virtual School', '57 W Frederick Street', 'Walkersville', 'Maryland', '21793', 'Frederick', '227-203-3780', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Governor Thomas Johnson High School', '1501 North Market Street', 'Frederick', 'Maryland', '21701', 'Frederick', '227-203-3450', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Linganore High School', '12013 Old Annapolis Road', 'Frederick', 'Maryland', '21701', 'Frederick', '227-203-3500', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Middletown High School', '200 Schoolhouse Drive', 'Middletown', 'Maryland', '21769', 'Frederick', '227-203-3600', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Monocacy Valley Montessori', '64 Thomas Johnson Drive', 'Frederick', 'Maryland', '21702', 'Frederick', '227-203-3860', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Oakdale High School', '5850 Eaglehead Drive', 'Ijamsville', 'Maryland', '21754', 'Frederick', '227-203-3400', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Tuscarora High School', '2312 Ballenger Creek Pike', 'Frederick', 'Maryland', '21703', 'Frederick', '227-203-3100', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Urbana High School', '3471 Campus Drive', 'Ijamsville', 'Maryland', '21754', 'Frederick', '227-203-3500', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Walkersville High School', '81 West Frederick Street', 'Walkersville', 'Maryland', '21793', 'Frederick', '227-203-3350', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Carroll Creek Montessori', '7215 Corporate Court', 'Frederick', 'Maryland', '21703', 'Frederick', '227-203-3822', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Frederick Classical Charter', '8445 Spires Way', 'Frederick', 'Maryland', '21701', 'Frederick', '227-203-3840', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Sabillasville Environmental School', '16210 B Sabillasville Road', 'Sabillasville', 'Maryland', '21780', 'Frederick', '227-203-1360', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('High Roads of Frederick County', '8450 Broadband Drive', 'Frederick', 'Maryland', '21701', 'Frederick', '240-410-0380', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Laurel Hall School in Frederick', '4540 B-D Mack Avenue', 'Frederick', 'Maryland', '21703', 'Frederick', '301-698-5665', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Sheppard Pratt School (Frederick County)', '1285 Hillcrest Drive', 'Frederick', 'Maryland', '21703', 'Frederick', '240-651-1570', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Woodsboro/New Middway Elementary School', '12226 Woodsboro Pike, Keymar/101 Liberty Rd', 'Woodsboro', 'Maryland', '21757', 'Frederick', '240-651-1570', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

--Garrett

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Accident Elementary School', '534 Accident Bittinger Rd', 'Accident', 'Maryland', '21520', 'Garrett', '301-746-8863', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Broad Ford Elementary School', '607 Harvey Winters Rd', 'Oakland', 'Maryland', '21550', 'Garrett', '301-334-9445', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Crellin Elementary School', '115 Kendall Dr', 'Crellin', 'Maryland', '21550', 'Garrett', '301-334-4707', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Friendsville Elementary School', '841 First Ave', 'Friendsville', 'Maryland', '21531', 'Garrett', '301-746-5100', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Grantsville Elementary School', '120 Grant St', 'Grantsville', 'Maryland', '21536', 'Garrett', '301-895-5173', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Route 40 Elementary School', '17764 National Pike', 'Frostburg', 'Maryland', '21532', 'Garrett', '301-689-6132', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Swan Meadow School', '6709 Garrett Highway', 'Oakland', 'Maryland', '21550', 'Garrett', '301-334-2059', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Yough Glades Elementary School', '70 Wolf Acres Dr', 'Oakland', 'Maryland', '21550', 'Garrett', '301-334-3334', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('North Garrett Middle School', '371 Pride Parkway', 'Accident', 'Maryland', '21520', 'Garrett', '301-746-8165', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Northern Garrett High School', '86 Pride Parkway', 'Accident', 'Maryland', '21520', 'Garrett', '301-746-8668', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Southern Garrett High School', '345 Oakland Dr', 'Oakland', 'Maryland', '21550', 'Garrett', '301-334-9447', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Hickory Environmental Educational Center', '604 Pride Parkway', 'Accident', 'Maryland', '21520', 'Garrett', '301-746-8461', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;


--Harford

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Aberdeen Middle School', '111 Mount Royal Ave', 'Aberdeen', 'Maryland', '21001', 'Harford', '410-273-5510', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Aberdeen High School', '251 Paradise RD', 'Aberdeen', 'Maryland', '21001', 'Harford', '410-273-5500', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Abingdon Elementary School', '3001 S Tolgate Rd', 'Abingdon', 'Maryland', '21009', 'Harford', '410-638-3910', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Bakerfield Elementary School', '36 Baker St', 'Aberdeen', 'Maryland', '21001', 'Harford', '410-273-5518', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Bel Air Elementary School', '30 East Lee St', 'Bel Air', 'Maryland', '21014', 'Harford', '410-638-4160', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Bel Air Middle School', '99 Idlewild St', 'Bel Air', 'Maryland', '21014', 'Harford', '410-638-4140', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Bel Air High School', '100 Heighe St', 'Bel Air', 'Maryland', '21014', 'Harford', '410-638-4600', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('C. Milton Wright High School', '1301 North Fountain Green Rd', 'Bel Air', 'Maryland', '21015', 'Harford', '410-638-4110', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Church Creek Elementary School', '4299 Church Creek Rd', 'Belcamp', 'Maryland', '21017', 'Harford', '410-273-5550', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Churchville Elementary School', '2935 Level Rd', 'Churchville', 'Maryland', '21028', 'Harford', '410-638-3800', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Darlington Elementary School', '2119 Shuresville Rd', 'Darlington', 'Maryland', '21034', 'Harford', '410-638-3700', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Deerfield Elementary School', '2307 Willoughby Beach Rd', 'Edgewood', 'Maryland', '21040', 'Harford', '410-612-1535', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Dublin Elementary School', '1527 Whiteford Rd', 'Street', 'Maryland', '21154', 'Harford', '410-638-3703', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Edgewood Elementary School', '2100 Cedar Dr', 'Edgewood', 'Maryland', '21040', 'Harford', '410-612-1540', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Edgewood Middle School', '2311 Willoughby Beach Rd', 'Edgewood', 'Maryland', '21040', 'Harford', '410-612-1518', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Edgewood High School', '2415 Willoughby Beach Rd', 'Edgewood', 'Maryland', '21040', 'Harford', '410-612-1500', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Emmorton Elementary School', '2502 Tollgate Rd', 'Bel Air', 'Maryland', '21015', 'Harford', '410-638-3920', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Fallston Middle School', '2303 Carrs Mill Rd', 'Fallston', 'Maryland', '21047', 'Harford', '410-638-4129', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Fallston High School', '2301 Carrs Mill Rd', 'Fallston', 'Maryland', '21047', 'Harford', '410-638-4120', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Forest Hill Elementary School', '2407 Rocks Rd', 'Forest Hill', 'Maryland', '21050', 'Harford', '410-638-4166', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Forest Lakes Elementary School', '100 Osborne Parkway', 'Forest Hill', 'Maryland', '21050', 'Harford', '410-638-4262', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Fountain Green Elementary School', '517 South Fountain Green Rd', 'Bel Air', 'Maryland', '21015', 'Harford', '410-638-4220', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('George D. Lisby Elementary School', '810 Edmund St', 'Aberdeen', 'Maryland', '21001', 'Harford', '410-273-5530', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Hall''s Cross Roads Elementary School', '203 East Bel Air Ave', 'Aberdeen', 'Maryland', '21001', 'Harford', '410-273-5524', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Harford Academy', '100 Thomas Run Rd', 'Bel Air', 'Maryland', '21015', 'Harford', '410-638-3810', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Harford Technical High School', '200 Thomas Run Rd', 'Bel Air', 'Maryland', '21015', 'Harford', '410-638-3804', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Havre de Grace Elementary School', '600 Juniata St', 'Havre De Grace', 'Maryland', '21078', 'Harford', '410-939-6616', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Havre de Grace Middle/High School', '445 Lewis Lane', 'Havre De Grace', 'Maryland', '21078', 'Harford', '410-939-6608', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Hickory Elementary School', '2100 Conowingo School', 'Bel Air', 'Maryland', '21014', 'Harford', '410-638-4170', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Homestead/Wakefield Elementary School', '900 South Main St', 'Bel Air', 'Maryland', '21014', 'Harford', '410-638-4175', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Jarrettsville Elementary School', '3818 Norrisville Rd', 'Jarrettsville', 'Maryland', '21084', 'Harford', '410-692-7800', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Joppatowne Elementary School', '407 Trimble Rd', 'Joppa', 'Maryland', '21085', 'Harford', '410-612-1546', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Joppatowne High School', '555 Joppa Farm Rd', 'Joppa', 'Maryland', '21085', 'Harford', '410-612-1510', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Magnolia Elementary School', '901 Trimble Rd', 'Joppa', 'Maryland', '21085', 'Harford', '410-612-1553', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Magnolia Middle School', '299 Fort Hoyle Rd', 'Joppa', 'Maryland', '21085', 'Harford', '410-612-1525', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Meadowvale Elementary School', '910 Graceview Dr', 'Havre De Grace', 'Maryland', '21078', 'Harford', '410-939-6622', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Norrisville Elementary School', '5302 Norrisville Rd', 'White Hall', 'Maryland', '21161', 'Harford', '410-692-7810', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('North Bend Elementary School', '1445 North Bend Rd', 'Jarrettsville', 'Maryland', '21084', 'Harford', '410-692-7815', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('North Harford Elementary School', '120 Pylesville Rd', 'Pylesville', 'Maryland', '21132', 'Harford', '410-638-3670', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('North Harford Middle School', '112 Pylesville Rd', 'Pylesville', 'Maryland', '21132', 'Harford', '410-638-3650', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Old Post Road Elementary School', '2706 Philadelphia Rd', 'Abingdon', 'Maryland', '21009', 'Harford', '410-612-2033', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Patterson Mill Middle/High School', '85 Patterson Mill Road', 'Bel Air', 'Maryland', '21015', 'Harford', '410-638-4640', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Prospect Mill Elementary School', '101 Prospect Mill Rd', 'Bel Air', 'Maryland', '21015', 'Harford', '410-638-3817', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Red Pump Elementary School', '600 Red Pump Rd', 'Bel Air', 'Maryland', '21014', 'Harford', '410-638-4252', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Ring Factory Elementary School', '1400 Emmorton Rd', 'Bel Air', 'Maryland', '21014', 'Harford', '410-638-4186', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Riverside Elementary School', '211 Stillmeadow Dr', 'Joppa', 'Maryland', '21085', 'Harford', '410-612-1560', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Roye-Williams Elementary School', '201 Oakington Rd', 'Havre De Grace', 'Maryland', '21078', 'Harford', '410-273-5536', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Southhampton Middle School', '1200 Moores Mill Rd', 'Bel Air', 'Maryland', '21014', 'Harford', '410-638-4150', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Swan Creek School', '253 Paradise Rd', 'Aberdeen', 'Maryland', '21001', 'Harford', '410-273-5594', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('William S. James Elementary School', '1 Laurentum Parkway', 'Abingdon', 'Maryland', '21009', 'Harford', '410-638-3900', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Youth''s Benefit Elementary School', '1901 Fallston Rd', 'Fallston', 'Maryland', '21047', 'Harford', '410-638-4190', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('The Arrow Center for Education Riverside', '1370 Brass Mill Road', 'Belcamp', 'Maryland', '21017', 'Harford', '410-297-4100', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('High Road School of Harford County', '1250 Brass Mill Road', 'Belcamp', 'Maryland', '21017', 'Harford', '410-272-1123', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

--Howard

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Atholton Elementary School', '6700 Seneca Drive', 'Columbia', 'Maryland', '21044', 'Howard', '410-313-6853', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Bellows Spring Elementary School', '8125 Old Stockbridge Road', 'Ellicott City', 'Maryland', '21043', 'Howard', '410-313-5057', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Bollman Bridge Elementary School', '8200 Savage-Guilford Road', 'Savage', 'Maryland', '20763', 'Howard', '410-880-5920', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Bryant Woods Elementary School', '5450 Blue Heron Lane', 'Columbia', 'Maryland', '21044', 'Howard', '410-313-6859', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Bushy Park Elementary School', '14601 Carrs Mill Road', 'Glenwood', 'Maryland', '21738', 'Howard', '410-313-5500', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Centennial Lane Elementary School', '3825 Centennial Lane', 'Ellicott City', 'Maryland', '21042', 'Howard', '410-313-2800', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Clarksville Elementary School', '12041 Clarksville Pike', 'Clarksville', 'Maryland', '21029', 'Howard', '410-313-7050', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Clemens Crossing Elementary School', '10320 Quarterstaff Road', 'Columbia', 'Maryland', '21044', 'Howard', '410-313-6866', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Cradlerock Elementary School', '6700 Cradlerock Way', 'Columbia', 'Maryland', '21045', 'Howard', '410-313-7610', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Dayton Oaks Elementary School', '4691 Ten Oaks Road', 'Dayton', 'Maryland', '21036', 'Howard', '410-313-1571', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Deep Run Elementary School', '6925 Old Waterloo Road', 'Elkridge', 'Maryland', '21075', 'Howard', '410-313-5000', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Ducketts Lane Elementary School', '6501 Ducketts Lane', 'Elkridge', 'Maryland', '21075', 'Howard', '410-313-5050', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Elkridge Elementary School', '7075 Montgomery Road', 'Elkridge', 'Maryland', '21075', 'Howard', '410-313-5006', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Forest Ridge Elementary School', '9550 Gorman Road', 'Laurel', 'Maryland', '20723', 'Howard', '410-880-5950', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Fulton Elementary School', '11600 Scaggsville Road', 'Fulton', 'Maryland', '20759', 'Howard', '410-880-5957', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Gorman Crossing Elementary School', '9999 Winter Sun Road', 'Laurel', 'Maryland', '20723', 'Howard', '410-880-5900', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Guilford Elementary School', '7335 Oakland Mills Road', 'Columbia', 'Maryland', '21046', 'Howard', '410-880-5930', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Hammond Elementary School', '8110 Aladdin Drive', 'Laurel', 'Maryland', '20723', 'Howard', '410-880-5890', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Hanover Hills Elementary School', '7030 Banbury Drive', 'Hanover', 'Maryland', '21076', 'Howard', '410-313-8066', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Hollifield Station Elementary School', '8701 Stonehouse Drive', 'Ellicott City', 'Maryland', '21043', 'Howard', '410-313-2550', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Ilchester Elementary School', '4981 Ilchester Road', 'Ellicott City', 'Maryland', '21043', 'Howard', '410-313-2524', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Jeffers Hill Elementary School', '6001 Tamar Drive', 'Columbia', 'Maryland', '21045', 'Howard', '410-313-6872', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Laurel Woods Elementary School', '9250 North Laurel Road', 'Laurel', 'Maryland', '20723', 'Howard', '410-880-5960', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Lisbon Elementary School', '15901 Frederick Road', 'Woodbine', 'Maryland', '21797', 'Howard', '410-313-5506', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Longfellow Elementary School', '5470 Hesperus Drive', 'Columbia', 'Maryland', '21044', 'Howard', '410-313-6879', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Manor Woods Elementary School', '11575 Frederick Road', 'Ellicott City', 'Maryland', '21042', 'Howard', '410-313-7165', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Northfield Elementary School', '9125 Northfield Road', 'Ellicott City', 'Maryland', '21042', 'Howard', '410-313-2806', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Phelps Luck Elementary School', '5370 Oldstone Court', 'Columbia', 'Maryland', '21045', 'Howard', '410-313-6886', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Pointers Run Elementary School', '6600 South Trotter Road', 'Clarksville', 'Maryland', '21029', 'Howard', '410-313-7142', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Rockburn Elementary School', '6145 Montgomery Road', 'Elkridge', 'Maryland', '21075', 'Howard', '410-313-5030', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Running Brook Elementary School', '5215 W. Running Brook Road', 'Columbia', 'Maryland', '21044', 'Howard', '410-313-6893', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('St. John''s Lane Elementary School', '2960 St. John’s Lane', 'Ellicott City', 'Maryland', '21042', 'Howard', '410-313-2813', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Stevens Forest Elementary School', '6045 Stevens Forest Road', 'Columbia', 'Maryland', '21045', 'Howard', '410-313-6900', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Swansfield Elementary School', '5610 Cedar Lane', 'Columbia', 'Maryland', '21044', 'Howard', '410-313-6907', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Talbott Springs Elementary School', '9550 Basket Ring Road', 'Columbia', 'Maryland', '21045', 'Howard', '410-313-6915', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Thunder Hill Elementary School', '9357 Mellenbrook Road', 'Columbia', 'Maryland', '21045', 'Howard', '410-313-6922', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Triadelphia Ridge Elementary School', '13400 Triadelphia Road', 'Ellicott City', 'Maryland', '21042', 'Howard', '410-313-2560', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Veterans Elementary School', '4355 Montgomery Road', 'Ellicott City', 'Maryland', '21043', 'Howard', '410-313-1700', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Waterloo Elementary School', '5940 Waterloo Road', 'Columbia', 'Maryland', '21045', 'Howard', '410-313-5014', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Waverly Elementary School', '10220 Wetherburn Road', 'Ellicott City', 'Maryland', '21042', 'Howard', '410-313-2819', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('West Friendship Elementary School', '12500 Frederick Road', 'West Friendship', 'Maryland', '21794', 'Howard', '410-313-5512', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Worthington Elementary School', '4570 Roundhill Road', 'Ellicott City', 'Maryland', '21043', 'Howard', '410-313-2825', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Bonnie Branch Middle School', '4979 Ilchester Road', 'Ellicott City', 'Maryland', '21043', 'Howard', '410-313-2580', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Burleigh Manor Middle School', '4200 Centennial Lane', 'Ellicott City', 'Maryland', '21042', 'Howard', '410-313-2507', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Clarksville Middle School', '6535 South Trotter Road', 'Clarksville', 'Maryland', '21029', 'Howard', '410-313-7057', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Dunloggin Middle School', '9129 Northfield Road', 'Ellicott City', 'Maryland', '21042', 'Howard', '410-313-2831', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Elkridge Landing Middle School', '7085 Montgomery Road', 'Elkridge', 'Maryland', '21075', 'Howard', '410-313-5040', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Ellicott Mills Middle School', '4445 Montgomery Road', 'Ellicott City', 'Maryland', '21043', 'Howard', '410-313-2839', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Folly Quarter Middle School', '13500 Triadelphia Road', 'Ellicott City', 'Maryland', '21042', 'Howard', '410-313-1506', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Glenwood Middle School', '2680 Route 97', 'Glenwood', 'Maryland', '21738', 'Howard', '410-313-5520', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Hammond Middle School', '8100 Aladdin Drive', 'Laurel', 'Maryland', '20723', 'Howard', '410-880-5830', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Harper''s Choice Middle School', '5450 Beaverkill Road', 'Columbia', 'Maryland', '21044', 'Howard', '410-313-6929', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Lake Elkhorn Middle School', '6680 Cradlerock Way', 'Columbia', 'Maryland', '21045', 'Howard', '410-313-7600', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Lime Kiln Middle School', '11650 Scaggsville Road', 'Fulton', 'Maryland', '20759', 'Howard', '410-880-5988', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Mayfield Woods Middle School', '7950 Red Barn Way', 'Elkridge', 'Maryland', '21075', 'Howard', '410-313-5022', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Mount View Middle School', '12101 Woodford Drive', 'Marriottsville', 'Maryland', '21104', 'Howard', '410-313-5545', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Murray Hill Middle School', '9989 Winter Sun Road', 'Laurel', 'Maryland', '20723', 'Howard', '410-880-5897', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Oakland Mills Middle School', '9540 Kilimanjaro Road', 'Columbia', 'Maryland', '21045', 'Howard', '410-313-6937', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Patapsco Middle School', '8885 Old Frederick Road', 'Ellicott City', 'Maryland', '21043', 'Howard', '410-313-2848', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Patuxent Valley Middle School', '9151 Vollmerhausen Road', 'Savage', 'Maryland', '20763', 'Howard', '410-880-5840', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Thomas Viaduct Middle School', '7000 Banbury Drive', 'Hanover', 'Maryland', '21076', 'Howard', '410-313-8711', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Wilde Lake Middle School', '10481 Cross Fox Lane', 'Columbia', 'Maryland', '21044', 'Howard', '410-313-6957', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Atholton High School', '6520 Freetown Road', 'Columbia', 'Maryland', '21044', 'Howard', '410-313-7065', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Centennial High School', '4300 Centennial Lane', 'Ellicott City', 'Maryland', '21042', 'Howard', '410-313-2856', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Glenelg High School', '14025 Burntwoods Road', 'Glenelg', 'Maryland', '21737', 'Howard', '410-313-5528', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Guilford Park High School', '8500 Ridgelys Run Road', 'Jessup', 'Maryland', '20794', 'Howard', '410-313-7430', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Hammond High School', '8800 Guilford Road', 'Columbia', 'Maryland', '21046', 'Howard', '410-313-7615', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Howard High School', '8700 Old Annapolis Road', 'Ellicott City', 'Maryland', '21043', 'Howard', '410-313-2867', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Long Reach High School', '6101 Old Dobbin Lane', 'Columbia', 'Maryland', '21045', 'Howard', '410-313-7117', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Marriotts Ridge High School', '12100 Woodford Drive', 'Marriottsville', 'Maryland', '21104', 'Howard', '410-313-5568', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Mt. Hebron High School', '9440 Old Frederick Road (Route 99)', 'Ellicott City', 'Maryland', '21042', 'Howard', '410-313-2880', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Oakland Mills High School', '9410 Kilimanjaro Road', 'Columbia', 'Maryland', '21045', 'Howard', '410-313-6945', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Reservoir High School', '11550 Scaggsville Road', 'Fulton', 'Maryland', '20759', 'Howard', '410-888-8850', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('River Hill High School', '12101 Clarksville Pike', 'Clarksville', 'Maryland', '21029', 'Howard', '410-313-7120', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Wilde Lake High School', '5460 Trumpeter Road', 'Columbia', 'Maryland', '21044', 'Howard', '410-313-6965', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('High Road Acedemy of Howard County', '11840 W. Market Place', 'Fulton', 'Maryland', '20759', 'Howard', '301-483-8605', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Linewood School', '3421 Martha Bush Drive', 'Ellicott City', 'Maryland', '21043', 'Howard', '410-465-1352', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Phillips School-Laurel', '8920 Whiskey Bottom Road', 'Laurel', 'Maryland', '20723', 'Howard', '301-470-1620', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

--Kent

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Galena Elementary School', '114 S. Main St.', 'Galena', 'Maryland', '21635', 'Kent', '410-810-2510', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Henry Highland Garnet Elementary School', '320 Calvert St.', 'Chestertown', 'Maryland', '21620', 'Kent', '410-778-6890', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Rock Hall Elementary School', '21203 W. Sharp St.', 'Rock Hall', 'Maryland', '21661', 'Kent', '410-810-2622', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Kent County Middle School', '402 East Campus Ave.', 'Chestertown', 'Maryland', '21620', 'Kent', '410-778-1771', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Kent County High School', '25301 Lambs Meadown Road', 'Worton', 'Maryland', '21678', 'Kent', '410-778-4540', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

--Montgomery

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Arcola Elementary School', '1820 Franwall Ave', 'Silver Spring', 'Maryland', '20906', 'Montgomery', '301-287-8585', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Ashburton Elementary School', '6314 Lone Oak Dr', 'Bethesda', 'Maryland', '20817', 'Montgomery', '240-740-1300', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Bannockburn Elementary School', '6520 Dalroy Lane', 'Bethesda', 'Maryland', '20817', 'Montgomery', '240-740-1270', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Bayard Rustin Elementary School', '332 West Edmonston Dr', 'Rockville', 'Maryland', '20850', 'Montgomery', '240-740-4320', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Beall Elementary School', '451 Beall Ave', 'Rockville', 'Maryland', '20850', 'Montgomery', '240-740-1220', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Bel Pre Elementary School', '13801 Rippling Brook Dr', 'Silver Spring', 'Maryland', '20906', 'Montgomery', '301-287-8870', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Bells Mill Elementary School', '8225 Bells Mill Rd', 'Potomac', 'Maryland', '20854', 'Montgomery', '240-740-0480', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Belmont Elementary School', '19528 Olney Mill Rd', 'Olney', 'Maryland', '20832', 'Montgomery', '240-740-5705', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Bethesda Elementary School', '7600 Arlington Rd', 'Bethesda', 'Maryland', '20817', 'Montgomery', '240-204-5300', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Beverly Farms Elementary School', '8501 Postoak Rd', 'Potomac', 'Maryland', '20854', 'Montgomery', '240-740-0200', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Bradley Hills Elementary School', '8701 Hartsdale Ave', 'Bethesda', 'Maryland', '20817', 'Montgomery', '240-204-5210', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Brooke Grove Elementary School', '2700 Sparton RD', 'Olney', 'Maryland', '20832', 'Montgomery', '240-722-1800', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Brookhaven Elementary School', '4610 Renn St', 'Rockville', 'Maryland', '20850', 'Montgomery', '240-740-0500', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Brown Station Elementary School', '851 Quince Orchard Blvd', 'Gaithersburg', 'Maryland', '20877', 'Montgomery', '240-740-0260', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Burning Tree Elementary School', '7900 Beexh Tree rd', 'Bethesda', 'Maryland', '20817', 'Montgomery', '240-740-0260', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Burnt Mills Elementary School', '415 Prelude Dr', 'Silver Spring', 'Maryland', '20906', 'Montgomery', '240-740-7320', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Burtonsville Elementary School', '15516 Old Columbia Pike', 'Burtonsville', 'Maryland', '20866', 'Montgomery', '240-740-5700', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Cabin Branch Elementary School', '14129 Dunlin St', 'Clarksburg', 'Maryland', '20871', 'Montgomery', '240-740-7670', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Candlewood Elementary School', '7210 Osprey Dr', 'Rockville', 'Maryland', '20850', 'Montgomery', '301-284-4200', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Cannon Road Elementary School', '901 Cannon Rd', 'Silver Spring', 'Maryland', '20906', 'Montgomery', '240-740-0520', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Captain James E. Daly Elementary School', '20301 Brandermill Dr', 'Germantown', 'Maryland', '20874', 'Montgomery', '240-740-0600', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Carderock Springs Elementary School', '7401 Persimmon Tree Lane', 'Bethesda', 'Maryland', '20817', 'Montgomery', '240-740-0540', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Cashell Elementary School', '17101 Cashell Rd', 'Rockville', 'Maryland', '20850', 'Montgomery', '240-740-0560', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Cedar Grove Elementary School', '24001 Ridge rd', 'Germantown', 'Maryland', '20874', 'Montgomery', '240-740-6190', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Chevy Chase Elementary School', '4015 Rosemary St', 'Chevy Chase', 'Maryland', '20815', 'Montgomery', '301-657-4994', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Clarksburg Elementary School', '13530 Redgrave Pl', 'Clarksburg', 'Maryland', '20871', 'Montgomery', '240-740-3530', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Clearspring Elementary School', '9930 MOyer Rd', 'Damascus', 'Maryland', '20872', 'Montgomery', '240-740-2180', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Clopper Mill Elementary School', '18501 Cinnamon Dr', 'Germantown', 'Maryland', '20874', 'Montgomery', '240-740-2180', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Cloverly Elementary School', '800 Briggs Chaney Rd', 'Silver Spring', 'Maryland', '20906', 'Montgomery', '240-740-4660', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Cold Spring Elementary School', '9201 Falls Chapel Way', 'Potomac', 'Maryland', '20854', 'Montgomery', '240-740-4390', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('College Gardens Elementary School', '1700 Yale Pl', 'Rockville', 'Maryland', '20850', 'Montgomery', '301-279-8470', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Cresthaven Elementary School', '1234 Cresthaven Dr', 'Silver Spring', 'Maryland', '20906', 'Montgomery', '240-740-0580', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Damascus Elementary School', '10201 Bethesda Chruch rd', 'Damascus', 'Maryland', '20872', 'Montgomery', '240-740-6180', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Darnestown Elementary School', '15030 Turkey Foor Dr', 'Gaithersburg', 'Maryland', '20877', 'Montgomery', '301-284-4260', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Diamond Elementary School', '4 Marquis Dr', 'Gaithersburg', 'Maryland', '20877', 'Montgomery', '240-740-2120', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Dr. Charles R. Drew Elementary School', '1200 Swingingdale Dr', 'Silver Spring', 'Maryland', '20906', 'Montgomery', '240-740-5670', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Dr. Ronald E. McNair Elementary School', '13881 Hopkins Rd', 'Germantown', 'Maryland', '20874', 'Montgomery', '240-740-6830', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Dr. Sally K. Ride Elementary School', '21301 Seneca Crossing Dr', 'Germantown', 'Maryland', '20874', 'Montgomery', '240-740-5980', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('DuFief Elementary School', '15001 DuFief Dr', 'Gaithersburg', 'Maryland', '20877', 'Montgomery', '240-740-1600', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('East Silver Spring Elementary School', '631 Silver Spring Ave', 'Silver Spring', 'Maryland', '20906', 'Montgomery', '240-740-0620', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Fairland Elementary School', '14315 Fairdale rd', 'Silver Spring', 'Maryland', '20906', 'Montgomery', '240-740-0640', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Fallsmead Elementary School', '1800 Greenpalce Terr', 'Rockville', 'Maryland', '20850', 'Montgomery', '240-740-3545', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Farmland Elementary School', '7000 Old Gate rd', 'Rockville', 'Maryland', '20850', 'Montgomery', '240-740-0660', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Fields Road Elementary School', '1 School Dr', 'Gaithersburg', 'Maryland', '20877', 'Montgomery', '240-740-7000', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Flora M. Singer Elementary School', '2600 Hayden Dr', 'Silver Spring', 'Maryland', '20906', 'Montgomery', '240-740-5820', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Flower Hill Elementary School', '18425 Flower Hill Way', 'Gaithersburg', 'Maryland', '20877', 'Montgomery', '240-740-5820', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Flower Valley Elementary School', '4615 Sunflower Dr', 'Rockville', 'Maryland', '20850', 'Montgomery', '240-740-1780', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Forest Knolls Elementary School', '10830 Eastwood Ave', 'Silver Spring', 'Maryland', '20906', 'Montgomery', '240-740-0680', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Fox Chapel Elementary School', '19315 Archdale Rd', 'Germantown', 'Maryland', '20874', 'Montgomery', '240-740-0680', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Gaithersburg Elementary School', '35 North Summit Ave', 'Gaithersburg', 'Maryland', '20877', 'Montgomery', '240-740-4900', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Galway Elementary School', '12612 Galway Dr', 'Silver Spring', 'Maryland', '20906', 'Montgomery', '240-740-0140', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Garrett Park Elementary School', '4810 Ocford St', 'Kensington', 'Maryland', '20895', 'Montgomery', '240-740-0700', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Georgian Forest Elementary School', '3100 Regina Dr', 'Silver Spring', 'Maryland', '20906', 'Montgomery', '240-740-0720', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Germantown Elementary School', '19110 Liberty Mill Rd', 'Germantown', 'Maryland', '20874', 'Montgomery', '240-740-6490', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Glen Haven Elementary School', '10900 Inwood Ave', 'Silver Spring', 'Maryland', '20906', 'Montgomery', '240-740-7960', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Glenallan Elementary School', '12520 Heurich Rd', 'Silver Spring', 'Maryland', '20906', 'Montgomery', '240-740-0760', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Goshen Elementary School', '8701 Warfield Rd', 'Gaithersburg', 'Maryland', '20877', 'Montgomery', '240-740-6170', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Great Seneca Creek Elementary School', '13010 Dairmaid Dr', 'Germantown', 'Maryland', '20874', 'Montgomery', '240-740-4380', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Greencastle Elementary School', '13611 Robey Rd', 'Silver Spring', 'Maryland', '20906', 'Montgomery', '240-740-1420', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Greenwood Elementary School', '3336 Gold Mine Rd', 'Brookeville', 'Maryland', '20833', 'Montgomery', '240-740-3420', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Harmony Hills Elementary School', '13407 Lydia St', 'Silve Spring', 'Maryland', '20906', 'Montgomery', '240-740-0780', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Harriet R. Tubman Elementary School', '400 Victory Farm Dr', 'Gaithersburg', 'Maryland', '20877', 'Montgomery', '240-740-6770', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Highland Elementary School', '3100 Medway St', 'Silver Spring', 'Maryland', '20906', 'Montgomery', '240-740-1770', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Highland View Elementary School', '9010 Providence Ave', 'Silver Spring', 'Maryland', '20906', 'Montgomery', '240-740-1990', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Jackson Road Elementary School', '900 Jackson RD', 'Silver Spring', 'Maryland', '20906', 'Montgomery', '240-740-0800', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('JoAnn Leleck at Broad Acres', '710 Beacon Rd', 'Silver Spring', 'Maryland', '20906', 'Montgomery', '240-740-1900', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Jones Lane Elementary School', '15110 Jones Lane', 'Gaithersburg', 'Maryland', '20877', 'Montgomery', '240-740-4260', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Judith A. Resnik Elementary School', '7301 Hadley Farms Dr', 'Gaithersburg', 'Maryland', '20877', 'Montgomery', '240-740-3240', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Kemp Mill Elementary School', '411 Sisson St', 'Silver Spring', 'Maryland', '20906', 'Montgomery', '240-740-5970', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Kensington Parkwood Elementary School', '4710 Saul Rd', 'Kensington', 'Maryland', '20895', 'Montgomery', '240-740-3700', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Lake Seneca Elementary School', '13600 Wanegarden Dr', 'Germantown', 'Maryland', '20874', 'Montgomery', '240-740-0280', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Lakewood Elementary School', '2534 Lindley Terr', 'Rockville', 'Maryland', '20850', 'Montgomery', '240-740-5750', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Laytonsville Elementary School', '21401 Laytonsville Rd', 'Gaithersburg', 'Maryland', '20877', 'Montgomery', '240-740-1660', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Little Bennett Elementary School', '23930 Burdette Forest Rd', 'Clarksburg', 'Maryland', '20871', 'Montgomery', '240-740-5660', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Lois P. Rockwell Elementary School', '24555 Cutsail Dr', 'Damascus', 'Maryland', '20872', 'Montgomery', '240-740-5180', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Lucy V. Barnsley Elementary School', '14516 Nadine Dr', 'Rockville', 'Maryland', '20850', 'Montgomery', '240-740-3260', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Luxmanor Elementary School', '6201 Tilden Lane', 'Rockville', 'Maryland', '20850', 'Montgomery', '240-740-0820', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Maryvale Elementary School', '1010 First Ave', 'Rockville', 'Maryland', '20850', 'Montgomery', '240-740-4330', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Meadow Hall Elementary School', '951 Twinbrook Pkwy', 'Rockville', 'Maryland', '20850', 'Montgomery', '240-740-5260', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Mill Creek Towne Elementary School', '17700 Park Mill Dr', 'Rockville', 'Maryland', '20850', 'Montgomery', '240-740-1820', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Monocacy Elementary School', '18801 Barnesville Rd', 'Dickerson', 'Maryland', '20842', 'Montgomery', '240-740-5790', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Montgomery Knolls Elementary School', '807 Daleview Dr', 'Silver Spring', 'Maryland', '20906', 'Montgomery', '240-740-0840', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('New Hampshire Estates Elementary School', '8720 Carroll Ave', 'Silver Spring', 'Maryland', '20906', 'Montgomery', '240-740-1580', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('North Chevy Chase Elementary School', '3700 Jones Bridge Rd', 'Chevy Chase', 'Maryland', '20815', 'Montgomery', '240-740-5280', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Oak View Elementary School', '400 East Wayne Ave', 'Silver Spring', 'Maryland', '20906', 'Montgomery', '240-740-6540', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Oakland Terrace Elementary School', '2720 Plyers Mill Rd', 'Silver Spring', 'Maryland', '20906', 'Montgomery', '240-740-4880', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Olney Elementary School', '3401 Queen Mary Dr', 'Olney', 'Maryland', '20832', 'Montgomery', '240-740-5940', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Pine Crest Elementary School', '201 Woodmoor Dr', 'Silver Spring', 'Maryland', '20906', 'Montgomery', '240-740-1970', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Piney Branch Elementary School', '7510 Maple Ave', 'Takoma Park', 'Maryland', '20912', 'Montgomery', '240-740-7780', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Poolesville Elementary School', '19565 Fisher Ave', 'Poolesville', 'Maryland', '20837', 'Montgomery', '240-740-5870', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Potomac Elementary School', '10311 River Rd', 'Potomac', 'Maryland', '20854', 'Montgomery', '240-740-4360', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Rachel Carson Elementary School', '100 Tschiffely Square Rd', 'Gaithersburg', 'Maryland', '20877', 'Montgomery', '240-740-1840', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Ritchie Park Elementary School', '1514 Dunster Rd', 'Rockville', 'Maryland', '20850', 'Montgomery', '240-740-6310', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Rock Creek Forest Elementary School', '8330 Grubb Rd', 'Chevy Chase', 'Maryland', '20815', 'Montgomery', '240-740-3201', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Rock Creek Valley Elementary School', '5121 Russett Rd', 'Rockville', 'Maryland', '20850', 'Montgomery', '240-740-1240', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Rock View Elementary School', '3901 Denfeld Ave', 'Kensington', 'Maryland', '20895', 'Montgomery', '240-740-0920', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Rolling Terrace Elementary School', '705 Bayfield St', 'Takoma Park', 'Maryland', '20912', 'Montgomery', '240-740-1950', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Roscoe R. Nix Elementary School', '1100 Corliss St', 'Silver Spring', 'Maryland', '20906', 'Montgomery', '240-740-6550', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Rosemary Hills Elementary School', '2111 Porter Rd', 'Silver Spring', 'Maryland', '20906', 'Montgomery', '301-920-9990', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Rosemont Elementary School', '16400 Alden Ave', 'Gaithersburg', 'Maryland', '20877', 'Montgomery', '240-740-7180', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('S. Christa McAuliffe Elementary School', '12500 Wisteria Dr', 'Germantown', 'Maryland', '20874', 'Montgomery', '240-740-4920', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Sargent Shriver Elementary School', '12518 Greenly Dr', 'Silver Spring', 'Maryland', '20906', 'Montgomery', '240-740-6330', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Sequoyah Elementary School', '17301 Bowie Mill Rd', 'Derwood', 'Maryland', '20855', 'Montgomery', '240-740-5880', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Seven Locks Elementary School', '9500 Seven Locks Rd', 'Bethesda', 'Maryland', '20817', 'Montgomery', '240-740-0940', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Sherwood Elementary School', '1401 Olney-Sandy Spring Rd', 'Sandy Springs', 'Maryland', '20860', 'Montgomery', '240-740-0960', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Sligo Creek Elementary School', '500 Schuyler Rd', 'Silver Spring', 'Maryland', '20906', 'Montgomery', '240-740-2800', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Snowden Farm Elementary School', '22500 Sweetspire Dr', 'Clarksburg', 'Maryland', '20871', 'Montgomery', '240-740-5800', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Somerset Elementary School', '5811 Warwick Pl', 'Chevy Chase', 'Maryland', '20815', 'Montgomery', '240-740-1100', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('South Lake Elementary School', '18201 Contour Rd', 'Gaithersburg', 'Maryland', '20877', 'Montgomery', '240-740-7330', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Spark M. Matsunaga Elementary School', '13902 Bromfield Rd', 'Germantown', 'Maryland', '20874', 'Montgomery', '240-740-7820', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Stedwick Elementary School', '106310 Stedwick Rd', 'Montgomery Village', 'Maryland', '20886', 'Montgomery', '240-740-7190', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Stone Mill Elementary School', '14323 Stonebridge View Dr', 'North Potomac', 'Maryland', '20878', 'Montgomery', '240-740-5450', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Stonegate Elementary School', '14811 Notley Rd', 'Silver Spring', 'Maryland', '20906', 'Montgomery', '240-740-7340', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Strathmore Elementary School', '3200 Beaverwood Lane', 'Silver Spring', 'Maryland', '20906', 'Montgomery', '240-740-5760', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Strawberry Knoll Elementary School', '18820 Strawberry Knoll Rd', 'Gaithersburg', 'Maryland', '20877', 'Montgomery', '240-740-5140', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Summit Hall Elementary School', '101 West Deer Park Rd', 'Gaithersburg', 'Maryland', '20877', 'Montgomery', '301-284-4150', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Takoma Park Elementary School', '7511 Holly Ave', 'Takoma Park', 'Maryland', '20912', 'Montgomery', '240-740-0980', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Thurgood Marshall Elementary School', '12260 McDonald Chapel Dr', 'Gaithersburg', 'Maryland', '20877', 'Montgomery', '240-740-5990', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Travilah Elementary School', '13801 DuFief Mill Rd', 'North Potomac', 'Maryland', '20878', 'Montgomery', '240-740-4300', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Twinbrook Elementary School', '5911 Ridgeway Ave', 'Rockville', 'Maryland', '20850', 'Montgomery', '240-740-3450', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Viers Mill Elementary School', '11711 Joseph Mill Rd', 'Silver Spring', 'Maryland', '20906', 'Montgomery', '240-740-1000', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Washington Grove Elementary School', '8712 Oakmont St', 'Gaithersburg', 'Maryland', '20877', 'Montgomery', '240-740-0300', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Waters Landing Elementary School', '13100 Waters Landing Dr', 'Germantown', 'Maryland', '20874', 'Montgomery', '240-740-1020', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Watkins Mill Elementary School', '19001 Watkins Landing Dr', 'Montgomery Village', 'Maryland', '20886', 'Montgomery', '240-740-5280', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Wayside Elementary School', '10011 Glen Rd', 'Potomac', 'Maryland', '20854', 'Montgomery', '240-740-0240', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Weller Road Elementary School', '3301 Weller Rd', 'Silver Spring', 'Maryland', '20906', 'Montgomery', '301-287-8601', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Westbrook Elementary School', '5110 Allan Terr', 'Bethesda', 'Maryland', '20817', 'Montgomery', '240-740-1040', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Westover Elementary School', '401 Hawkesbury Lane', 'Silver Spring', 'Maryland', '20906', 'Montgomery', '240-740-5740', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Wheaton Woods Elementary School', '4510 Faroe Pl', 'Rockville', 'Maryland', '20850', 'Montgomery', '240-740-0220', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Whetstone Elementary School', '19201 Thomas Farm Rd', 'Gaithersburg', 'Maryland', '20877', 'Montgomery', '240-740-1060', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('William B. Gibbs Jr. Elementary School', '12615 Royal Crown Dr', 'Germantown', 'Maryland', '20874', 'Montgomery', '240-740-0740', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('William Tyler Page Elementary School', '13400 Tamarack Rd', 'Silver Spring', 'Maryland', '20906', 'Montgomery', '240-740-7560', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Wilson Wims Elementary School', '1250 Blue Sky Dr', 'Clarksburg', 'Maryland', '20871', 'Montgomery', '240-740-1670', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Wood Acres Elementary School', '5800 Cromwell Dr', 'Bethesda', 'Maryland', '20817', 'Montgomery', '240-740-1120', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Woodfield Elementary School', '24200 Woodfield Rd', 'Gaithersburg', 'Maryland', '20877', 'Montgomery', '240-207-2550', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Woodlin Elementary School', '2101 Luzerne Ave', 'Silver Spring', 'Maryland', '20906', 'Montgomery', '240-740-7350', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Wyngate Elementary School', '9300 Wadsworth Dr', 'Bethesda', 'Maryland', '20817', 'Montgomery', '240-740-1080', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Argyle Middle School', '2400 Bel Pre Rd', 'Silver Spring', 'Maryland', '20906', 'Montgomery', '240-740-6370', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('A. Mario Loiederman Middle School', '12701 Goodhill Rd', 'SIlver Spring', 'Maryland', '20906', 'Montgomery', '240-740-5830', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Benjamin Banneker Middle School', '14800 Perrywood Dr', 'Burtonsville', 'Maryland', '20866', 'Montgomery', '240-740-6250', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Briggs Chaney Middle School', '1901 Rainbow Dr', 'Silver Springs', 'Maryland', '20905', 'Montgomery', '301-288-8300', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Cabin John Middle School', '10701 Gainsborough RD', 'Potomac', 'Maryland', '20854', 'Montgomery', '240-406-1600', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Dr. Martin Luther King Jr. Middle School', '13737 Wisteria Dr', 'Germantown', 'Maryland', '20874', 'Montgomery', '240-740-6350', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Earle B. Wood Middle School', '14615 Bauer Dr', 'Rockville', 'Maryland', '20850', 'Montgomery', '240-740-7640', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Eastern Middle School', '300 University Blvd', 'East Silver Spring', 'Maryland', '20901', 'Montgomery', '240-740-6280', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Forest Oak Middle School', '651 Saybrooke Oaks Blvd', 'Gaithersburg', 'Maryland', '20877', 'Montgomery', '240-740-7570', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Francis Scott Key Middle School', '910 Schindler Dr', 'Silver Spring', 'Maryland', '20906', 'Montgomery', '301-422-5700', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Gaithersburg Middle School', '2 Teachers Way', 'Gaithersburg', 'Maryland', '20877', 'Montgomery', '240-740-4950', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Hallie Wells Middle School', '11701 Little Seneca Pkwy', 'Clarksburg', 'Maryland', '20871', 'Montgomery', '301-284-4800', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Herbert Hoover Middle School', '8810 Postoak Rd', 'Potomac', 'Maryland', '20854', 'Montgomery', '301-968-3740', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('John Poole Middle School', '17014 Tom Fox Ave', 'Poolesville', 'Maryland', '20837', 'Montgomery', '240-740-4200', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('John T. Baker Middle School', '25400 Oak Dr', 'Damascus', 'Maryland', '20872', 'Montgomery', '240-207-2440', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Julius West Middle School', '651 Great Falls R', 'Rockville', 'Maryland', '20850', 'Montgomery', '301-337-3400', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Kingsview Middle School', '18909 Kingsview Rd', 'Germantown', 'Maryland', '20874', 'Montgomery', '240-740-7130', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Lakelands Park Middle School', '1200 Main St', 'Gaithersbburg', 'Maryland', '20878', 'Montgomery', '240-740-6450', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Montgomery Village Middle School', '19300 Watkins Mill RD', 'Montgomery Village', 'Maryland', '20886', 'Montgomery', '240-740-6720', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Neelsville Middle School', '11700 Neelsville Church Rd', 'Germantown', 'Maryland', '20874', 'Montgomery', '240-740-6630', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Newport Mill Middle School', '11311 Newport Mill Rd', 'Kensington', 'Maryland', '20895', 'Montgomery', '240-740-7160', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('North Bethesda Middle School', '8935 Bradmoor Dr', 'Bethesda', 'Maryland', '20817', 'Montgomery', '240-740-2100', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Odessa Shannon Middle School', '11800 Monticello Ave', 'Silver Spring', 'Maryland', '20906', 'Montgomery', '240-740-4150', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Parkland Middle School', '4610 West Franfort Dr', 'Rockville', 'Maryland', '20850', 'Montgomery', '240-740-6800', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Redland Middle School', '6505 Muncaster Mill RD', 'Rockville', 'Maryland', '20850', 'Montgomery', '240-740-0900', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Ridgeview Middle School', '16600 Raven Rock Dr', 'Gaithersburg', 'Maryland', '20877', 'Montgomery', '240-740-3330', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Robert Frost Middle School', '9201 Scott Dr', 'Rockville', 'Maryland', '20850', 'Montgomery', '340-740-7610', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Roberto W Clemente Middle School', '18808 Waring Station RD', 'Germantown', 'Maryland', '20874', 'Montgomery', '301-284-4750', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Rocky Hill Middle School', '22401 Brick Haven Way', 'Clarksburg', 'Maryland', '20871', 'Montgomery', '240-740-6670', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Rosa Parks Middle School', '19200 Olney Mill Rd', 'Olney', 'Maryland', '20832', 'Montgomery', '240-740-3300', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Shady Grove Middle School', '8100 Midcounty Hwy', 'Gaithersburg', 'Maryland', '20877', 'Montgomery', '240-740-1440', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Silver Creek Middle School', '3701 Saul RD', 'Kensington', 'Maryland', '20895', 'Montgomery', '240-740-2200', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Silver Spring International Middle School', '313 Wayne Ave', 'Silver Spring', 'Maryland', '20906', 'Montgomery', '240-740-2750', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Sligo Middle School', '1401 Dennis Ave', 'Silver Spring', 'Maryland', '20906', 'Montgomery', '301-287-8890', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Takoma Park Middle School', '7611 Piney Branch Rd', 'Silver Spring', 'Maryland', '20906', 'Montgomery', '240-740-5220', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Thomas W. Pyle Middle School', '6311 Wilson Lane', 'Bethesda', 'Maryland', '20817', 'Montgomery', '240-740-3500', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Tilden Middle School', '6300 Tilden Lane', 'Rockville', 'Maryland', '20850', 'Montgomery', '240-740-6700', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Westland Middle School', '5511 Massachusetts Ave', 'Bethesda', 'Maryland', '20817', 'Montgomery', '240-740-5850', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('White Oak Middle School', '12201 New Hampshire Ave', 'Silver Spring', 'Maryland', '20906', 'Montgomery', '301-288-8200', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('William H. Farquhar Middle School', '17017 Batchellors Forest Rd', 'Olney', 'Maryland', '20832', 'Montgomery', '240-740-1200', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Albert Einstein High School', '11135 Newport Mill Blvd', 'Kensington', 'Maryland', '20895', 'Montgomery', '240-740-2700', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Bethesda-Chevy Chase High School', '4301 East-West Hwy', 'Bethesda', 'Maryland', '20817', 'Montgomery', '240-740-0400', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Clarksburg High School', '22500 Wims RD', 'Clarksburg', 'Maryland', '20871', 'Montgomery', '240-740-6000', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Col. Zadok Magruder High School', '5939 Muncaster Mill Rd', 'Rockville', 'Maryland', '20850', 'Montgomery', '240-740-5550', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Damascus High School', '25921 Ridge Rd', 'Damascus', 'Maryland', '20872', 'Montgomery', '240-207-2400', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Gaithersburg High School', '101 Education Blvd', 'Gaithersburg', 'Maryland', '20877', 'Montgomery', '240-284-4500', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('James Hubert Blake High School', '300 Norwood Rd', 'Silver Spring', 'Maryland', '20906', 'Montgomery', '240-740-1400', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('John F. Kennedy High School', '1901 Randolph Rd', 'Silver Spring', 'Maryland', '20906', 'Montgomery', '240-740-0100', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Montgomery Blair High School', '51 University Blvd', 'Silver Spring', 'Maryland', '20906', 'Montgomery', '240-740-7200', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Northwest High School', '13501 Richter Farm Rd', 'Germantown', 'Maryland', '20874', 'Montgomery', '240-740-7100', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Paint Branch High School', '14121 Old Columbia Pike', 'Burtonsville', 'Maryland', '20866', 'Montgomery', '301-888-9900', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Poolesville High School', '17501 West Willard RD', 'Poolesville', 'Maryland', '20837', 'Montgomery', '240-740-2400', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Quince Orchard High School', '15800 Quince Orchard RD', 'Gaithersburg', 'Maryland', '20877', 'Montgomery', '240-740-3600', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Richard Montgomery High School', '250 Richard Montgomery Dr', 'Rockville', 'Maryland', '20850', 'Montgomery', '240-740-6100', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Rockville High School', '2100 Baltimore RD', 'Rockville', 'Maryland', '20850', 'Montgomery', '240-740-6600', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Seneca Valley High School', '19401 Crystal Rock Dr', 'Germantown', 'Maryland', '20874', 'Montgomery', '240-740-6400', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Sherwood High School', '300 Olney-Sandy RD', 'Sandy Spring', 'Maryland', '20860', 'Montgomery', '240-740-8110', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Springbrook High School', '201 Valleybrook Dr', 'Silver Spring', 'Maryland', '20906', 'Montgomery', '240-740-3800', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Thomas S. Wootton High School', '2100 Wootton Pkwy', 'Rockville', 'Maryland', '20850', 'Montgomery', '240-740-1500', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Walt Whitman High School', '7100 Whittier Blvd', 'Bethesda', 'Maryland', '20817', 'Montgomery', '240-740-4800', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Walter Johnson High School', '6400 Rock Spring Dr', 'Bethesda', 'Maryland', '20817', 'Montgomery', '240-740-6900', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Watkins Mill High School', '10301 Apple Ridge Rd', 'Gaithersburg', 'Maryland', '20877', 'Montgomery', '240-284-4400', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Wheaton High School', '12401 Dalewood Dr', 'Silver Spring', 'Maryland', '20906', 'Montgomery', '301-321-3400', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Winston Churchill High School', '1130Gainsborough Rd', 'Potomac', 'Maryland', '20854', 'Montgomery', '240-740-5400', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Community School of Maryland', '21515 Zion Road', 'Brookeville', 'Maryland', '20833', 'Montgomery', '240-912-3606', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;



INSERT INTO cjams.schoollistreference
("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES
('The Foundation School of Montgomery County', '220 Girard St #300', 'Gaithersburg', 'Maryland', '20877', 'Montgomery', '301-740-7807', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('The Ivymount School', '11614 & 11616 Seven Locks Road', 'Rockville', 'Maryland', '20850', 'Montgomery', '301-469-0223', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('The Kaherine Thomas School', '9975 Medical Center Drive', 'Rockville', 'Maryland', '20850', 'Montgomery', '301-738-9691', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Lourie Cener School', '12301 Academy Way', 'Rockville', 'Maryland', '20850', 'Montgomery', '301-984-4444', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Marcia D. Smith School', '9075 Comprint Court', 'Gaithersburg', 'Maryland', '20877', 'Montgomery', '301-926-2300', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('The Ridge School of Montgomery County', '14915 Broschart Road, Suite 2300', 'Rockville', 'Maryland', '20850', 'Montgomery', '301-251-4624', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Sheppard Pratt( Gaithersburg)', '610 East Diamond Ave Suite E', 'Gaithersburg', 'Maryland', '20877', 'Montgomery', '301-330-4359', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Sheppard Pratt School( Rockville)', '4915 Aspen Road', 'Rockville', 'Maryland', '20850', 'Montgomery', '301-933-3451', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Northwood High School', '11211 Old Georgetown RD', 'Rockville', 'Maryland', '20852', 'Montgomery', '240-740-6950', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;


--Prince Georges

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Academy of Health Sciences at Prince George''s Community College', '301 Largo Road Lanham Hall-3rd Floor', 'Largo', 'Maryland', '20774', 'Prince Georges', '301-546-7370', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Accokeek Academy', '14400 Berry Road', 'Accokeek', 'Maryland', '20607', 'Prince Georges', '301-203-3200', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Adelphi Elementary', '9000 25th Avenue', 'Adelphi', 'Maryland', '20783', 'Prince Georges', '301-431-6250', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Allenwood Elementary', '6300 Harley Lane', 'Temple Hills', 'Maryland', '20748', 'Prince Georges', '301-702-3930', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Andrew Jackson Academy', '3500 Regency Parkway', 'Forestville', 'Maryland', '20747', 'Prince Georges', '301-817-0310', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Apple Grove Elementary', '7400 Bellefield Avenue', 'Fort Washington', 'Maryland', '20744', 'Prince Georges', '301-449-4966', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Ardmore Elementary', '9301 Ardwick-Ardmore Road', 'Springdale', 'Maryland', '20774', 'Prince Georges', '301-925-1311', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Arrowhead Elementary', '2300 Sansbury Road', 'Upper Malboro', 'Maryland', '20774', 'Prince Georges', '301-499-7071', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Avalon Elementary', '7302 Webster Lane', 'Fort Washington', 'Maryland', '20744', 'Prince Georges', '301-449-4970', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Baden Elementary', '13601 Baden-Westwood Road', 'Brandywine', 'Maryland', '20613', 'Prince Georges', '301-888-1188', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Barack Obama Elementary', '12700 Brooke Lane', 'Upper Malboro', 'Maryland', '20772', 'Prince Georges', '301-574-4020', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Barnaby Manor Elementary', '2411 Owens Road', 'Olxon Hill', 'Maryland', '20745', 'Prince Georges', '301-702-7560', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Beacon Heights Elementary', '6929 Furman Parkway', 'Riverdale', 'Maryland', '20737', 'Prince Georges', '301-918-8700', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Beltsville Academy', '4300 Wicomico Avenue', 'Beltsville', 'Maryland', '20705', 'Prince Georges', '301-572-0630', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Benjamin Foulois Creative and Performing Arts K-8', '4601 Beauford Road', 'Suitland', 'Maryland', '20746', 'Prince Georges', '301-817-0300', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Benjamin Stoddert Middle', '2501 Olson Street', 'Temple Hills', 'Maryland', '20748', 'Prince Georges', '301-702-7500', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Benjamin Tasker Middle', '4901 Collington Road', 'Bowie', 'Maryland', '20715', 'Prince Georges', '301-805-2660', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Berwyn Heights Elementary', '6200 Pontiac Street', 'Berwyn Heights', 'Maryland', '20740', 'Prince Georges', '240-684-6210', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Bladensburg Elementary', '4915 Annapolis Road', 'Blandensburg', 'Maryland', '20710', 'Prince Georges', '301-985-1450', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Bladensburg High', '4200 57th Avenue', 'Blandensburg', 'Maryland', '20710', 'Prince Georges', '301-887-6700', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Bond Mill Elementary', '16001 Sherwood Avenue', 'Laurel', 'Maryland', '20707', 'Prince Georges', '301-497-3600', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Bowie High', '15200 Annapolis Road', 'Bowie', 'Maryland', '20715', 'Prince Georges', '301-805-2600', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Bradbury Heights Elementary', '1401 Glacier Avenue', 'Capital Hieghts', 'Maryland', '20743', 'Prince Georges', '301-817-0570', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Brandywine Elementary', '14101 Brandywine Road', 'Brandywine', 'Maryland', '20613', 'Prince Georges', '301-372-0100', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Buck Lodge Middle', '2611 Buck Lodge Road', 'Adelphi', 'Maryland', '20783', 'Prince Georges', '301-431-6290', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('C. Elizabeth Rieg Regional', '15542 Peach Walker Drive', 'Mitchellville', 'Maryland', '20721', 'Prince Georges', '301-390-0200', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Calverton Elementary', '3400 Beltsville Road', 'Beltsville', 'Maryland', '20705', 'Prince Georges', '301-572-0640', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Capitol Heights Elementary', '601 Suffolk Avenue', 'Capital Heights', 'Maryland', '20743', 'Prince Georges', '301-817-0494', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Carmody Hills Elementary', '401 Jadeleaf Avenue', 'Capital Heights', 'Maryland', '20743', 'Prince Georges', '301-808-8180', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Carole Highlands Elementary', '1610 Hannon Street', 'Takoma Park', 'Maryland', '20912', 'Prince Georges', '301-431-5660', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Carrollton Elementary', '8300 Quintana Street', 'New Carrolton', 'Maryland', '20784', 'Prince Georges', '301-918-8708', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Catherine T. Reed Elementary', '9501 Greenbelt Road', 'Lanham', 'Maryland', '20706', 'Prince Georges', '301-918-8716', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Central High', '200 Cabin Branch Road', 'Capital Heights', 'Maryland', '20743', 'Prince Georges', '301-499-7080', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('César Chávez Dual Spanish Immersion', '6609 Riggs Road', 'Hyattsville', 'Maryland', '20781', 'Prince Georges', '301-853-5694', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Chapel Forge Early Childhood Center', '12711 Milan Way', 'Bowie', 'Maryland', '20715', 'Prince Georges', '301-805-2740', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Charles Carroll Middle', '6130 Lamont Drive', 'New Carrollton', 'Maryland', '20784', 'Prince Georges', '301-918-8640', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Charles H. Flowers High', '10001 Ardwick-Ardmore Road', 'Springdale', 'Maryland', '20774', 'Prince Georges', '301-636-8000', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Cherokee Lane Elementary', '2617 Buck Lodge Road', 'Hyattsville', 'Maryland', '20781', 'Prince Georges', '301-445-8415', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Chillum Elementary', '1420 Timber Ridge Lane', 'Hyattsville', 'Maryland', '20781', 'Prince Georges', '301-853-0825', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Clinton Grove Elementary', '9420 Temple Hill Road', 'Clinton', 'Maryland', '20735', 'Prince Georges', '301-599-2414', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('CMIT Academy North - Elementary Public Charter', '6151 Chevy Chase Drive', 'Laurel', 'Maryland', '20707', 'Prince Georges', '240-573-7240', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('CMIT Academy North - High Public Charter', '14800 Sweitzer Lane', 'Laurel', 'Maryland', '20707', 'Prince Georges', '240-767-4080', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('CMIT Academy North - Middle Public Charter', '6100 Frost Place', 'Laurel', 'Maryland', '20707', 'Prince Georges', '301-350-6051', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('CMIT Academy South - Elementary Public Charter', '9601 Fallard Terrace', 'Upper Malboro', 'Maryland', '20772', 'Prince Georges', '240-767-4820', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('CMIT Academy South - High Public Charter', '9822 Fallard Court', 'Upper Malboro', 'Maryland', '20772', 'Prince Georges', '240-573-7250', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('CMIT Academy South - Middle Public Charter', '9822 Fallard Court', 'Upper Malboro', 'Maryland', '20772', 'Prince Georges', '240-573-7250', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Colin L. Powell Academy', '12200 Fort Washington Road', 'Fort Washington', 'Maryland', '20744', 'Prince Georges', '301-850-6402', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Columbia Park Elementary', '1901 Kent Village Drive', 'Landover', 'Maryland', '20785', 'Prince Georges', '301-925-1322', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Cool Spring Elementary', '8901 Riggs Road', 'Adelphi', 'Maryland', '20783', 'Prince Georges', '301-431-6200', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Cooper Lane Elementary', '3817 Cooper Lane', 'Landover Hills', 'Maryland', '20784', 'Prince Georges', '301-925-1350', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Cora L. Rice Elementary', '950 Nalley Road', 'Landover', 'Maryland', '20785', 'Prince Georges', '301-636-6340', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Crossland High', '6901 Temple Hill Road', 'Temple Hills', 'Maryland', '20748', 'Prince Georges', '301-449-4800', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Deerfield Run Elementary', '13000 Laurel-Bowie Road', 'Laurel', 'Maryland', '20707', 'Prince Georges', '301-497-3610', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('District Heights Elementary', '2200 County Road', 'District Heights', 'Maryland', '20747', 'Prince Georges', '301-817-0484', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Dodge Park Elementary', '3401 Hubbard Road', 'Landover', 'Maryland', '20785', 'Prince Georges', '301-883-4220', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Dora Kennedy French Immersion', '8950 Edmonston Road', 'Greenbelt', 'Maryland', '20770', 'Prince Georges', '301-918-8660', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Doswell E. Brooks Elementary', '1301 Brooke Road', 'Capital Heights', 'Maryland', '20743', 'Prince Georges', '301-817-0480', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Dr. Henry A. Wise Jr. High', '12650 Brooke Lane', 'Upper Malboro', 'Maryland', '20772', 'Prince Georges', '301-780-2100', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Drew-Freeman Middle', '2600 Brooks Drive', 'Suitland', 'Maryland', '20746', 'Prince Georges', '301-817-0900', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('DuVal High', '9880 Good Luck Road', 'Lanham', 'Maryland', '20706', 'Prince Georges', '301-918-8600', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Dwight D. Eisenhower Middle', '13725 Briarwood Drive', 'Laurel', 'Maryland', '20707', 'Prince Georges', '301-497-3620', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Edward M. Felegy Elementary', '6110 Editors Park Drive', 'Hyattsville', 'Maryland', '20781', 'Prince Georges', '301-386-1610', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Eleanor Roosevelt High', '7601 Hanover Parkway', 'Greenbelt', 'Maryland', '20770', 'Prince Georges', '301-513-5400', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Ellen Ochoa Middle', '5211 Flintridge Drive', 'Hyattsville', 'Maryland', '20781', 'Prince Georges', '301-372 0111', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Ernest Everett Just Middle', '1300 Campus Way North', 'Mitchellville', 'Maryland', '20721', 'Prince Georges', '301-808-4040', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('EXCEL Academy Public Charter', '6700 Bock Road', 'Fort Washington', 'Maryland', '20744', 'Prince Georges', '301-925-2320', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Fairmont Heights High', '6501 Columbia Park Road', 'Landover', 'Maryland', '20785', 'Prince Georges', '301-925-1360', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Flintstone Elementary', '800 Comanche Drive', 'Oxon Hill', 'Maryland', '20745', 'Prince Georges', '301-749-4210', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Forest Heights Elementary', '200 Talbert Drive', 'Oxon Hill', 'Maryland', '20745', 'Prince Georges', '301-749-4220', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Fort Foote Elementary', '8300 Oxon Hill Road', 'Fort Washington', 'Maryland', '20744', 'Prince Georges', '301-749-4230', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Fort Washington Forest Elementary', '1300 Fillmore Road', 'Fort Washinton', 'Maryland', '20744', 'Prince Georges', '301-203-1123', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Frances Fuchs Early Childhood Center', '11011 Cherry Hill Road', 'Beltsville', 'Maryland', '20705', 'Prince Georges', '301-572-0600', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Francis Scott Key Elementary', '2301 Scott Key Drive', 'District Heights', 'Maryland', '20747', 'Prince Georges', '301-817-7970', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Francis T. Evans Elementary', '6720 Old Alexander Ferry Road', 'Clinton', 'Maryland', '20735', 'Prince Georges', '301-599-2480', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Frederick Douglass High', '8000 Croom Road', 'Upper Malboro', 'Maryland', '20772', 'Prince Georges', '301-952-2400', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Friendly High', '10000 Allentown Road', 'Fort Washinton', 'Maryland', '20744', 'Prince Georges', '301-449-4900', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Friendship Aspire Bowie Charter', '9010 Frank Tippett Road', 'Upper Malboro', 'Maryland', '20772', 'Prince Georges', '301-789-5933', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('G. James Gholson Middle', '900 Nalley Road', 'Landover', 'Maryland', '20785', 'Prince Georges', '301-883-8390', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Gaywood Elementary', '6701 97th Avenue', 'Seabrook', 'Maryland', '20706', 'Prince Georges', '301-918-8730', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Gladys Noon Spellman Elementary', '3324 64th Avenue', 'Cheverly', 'Maryland', '20785', 'Prince Georges', '301-925-1944', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Glassmanor Elementary', '1011 Marcy Avenue', 'Oxon Hill', 'Maryland', '20745', 'Prince Georges', '301-749-4240', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Glenarden Woods Elementary', '7801 Glenarden Parkway', 'Glenarden', 'Maryland', '20706', 'Prince Georges', '301-925-1300', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Glenn Dale Elementary', '6700 Glenn Dale Road', 'Glenn Dale', 'Maryland', '20769', 'Prince Georges', '301-805-2750', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Glenridge Elementary', '7200 Gallatin Street', 'Landover Hills', 'Maryland', '20737', 'Prince Georges', '301-918-8740', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Greenbelt Elementary', '66 Ridge Road', 'Greenbelt', 'Maryland', '20770', 'Prince Georges', '301-513-5911', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Greenbelt Middle', '6301 Breezewood Drive', 'Greenbelt', 'Maryland', '20770', 'Prince Georges', '301-513-5040', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Gwynn Park High', '13800 Brandywine Road', 'Brandywine', 'Maryland', '20613', 'Prince Georges', '301-372-0140', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Gwynn Park Middle', '8000 Dyson Road', 'Branywine', 'Maryland', '20613', 'Prince Georges', '301-372-0120', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('H. Winship Wheatley Early Childhood Center', '8801 Ritchie Drive', 'Capital Heights', 'Maryland', '20743', 'Prince Georges', '301-808-8100', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Heather Hills Elementary', '12605 Heming Lane', 'Bowie', 'Maryland', '20715', 'Prince Georges', '301-805-2730', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('High Bridge Elementary', '7011 High Bridge Road', 'Bowie', 'Maryland', '20715', 'Prince Georges', '301-805-2690', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('High Point High', '3601 Powder Mill Road', 'Beltsville', 'Maryland', '20705', 'Prince Georges', '301-572-6400', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Highland Park Elementary', '6501 Lowland Drive', 'Landover', 'Maryland', '20785', 'Prince Georges', '301-333-0980', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Hillcrest Heights Elementary', '4305 22nd Place', 'Temple Hills', 'Maryland', '20748', 'Prince Georges', '301-702-3800', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Hollywood Elementary', '9811 49th Avenue', 'College Park', 'Maryland', '20740', 'Prince Georges', '301-513-5900', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Howard B. Owens Science Center', '9601 Greenbelt Road', 'Lanham', 'Maryland', '20706', 'Prince Georges', '301-918-8750', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Hyattsville Elementary', '5311 43rd Avenue', 'Hyattaville', 'Maryland', '20781', 'Prince Georges', '301-209-5800', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Hyattsville Middle', '6001 42nd Ave', 'Hyattsville', 'Maryland', '20781', 'Prince Georges', '301-209-5830', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Imagine Andrews Public Charter', '4701 San Antonio Blvd', 'AAFB', 'Maryland', '20762', 'Prince Georges', '301-350-6002', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Imagine Foundations at Leeland Public Charter', '14111 Oak Grove Road', 'Upper Malboro', 'Maryland', '20774', 'Prince Georges', '301-383-1899', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Imagine Foundations at Morningside Public Charter', '6900 Ames Street', 'Morningside', 'Maryland', '20746', 'Prince Georges', '301-817-0544', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Imagine Lincoln Public Charter', '4207 Norcross Street', 'Temple Hills', 'Maryland', '20748', 'Prince Georges', '301-808-5600', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Indian Queen Elementary', '9551 Fort Foote Road', 'Fort Washington', 'Maryland', '20744', 'Prince Georges', '301-749-4250', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('International High School at Langley Park', '5150 Annapolis Road', 'Blandensburg', 'Maryland', '20710', 'Prince Georges', '301-702-3910', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('International High School at Largo', '505 Largo Road', 'Largo', 'Maryland', '20774', 'Prince Georges', '301-702-3810', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('J. Frank Dent Elementary', '2700 Corning Avenue', 'Fort Washington', 'Maryland', '20744', 'Prince Georges', '301-702-3850', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('James E. Duckworth Regional', '11201 Evans Trail', 'Beltsville', 'Maryland', '20705', 'Prince Georges', '301-572-0620', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('James H. Harrison Elementary', '13200 Larchdale Road', 'Laurel', 'Maryland', '20707', 'Prince Georges', '301-497-3650', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('James Madison Middle', '7300 Woodyard Rd', 'Upper Malboro', 'Maryland', '20772', 'Prince Georges', '301-599-2422', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('James McHenry Elementary', '8909 McHenry Lane', 'Lanham', 'Maryland', '20706', 'Prince Georges', '301-918-8760', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('James Ryder Randall ECC', '5410 Kirby Road', 'Clinton', 'Maryland', '20735', 'Prince Georges', '301-497-3669', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('James Ryder Randall Elementary', '5410 Kirby Road', 'Clinton', 'Maryland', '20735', 'Prince Georges', '301-449-4980', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('John H. Bayne Elementary', '7010 Walker Mill Road', 'Capital Heights', 'Maryland', '20743', 'Prince Georges', '301-499-7020', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('John Hanson Montessori', '6360 Oxon Hill Road', 'Oxon Hill', 'Maryland', '20745', 'Prince Georges', '301-749-4052', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Judge Sylvania W. Woods Elementary', '3000 Church Street', 'Glenarden', 'Maryland', '20706', 'Prince Georges', '301-925-2840', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Judith P. Hoyer Montessori', '929 Hill Road', 'Landover', 'Maryland', '20785', 'Prince Georges', '301-808-4420', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Junior Achievement® Finance Park', '960 Nalley Road', 'Landover', 'Maryland', '20785', 'Prince Georges', '240-487-7541', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Kenilworth Elementary', '12520 Kembridge Drive', 'Bowie', 'Maryland', '20715', 'Prince Georges', '301-805-6600', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Kenmoor Early Childhood Center', '3211 82nd Avenue', 'Landover', 'Maryland', '20785', 'Prince Georges', '301-925-1970', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Kenmoor Middle', '2500 Kenmoor Drive', 'Landover', 'Maryland', '20785', 'Prince Georges', '301-925-2300', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Kettering Elementary', '11000 Layton Street', 'Upper Malboro', 'Maryland', '20774', 'Prince Georges', '301-808-5977', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Kettering Middle', '65 Herrington Drive', 'Upper Malboro', 'Maryland', '20774', 'Prince Georges', '301-808-4060', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Kingsford Elementary', '1401 Enterprise Road', 'Mitchellville', 'Maryland', '20721', 'Prince Georges', '301-390-0260', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Lake Arbor Elementary', '10205 Lake Arbor Way', 'Mitchellville', 'Maryland', '20721', 'Prince Georges', '301-808-5940', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Lamont Elementary', '7101 Good Luck Road', 'New Carrollton', 'Maryland', '20784', 'Prince Georges', '301-513-5205', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Langley Park-McCormick Elementary', '8201 15th Avenue', 'Hyattsville', 'Maryland', '20781', 'Prince Georges', '301-445-8423', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Largo High', '505 Largo Road', 'Upper Malboro', 'Maryland', '20774', 'Prince Georges', '301-808-8880', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Laurel Elementary', '516 Montgomery Street', 'Laurel', 'Maryland', '20707', 'Prince Georges', '301-497-3660', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Laurel High', '8000 Cherry Lane', 'Laurel', 'Maryland', '20707', 'Prince Georges', '301-497-2050', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Legends Public Charter', '9700 Philadelphia Court', 'Lanham', 'Maryland', '20706', 'Prince Georges', '240-455-5900', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Lewisdale Elementary', '2400 Banning Place', 'Hyattsville', 'Maryland', '20781', 'Prince Georges', '301-445-8433', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Longfields Elementary', '3300 Newkirk Avenue', 'Forestsville', 'Maryland', '20747', 'Prince Georges', '301-817-0455', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Magnolia Elementary', '8400 Nightingale Drive', 'Lanham', 'Maryland', '20706', 'Prince Georges', '301-918-8770', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Marlton Elementary', '8506 Old Colony - South Drive', 'Upper Malboro', 'Maryland', '20772', 'Prince Georges', '301-952-7780', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Martin Luther King Jr. Middle', '4545 Ammendale Road', 'Beltsville', 'Maryland', '20705', 'Prince Georges', '301-572-0650', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Mary Harris "Mother" Jones Elementary', '2405 Tecumseh Street', 'Adelphi', 'Maryland', '20783', 'Prince Georges', '301-408-7900', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Mattaponi Elementary', '11701 Duley Station Road', 'Upper Malboro', 'Maryland', '20772', 'Prince Georges', '301-599-2442', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Maya Angelou French Immersion', '2000 Callaway Street', 'Temple Hills', 'Maryland', '20748', 'Prince Georges', '301-702-3950', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Melwood Elementary', '7100 Woodyard Road', 'Upper Malboro', 'Maryland', '20772', 'Prince Georges', '301-599-2500', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Montpelier Elementary', '9200 Muirkirk Road', 'Laurel', 'Maryland', '20707', 'Prince Georges', '301-497-3670', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Mount Rainier Elementary', '4011 32nd Street', 'Mount Rainier', 'Maryland', '20712', 'Prince Georges', '301-985-1810', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Nicholas Orem Middle', '6100 Editors Park Drive', 'Hyattsville', 'Maryland', '20781', 'Prince Georges', '301-853-0840', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Non-Traditional Middle Program', '2001 Shadyside Avenue', 'Suitland', 'Maryland', '20746', 'Prince Georges', '301-817-3100', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Non-Traditional Program 9-12 North', '2112 Church Road', 'Bowie', 'Maryland', '20715', 'Prince Georges', '301-390-0230', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Non-Traditional Program 9-12 South', '9400 Surratts Road', 'Cheltenham', 'Maryland', '20623', 'Prince Georges', '301-372-8846', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('North Forestville Elementary', '2311 Ritchie Road', 'Forestville', 'Maryland', '20747', 'Prince Georges', '301-499-7098', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Northview Elementary', '3700 Northview Drive', 'Bowie', 'Maryland', '20715', 'Prince Georges', '301-218-1520', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Northwestern High', '7000 Adelphi Road', 'Hyattsville', 'Maryland', '20781', 'Prince Georges', '301-985-1820', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Oaklands Elementary', '13710 Laurel-Bowie Road', 'Laurel', 'Maryland', '20707', 'Prince Georges', '301-497-3110', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Overlook Full Spanish Immersion', '3298 Curtis Drive', 'Temple Hills', 'Maryland', '20748', 'Prince Georges', '301-702-3831', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Oxon Hill Elementary', '7701 Livingston Road', 'Oxon Hill', 'Maryland', '20745', 'Prince Georges', '301-749-4290', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Oxon Hill High', '6701 Leyte Drive', 'Oxon Hill', 'Maryland', '20745', 'Prince Georges', '301-749-4300', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Oxon Hill Middle', '9570 Fort Foote Road', 'Fort Washington', 'Maryland', '20744', 'Prince Georges', '301-749-4270', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Paint Branch Elementary', '5101 Pierce Avenue', 'College Park', 'Maryland', '20740', 'Prince Georges', '301-513-5300', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Panorama Elementary', '2002 Callaway Street', 'Temple Hills', 'Maryland', '20748', 'Prince Georges', '301-702-3870', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Parkdale High', '6001 Good Luck Road', 'Riverdale', 'Maryland', '20737', 'Prince Georges', '301-513-5700', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Patuxent Elementary', '4410 Bishopmill Drive', 'Upper Malboor', 'Maryland', '20772', 'Prince Georges', '301-952-7700', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Perrywood Elementary', '501 Watkins Park Drive', 'Largo', 'Maryland', '20774', 'Prince Georges', '301-218-3040', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('PGCPS Online Campus', '4815 Dalton Street', 'Temple Hills', 'Maryland', '20748', 'Prince Georges', '301-817-3100', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Phyllis E. Williams Spanish Immersion', '9601 Prince Place', 'Upper Malboro', 'Maryland', '20774', 'Prince Georges', '301-499-3373', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Pointer Ridge Elementary', '1110 Parkington Lane', 'Bowie', 'Maryland', '20715', 'Prince Georges', '301-390-0220', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Port Towns Elementary', '4351 58th Avenue', 'Bladensburg', 'Maryland', '20710', 'Prince Georges', '301-985-1480', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Potomac High', '5211 Boydell Avenue', 'Oxon Hill', 'Maryland', '20745', 'Prince Georges', '301-702-3900', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Princeton Elementary', '6101 Baxter Drive', 'Suitland', 'Maryland', '20746', 'Prince Georges', '301-702-7650', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Ridgecrest Elementary', '6120 Riggs Road', 'Hyattsville', 'Maryland', '20781', 'Prince Georges', '301-853-0820', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Riverdale Elementary', '5006 Riverdale Road', 'Riverdale', 'Maryland', '20737', 'Prince Georges', '301-985-1850', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Robert Frost Elementary', '7910 Scott Drive', 'Landover', 'Maryland', '20785', 'Prince Georges', '301-918-8792', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Robert Goddard Montessori', '9850 Good Luck Road', 'Seabrook', 'Maryland', '20706', 'Prince Georges', '301-918-3515', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Robert R. Gray Elementary', '4949 Addison Road', 'Capital Heights', 'Maryland', '20743', 'Prince Georges', '301-636-8400', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Rockledge Elementary', '7701 Laurel-Bowie Road', 'Bowie', 'Maryland', '20715', 'Prince Georges', '301-805-2720', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Rogers Heights Elementary', '4301 58th Avenue', 'Bladensburg', 'Maryland', '20710', 'Prince Georges', '301-985-1860', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Rosa L. Parks Elementary', '6111 Ager Road', 'Hyattsville', 'Maryland', '20781', 'Prince Georges', '301-445-8090', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Rosaryville Elementary', '9925 Rosaryville Road', 'Upper Malboro', 'Maryland', '20772', 'Prince Georges', '301-599-2490', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Samuel Chase Elementary', '5700 Fisher Road', 'Temple Hills', 'Maryland', '20748', 'Prince Georges', '301-702-7660', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Samuel Ogle Middle', '4111 Chelmont Lane', 'Bowie', 'Maryland', '20715', 'Prince Georges', '301-805-2641', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Samuel P. Massie Academy', '3301 Regency Parkway', 'Forestville', 'Maryland', '20747', 'Prince Georges', '301-669-1120', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Scotchtown Hills Elementary', '15950 Dorset Road', 'Laurel', 'Maryland', '20707', 'Prince Georges', '301-497-3994', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Seabrook Elementary', '6001 Seabrook Road', 'Seabrook', 'Maryland', '20706', 'Prince Georges', '301-918-8542', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Seat Pleasant Elementary', '6411 G Street', 'Capital Heights', 'Maryland', '20743', 'Prince Georges', '301-925-2330', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Sonia Sotomayor Middle at Adelphi', '8820 Riggs Rd', 'Adelphi', 'Maryland', '20783', 'Prince Georges', '301-850-6404', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Springhill Lake Elementary', '6060 Springhill Drive', 'Geenbelt', 'Maryland', '20770', 'Prince Georges', '301-513-5996', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Stephen Decatur Middle', '8200 Pinewood Drive', 'Clinton', 'Maryland', '20735', 'Prince Georges', '301-449-4950', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Suitland Elementary', '4650 Towne Park Road', 'Suitland', 'Maryland', '20746', 'Prince Georges', '301-817-3770', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Suitland High', '5200 Silver Hill Road', 'Forestville', 'Maryland', '20747', 'Prince Georges', '301-817-0500', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Surrattsville High', '6101 Garden Drive', 'Clinton', 'Maryland', '20735', 'Prince Georges', '301-599-2453', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Tayac Elementary', '8600 Allentown Road', 'Fort Washington', 'Maryland', '20744', 'Prince Georges', '301-449-4840', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Templeton Elementary', '6001 Carters Lane', 'Riverdale', 'Maryland', '20737', 'Prince Georges', '301-985-1880', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Thomas G. Pullen K-8 Creative and Performing Arts', '700 Brightseat Road', 'Landover', 'Maryland', '20785', 'Prince Georges', '301-808-8160', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Thomas Johnson Middle', '5401 Barker Place', 'Lanham', 'Maryland', '20706', 'Prince Georges', '301-918-8680', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Thomas S. Stone Elementary', '4500 34th Street', 'Mount Rainer', 'Maryland', '20712', 'Prince Georges', '301-985-1890', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Thurgood G. Marshall Middle', '4909 Brinkley Road', 'Temple Hills', 'Maryland', '20748', 'Prince Georges', '301-702-7540', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Tulip Grove Elementary', '2909 Trainor Lane', 'Bowie', 'Maryland', '20715', 'Prince Georges', '301-805-2680', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('University Park Elementary', '4315 Underwood Street', 'Hyattsville', 'Maryland', '20782', 'Prince Georges', '301-985-1898', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Valley View Elementary', '5500 Danby Avenue', 'Oxon Hill', 'Maryland', '20745', 'Prince Georges', '301-749-4350', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Vansville Elementary', '6813 Ammendale Road', 'Beltsville', 'Maryland', '20705', 'Prince Georges', '301-931-2830', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Waldon Woods Elementary', '10301 Thrift Road', 'Clinton', 'Maryland', '20735', 'Prince Georges', '301-599-2540', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Walker Mill Middle', '800 Karen Blvd', 'Capitial Heights', 'Maryland', '20743', 'Prince Georges', '301-808-4055', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Whitehall Elementary', '3901 Woodhaven Lane', 'Bowie', 'Maryland', '20715', 'Prince Georges', '301-805-1000', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('William Beanes Elementary', '5108 Dianna Drive', 'Suitalnd', 'Maryland', '20746', 'Prince Georges', '301-817-0533', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('William Paca Elementary', '7801 Sheriff Road', 'Landover', 'Maryland', '20785', 'Prince Georges', '301-925-1330', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('William S. Schmidt Outdoor Education Center', '18501 Aquasco Road', 'Brandywine', 'Maryland', '20613', 'Prince Georges', '301-888-1185', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('William W. Hall Academy', '5200 Marlboro Pike', 'Capital Heights', 'Maryland', '20743', 'Prince Georges', '301-817-2933', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('William Wirt Middle', '6200 Tuckerman Street', 'Riverdale', 'Maryland', '20737', 'Prince Georges', '301-985-1720', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Woodmore Elementary @ Meadowbrook', '3501 Moylen Drive', 'Bowie', 'Maryland', '20715', 'Prince Georges', '301-390-0239', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Woodridge Elementary', '5001 Flintridge Drive', 'Hyattsville', 'Maryland', '20781', 'Prince Georges', '301-918-8585', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Yorktown Elementary', '7301 Race Track Road', 'Bowie', 'Maryland', '20715', 'Prince Georges', '301-805-6610', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Chelsea School', '2970 Belcrest Center Drive, Suite 300', 'Hyattsville', 'Maryland', '20781', 'Prince Georges', '240-467-2100', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('The Foundation Learning Center', '855 Brightseat Road, Suite 855', 'landover', 'Maryland', '20785', 'Prince Georges', '301-881-0078', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('The Foundation School', '1330 McCormick Drive', 'largo', 'Maryland', '20774', 'Prince Georges', '301-773-3500', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('High Road Acedemy of Prince Georges', '5100 Philadelphia Way', 'Lanham', 'Maryland', '20706', 'Prince Georges', '301-429-6191', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('High Road Lower School of Prince Georges', '9701 Philadelphia ct, Suite P', 'Lanham', 'Maryland', '20706', 'Prince Georges', '301-636-6614', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('High Road Upper School of Prince Georg''s County', '9701 Philadelphia ct, Suite M', 'Lanham', 'Maryland', '20706', 'Prince Georges', '301-210-4860', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Kennedy Krieger School: Power Mill Campus', '460 Powder Mill Road, Suite 500', 'Beltsville', 'Maryland', '20705', 'Prince Georges', '443-923-4170', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('The Pathways School- Edgewood', '4600 Powder Mill Road, suite 100', 'Beltsville', 'Maryland', '20705', 'Prince Georges', '301-681-4112', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('The Children''s Guild School of Prince Georges', '5702 Sargent Road', 'Chillum', 'Maryland', '20782', 'Prince Georges', '301-853-7370', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;


--Queen Annes

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('ARISE Academy', '671 Romancoke Road', 'Centreville', 'Maryland', '21617', 'Queen Annes', '410-643-7172', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Bayside Elementary School', '301 Church Street', 'Stevensville', 'Maryland', '21666', 'Queen Annes', '410-643-6181', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Centreville Elementary School', '213 Homewood Ave', 'Centreville', 'Maryland', '21617', 'Queen Annes', '410-758-1320', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Centreville Middle School', '231 Ruthsburg RD', 'Centreville', 'Maryland', '21617', 'Queen Annes', '410-758-0883', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Church Hill Elementary School', '631 Main St', 'Church Hill', 'Maryland', '21623', 'Queen Annes', '410-556-6681', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Grasonville Elementary School', '5435 Main St', 'Grasonville', 'Maryland', '21638', 'Queen Annes', '410-827-8070', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Kennard Elementary School', '420 Little Kidwell Ave', 'Centreville', 'Maryland', '21617', 'Queen Annes', '410-758-1166', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Kent Island Elementary School', '110 Elementary Way', 'Stevensville', 'Maryland', '21666', 'Queen Annes', '410-643-2392', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Kent Island High School', '900 Love Point rd', 'Stevensville', 'Maryland', '21666', 'Queen Annes', '410-604-2070', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Matapeake Elementary School', '651 Romancoke Rd', 'Stevensville', 'Maryland', '21666', 'Queen Annes', '410-643-3105', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Matapeake Middle School', '671 Romancoke Rd', 'Stevensville', 'Maryland', '21666', 'Queen Annes', '410-643-7330', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Queen Annes High School', '125 Ruthsburg RD', 'Centreville', 'Maryland', '21617', 'Queen Annes', '410-758-0500', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Stevensville Middle School', '610 Main St', 'Stevensville', 'Maryland', '21666', 'Queen Annes', '410-643-3194', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Sudlersville Elementary School', '300 South Church St', 'Sudlersville', 'Maryland', '21668', 'Queen Annes', '410-438-3164', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Sudlersville Middle School', '600 Charles St', 'Sudlersville', 'Maryland', '21668', 'Queen Annes', '410-438-3151', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

--Talbot County

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Chapel District Elementary', '11430 Cordova Road', 'Cordova', 'Maryland', '21625', 'Talbot County', '410-822-2391', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Easton Elementary', '307 Glenwood Ave.', 'Easton', 'Maryland', '21601', 'Talbot County', '410-822-0686', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('St. Michaels Elementary', '100 Seymour Ave.', 'St. Michael''s', 'Maryland', '21663', 'Talbot County', '410-745-2882', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Tilghman Elementary', '21374 Foster Ave.', 'Tilghman', 'Maryland', '21671', 'Talbot County', '410-886-2391', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('White Marsh Elementary', '4322 Lovers Lane', 'Trappe', 'Maryland', '21673', 'Talbot County', '410-476-3144', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Easton High', '723 Mecklenburg Ave.', 'Easton', 'Maryland', '21601', 'Talbot County', '410-822-4180', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Easton Middle', '201 Peachblossom Road', 'Easton', 'Maryland', '21601', 'Talbot County', '410-822-2910', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('St. Michaels Middle High', '200 Seymour Ave.', 'St. Michael''s', 'Maryland', '21663', 'Talbot County', '410-745-2852', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;



--Somerset County

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Carter G. Woodson Elementary School', '281 Woodson School Rd', 'Crisfield', 'Maryland', '21817', 'Somerset County', '410-968-1295', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Deal Island Elementary School', '23275 Lola Wheatley RD', 'Deal Island', 'Maryland', '21821', 'Somerset County', '410-784-2449', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Greenwood Elementary School', '11412 Dryden Rd', 'Princess Anne', 'Maryland', '21853', 'Somerset County', '410-651-0931', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Princess Anne Elementary School', '11576 Lankford St', 'Princess Anne', 'Maryland', '21853', 'Somerset County', '410-651-0484', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Somerset Intermediate School', '7971 Tawes Campus Dr', 'Westover', 'Maryland', '21871', 'Somerset County', '410-621-0160', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Crisfield High School & Academy', '210 North Somerset Ave', 'Crisfield', 'Maryland', '21817', 'Somerset County', '410-968-0150', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Washington High School & Academy', '10902 Old Princess Anne Rd', 'Princess Anne', 'Maryland', '21853', 'Somerset County', '410-651-0480', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Somerset County Technical High School', '7994 Tawes Campus Dr', 'Westover', 'Maryland', '21871', 'Somerset County', '410-651-2285', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;


--St Marys

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Benjamin Banneker Elementary School', '27180 Point Lookout Rd', 'Loveville', 'Maryland', '20656', 'St Marys', '301-475-0260', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Captain Walter Francis Duke Elementary School', '23595 Hayden Farm Ln', 'Leonardtown', 'Maryland', '20650', 'St Marys', '240-309-4658', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Chesapeake Public Charter', '20945 Great Mills Rd', 'Lexington Park', 'Maryland', '20653', 'St Marys', '301-863-9585', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Dynard Elementary School', '23510 Bushwood Rd', 'Chaptico', 'Maryland', '20621', 'St Marys', '301-769-4804', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Evergreen Elementary School', '43765 Evergreen Way', 'California', 'Maryland', '20619', 'St Marys', '301-863-4060', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('George Washington Carver Elementary School', '46155 Carver School Blvd', 'Lexington Park', 'Maryland', '20653', 'St Marys', '301-863-4076', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Green Holly Elementary School', '46060 Millstone Landing Rd', 'Lexington Park', 'Maryland', '20653', 'St Marys', '301-863-4064', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Greenview Knolls Elementary School', '45711 Military Lane', 'Great Mills', 'Maryland', '20634', 'St Marys', '301-863-4095', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Hollywood Elementary School', '44345 Joy Chapel Rd', 'Hollywood', 'Maryland', '20636', 'St Marys', '301-373-4350', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Leonardtown Elementary School', '22885 Duke St', 'Leonardtown', 'Maryland', '20650', 'St Marys', '301-475-0250', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Lettie Marshall Dent Elementary School', '37840 New Marker Turner Rd', 'Mechanicsville', 'Maryland', '20659', 'St Marys', '301-472-4500', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Lexington Park Elementary School', '46763 South Shangri LA Dr', 'Lexington Park', 'Maryland', '20653', 'St Marys', '301-863-4085', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Mechanicsville Elementary School', '28585 Three Notch Rd', 'Mechanicsville', 'Maryland', '20659', 'St Marys', '301-472-4800', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Oakville Elementary School', '26410 Three Notch Rd', 'Mechanicsville', 'Maryland', '20659', 'St Marys', '301-373-4365', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Park Hall Elementary School', '20343 Harmanville Rd', 'Park Hall', 'Maryland', '20667', 'St Marys', '301-863-4054', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Piney Point Elementary School', '44550 Tall Timbers Rd', 'Tall Timbers', 'Maryland', '20690', 'St Marys', '301-994-2205', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Ridge Elementary School', '49430 Airedele Rd', 'Ridge', 'Maryland', '20680', 'St Marys', '301-872-0200', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Town Creek Elementary School', '45805 Dent Dr', 'Lexington Park', 'Maryland', '20653', 'St Marys', '301-863-4044', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('White Marsh Elementary School', '29090 Thompson Corner Rd', 'Mechanicsville', 'Maryland', '20659', 'St Marys', '301-472-4600', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Esperanza Middle School', '22790 Maple Rd', 'Lexington Park', 'Maryland', '20653', 'St Marys', '301-863-4016', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Leonardtown Middle School', '24015 Point Lookout Rd', 'Leonardtown', 'Maryland', '20650', 'St Marys', '301-475-0230', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Margaret Brent Middle School', '29675 Point Lookout Rd', 'Mechanicsville', 'Maryland', '20659', 'St Marys', '301-884-4635', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Spring Ridge Middle School', '19856 Three Notch Rd', 'Lexington Park', 'Maryland', '20653', 'St Marys', '301-863-4031', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Chopticon High School', '25390 Colton Point Rd', 'Morganza', 'Maryland', '20660', 'St Marys', '301-475-0215', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Great Mills High School', '21130 Great Mills Rd', 'Great Mills', 'Maryland', '20634', 'St Marys', '301-863-4001', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Leonardtown High School', '23995 Point Lookout Rd', 'Leonardtown', 'Maryland', '20650', 'St Marys', '301-475-0200', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Dr. James A. Forrest Career and Technology Center', '24005 Point Lookout Rd', 'Leonardtown', 'Maryland', '20650', 'St Marys', '301-475-0242', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Virtual Academy', '20833 Great Mills Rd', 'Lexington Park', 'Maryland', '20653', 'St Marys', '301-863-4090', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Kennedy Krieger School; Southern Maryland Campus', '44219 Airport Road Building 1', 'California', 'Maryland', '20619', 'St Marys', '667-205-4500', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

--Washington

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Bester Elementary', '385 Mill Street', 'Hagerstown', 'Maryland', '21740', 'Washington', '301-766-8001', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Boonsboro Elementary', '5 Campus Avenue', 'Boonsboro', 'Maryland', '21713', 'Washington', '301-766-8013', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Cascade Elementary', '14519 Pennersville Road', 'Cascade', 'Maryland', '21719', 'Washington', '301-766-8066', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Clear Spring Elementary', '12627 Broadfording Road', 'Clear Spring', 'Maryland', '21722', 'Washington', '301-766-8074', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Eastern Elementary', '1320 Yale Drive', 'Hagerstown', 'Maryland', '21740', 'Washington', '301-766-8122', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Emma K. Doub Elementary', '1221 South Potomac Street', 'Hagerstown', 'Maryland', '21740', 'Washington', '301-766-8130', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Fountain Rock Elementary', '17145 Lappans Road', 'Hagerstown', 'Maryland', '21740', 'Washington', '301-766-8146', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Fountaindale Elementary', '901 Northern Avenue', 'Hagerstown', 'Maryland', '21740', 'Washington', '301-766-8156', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Greenbrier Elementary', '21222 San Mar Road', 'Boonsboro', 'Maryland', '21713', 'Washington', '301-766-8170', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Hancock Elementary', '290 West Main Street', 'Hancock', 'Maryland', '21750', 'Washington', '301-766-8178', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Hickory Elementary', '11101 Hickory School Road', 'Williamsport', 'Maryland', '21795', 'Washington', '301-766-8198', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Jonathan Hager Elementary', '12615 Sedgwick Way', 'Hagerstown', 'Maryland', '21740', 'Washington', '301-766-8440', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Lincolnshire Elementary', '17545 Lincolnshire Road', 'Hagerstown', 'Maryland', '21740', 'Washington', '301-766-8206', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Maugansville Elementary', '18023 Maugans Avenue', 'Hagerstown', 'Maryland', '21740', 'Washington', '301-766-8230', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Old Forge Elementary', '21615 Old Forge Road', 'Hagerstown', 'Maryland', '21740', 'Washington', '301-766-8273', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Pangborn Elementary', '195 Pangborn Boulevard', 'Hagerstown', 'Maryland', '21740', 'Washington', '301-766-8282', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Paramount Elementary', '19410 Longmeadow Road', 'Hagerstown', 'Maryland', '21740', 'Washington', '301-766-8289', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Pleasant Valley Elementary', '1707 Rohrersville Road', 'Knoxville', 'Maryland', '21758', 'Washington', '301-766-8297', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Potomac Heights Elementary', '301 East Magnolia Avenue', 'Hagerstown', 'Maryland', '21740', 'Washington', '301-766-8305', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Rockland Woods Elementary', '18201 Rockland Drive', 'Hagerstown', 'Maryland', '21740', 'Washington', '301-766-8485', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Ruth Ann Monroe Primary', '1311 Yale Drive', 'Hagerstown', 'Maryland', '21740', 'Washington', '301-766-8668', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Salem Avenue Elementary', '1323 Salem Avenue', 'Hagerstown', 'Maryland', '21740', 'Washington', '301-766-8313', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Sharpsburg Elementary', '17525 Shepherdstown Pike', 'Sharpsburg', 'Maryland', '21782', 'Washington', '301-766-8321', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Smithsburg Elementary', '67 North Main Street', 'Smithsburg', 'Maryland', '21783', 'Washington', '301-766-8329', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Williamsport Elementary', '1 South Clifton Drive', 'Williamsport', 'Maryland', '21795', 'Washington', '301-766-8415', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Boonsboro Middle', '1 JH Wade Drive', 'Boonsboro', 'Maryland', '21713', 'Washington', '301-766-8038', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Clear Spring Middle', '12628 Broadfording Road', 'Clear Spring', 'Maryland', '21722', 'Washington', '301-766-8094', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('E. Russell Hicks Middle', '1321 South Potomac Street', 'Hagerstown', 'Maryland', '21740', 'Washington', '301-766-8110', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Northern Middle', '701 Northern Avenue', 'Hagerstown', 'Maryland', '21740', 'Washington', '301-766-8258', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Smithsburg Middle', '334 Sunset Avenue', 'Smithsburg', 'Maryland', '21783', 'Washington', '301-766-8389', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Springfield Middle', '334 Sunset Avenue', 'Williamsport', 'Maryland', '21795', 'Washington', '301-766-8389', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Western Heights Middle', '1300 Marshall Street', 'Hagerstown', 'Maryland', '21740', 'Washington', '301-766-8403', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Barbara Ingram School for the Arts', '7 South Potomac Street', 'Hagerstown', 'Maryland', '21740', 'Washington', '301-766-8840', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Boonsboro High', '10 Campus Avenue', 'Boonsboro', 'Maryland', '21713', 'Washington', '301-766-8022', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Boyd J. Michael, III Technical High', '50 West Oak Ridge Drive', 'Hagerstown', 'Maryland', '21740', 'Washington', '301-766-8050', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Clear Spring High', '12630 Broadfording Road', 'Clear Spring', 'Maryland', '21722', 'Washington', '301-766-8082', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Hancock Middle Senior High School', '289 West Main Street', 'Hancock', 'Maryland', '21750', 'Washington', '301-766-8186', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('North Hagerstown High', '1200 Pennsylvania Avenue', 'Hagerstown', 'Maryland', '21740', 'Washington', '301-766-8238', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Smithsburg High', '66 North Main Street', 'Smithsburg', 'Maryland', '21783', 'Washington', '301-766-8337', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('South Hagerstown High', '1101 South Potomac Street', 'Hagerstown', 'Maryland', '21740', 'Washington', '301-766-8369', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Williamsport High', '5 South Clifton Drive', 'Williamsport', 'Maryland', '21795', 'Washington', '301-766-8423', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Cedar Ridge School', '12146 Cedar Ridge Road', 'Williamsport', 'Maryland', '21795', 'Washington', '301-582-0282', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Laurel Hall School', '13310-A Brook Lane', 'Hagerstown', 'Maryland', '21740', 'Washington', '301-733-0330', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

--Wicomico

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Beaver Run Elementary', '31481 Old Ocean City Rd', 'Salisbury', 'Maryland', '21804', 'Wicomico', '410-677-5101', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Charles H. Chipman Elementary', '711 Lake St', 'Salisbury', 'Maryland', '21804', 'Wicomico', '410-677-5814', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Delmar Elementary', '811 S 2nd St', 'Delmar', 'Maryland', '21875', 'Wicomico', '410-677-5178', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('East Salisbury Elementary', '1201 Old Ocean City Road', 'Salisbury', 'Maryland', '21804', 'Wicomico', '410-677-5803', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Fruitland Intermediate', '208 W Main St', 'Fruitland', 'Maryland', '21826', 'Wicomico', '410-677-5805', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Fruitland Primary', '301 N Division St', 'Fruitland', 'Maryland', '21826', 'Wicomico', '410-677-5171', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Glen Avenue Elementary', '1615 Glen Avenue Ext', 'Salisbury', 'Maryland', '21804', 'Wicomico', '410-677-5806', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('North Salisbury Elementary', '1213 Emerson Ave', 'Salisbury', 'Maryland', '21804', 'Wicomico', '410-677-5807', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Northwestern Elementary', '9975 Sharptown Rd', 'Mardela Springs', 'Maryland', '21837', 'Wicomico', '410-677-5808', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Pemberton Elementary', '1300 Pemberton Dr', 'Salisbury', 'Maryland', '21804', 'Wicomico', '410-677-5809', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Pinehurst Elementary', '520 S Pinehurst Ave', 'Salisbury', 'Maryland', '21804', 'Wicomico', '410-677-5810', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Pittsville Elementary & Middle', '34404 Old Ocean City Road', 'Pittsville', 'Maryland', '21850', 'Wicomico', '410-677-5811', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Prince Street Elementary', '400 Prince St', 'Salisbury', 'Maryland', '21804', 'Wicomico', '410-677-5813', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('West Salisbury Elementary', '1321 West Road', 'Salisbury', 'Maryland', '21804', 'Wicomico', '410-677-5816', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Westside Intermediate', '8000 Quantico Rd', 'Hebron', 'Maryland', '21830', 'Wicomico', '410-677-5118', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Westside Primary', '6046 Quantico Rd', 'Quantico', 'Maryland', '21856', 'Wicomico', '410-677-5117', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Willards Elementary', '36161 Richland Rd', 'Willards', 'Maryland', '21874', 'Wicomico', '410-677-5819', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Bennett Middle', '532 South Division Street', 'Fruitland', 'Maryland', '21826', 'Wicomico', '410-677-5140', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Mardela Middle & High', '24940 Delmar Rd', 'Mardela Springs', 'Maryland', '21837', 'Wicomico', '410-677-5142', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Salisbury Middle', '607 Morris Street', 'Salisbury', 'Maryland', '21804', 'Wicomico', '410-677-5149', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Wicomico Middle', '635 E Main St', 'Salisbury', 'Maryland', '21804', 'Wicomico', '410-677-5145', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Career & Technical Education', '1015 Beaglin Park Drive', 'Salisbury', 'Maryland', '21804', 'Wicomico', '410-677-5144', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Evening High School', '916 S. Schumaker Drive', 'Salisbury', 'Maryland', '21804', 'Wicomico', '410-677-4537', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('James M. Bennett High', '300 E. College Ave', 'Salisbury', 'Maryland', '21804', 'Wicomico', '410-677-5141', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Parkside High', '1015 Beaglin Park Dr', 'Salisbury', 'Maryland', '21804', 'Wicomico', '410-677-5143', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Wicomico High', '201 Long Ave.', 'Salisbury', 'Maryland', '21804', 'Wicomico', '410-677-5146', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

--Worcester

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Buckingham Elementary School', '100 Buckingham Road', 'Berlin', 'Maryland', '21811', 'Worcester', '410-632-5300', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Ocean City Elementary School', '12828 Center Drive', 'Ocean City', 'Maryland', '21842', 'Worcester', '410-632-5370', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Showell Elementary School', '11318 Showell School Road', 'Berlin', 'Maryland', '21811', 'Worcester', '410-632-5350', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Berlin Intermediate School', '309 Franklin Ave', 'Berlin', 'Maryland', '21811', 'Worcester', '410-632-5320', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Stephen Decatur Middle School', '9815 Seahawk Road', 'Berlin', 'Maryland', '21811', 'Worcester', '410-632-3400', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Stephen Decatur High School', '9913 Seahawk Rd', 'Berlin', 'Maryland', '21811', 'Worcester', '410-632-2880', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Pocomoke Elementary School', '2119 Pocomoke Beltway', 'Pocomoke', 'Maryland', '21851', 'Worcester', '410-632-5130', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Pocomoke Middle School', '800 8th Street', 'Pocomoke City', 'Maryland', '21851', 'Worcester', '410-632-5150', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Pocomoke High School', '1817 Old Virginia Road', 'Pocomoke', 'Maryland', '21851', 'Worcester', '410-632-5180', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Snow Hill Elementary School', '515 Coulbourne Lane', 'Snow Hill', 'Maryland', '21863', 'Worcester', '410-632-5210', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Snow Hill Middle School', '522 Coulbourne Lane', 'Snow Hill', 'Maryland', '21863', 'Worcester', '410-632-5240', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Snow Hill High School', '522 Coulbourne Lane', 'Snow Hill', 'Maryland', '21863', 'Worcester', '410-632-5240', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag)
VALUES ('Worcester Technical High School', '6290 Worcester Highway', 'Newark', 'Maryland', '21841', 'Worcester', '410-632-5050', NOW(), 'CIDM-10611', 'CIDM-10611', NOW(), 1)
ON CONFLICT ("schoolname", address1) DO NOTHING;




