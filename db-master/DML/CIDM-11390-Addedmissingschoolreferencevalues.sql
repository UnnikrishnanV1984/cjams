---------------------------------------------------------------------------------
--Revision(s)
-- 05/08/2026 - Vinesh Narayanan - CIDM-111390 - Added missing school information
----------------------------------------------------------------------------------

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag) 
VALUES ('Annapolis High School', '2700 Riva Road', 'Annapolis', 'Maryland', '21401', 'Anne Arundel', '410-266-5240', NOW(), 'CIDM-11390', 'CIDM-11390', NOW(), 1) 
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag) 
VALUES ('Anne Arundel Evening High School', NULL, 'Anne Arundel', 'Maryland', NULL, 'Anne Arundel', '410-222-5384', NOW(), 'CIDM-11390', 'CIDM-11390', NOW(), 1) 
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag) 
VALUES ('Arundel High School', '1001 Annapolis Road', 'Gambrills', 'Maryland', '21054', 'Anne Arundel', '410-674-6500', NOW(), 'CIDM-11390', 'CIDM-11390', NOW(), 1) 
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag) 
VALUES ('Broadneck High School', '1265 Green Holly Drive', 'Annapolis', 'Maryland', '21409', 'Anne Arundel', '410-757-1300', NOW(), 'CIDM-11390', 'CIDM-11390', NOW(), 1) 
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag) 
VALUES ('Chesapeake High School', '4798 Mountain Road', 'Pasadena', 'Maryland', '21122', 'Anne Arundel', '410-255-9600', NOW(), 'CIDM-11390', 'CIDM-11390', NOW(), 1) 
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag) 
VALUES ('Crofton High School', '2291 Davidsonville Road', 'Gambrills', 'Maryland', '21054', 'Anne Arundel', '410-451-5300', NOW(), 'CIDM-11390', 'CIDM-11390', NOW(), 1) 
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag) 
VALUES ('Glen Burnie High School', '7550 Baltimore Annapolis Blvd.', 'Glen Burnie', 'Maryland', '21060', 'Anne Arundel', '410-424-2500', NOW(), 'CIDM-11390', 'CIDM-11390', NOW(), 1) 
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag) 
VALUES ('Meade High School', '1100 Clark Road', 'Fort George G Meade', 'Maryland', '20755', 'Anne Arundel', '410-672-4400', NOW(), 'CIDM-11390', 'CIDM-11390', NOW(), 1) 
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag) 
VALUES ('North County High School', '10 E. 1st Avenue', 'Glen Burnie', 'Maryland', '21061', 'Anne Arundel', '410-222-6970', NOW(), 'CIDM-11390', 'CIDM-11390', NOW(), 1) 
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag) 
VALUES ('Northeast High School', '1121 Duvall Highway', 'Pasadena', 'Maryland', '21122', 'Anne Arundel', '410-437-6400', NOW(), 'CIDM-11390', 'CIDM-11390', NOW(), 1) 
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag) 
VALUES ('Old Mill High School', '600 Patriot Lane', 'Millersville', 'Maryland', '21108', 'Anne Arundel', '410-969-9010', NOW(), 'CIDM-11390', 'CIDM-11390', NOW(), 1) 
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag) 
VALUES ('Severna Park High School', '60 Robinson Road', 'Severna Park', 'Maryland', '21146', 'Anne Arundel', '410-544-0900', NOW(), 'CIDM-11390', 'CIDM-11390', NOW(), 1) 
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag) 
VALUES ('Severn Run High School', '8065 New Cut Road', 'Severn', 'Maryland', '21144', 'Anne Arundel', '410-553-2717', NOW(), 'CIDM-11390', 'CIDM-11390', NOW(), 1) 
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag) 
VALUES ('South River High School', '201 Central Avenue', 'East Edgewater', 'Maryland', '21037', 'Anne Arundel', '410-956-5600', NOW(), 'CIDM-11390', 'CIDM-11390', NOW(), 1) 
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag) 
VALUES ('Southern High School', '4400 Solomons Island Road', 'Harwood', 'Maryland', '20776', 'Anne Arundel', '410-867-7100', NOW(), 'CIDM-11390', 'CIDM-11390', NOW(), 1) 
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag) 
VALUES ('Annapolis Middle School', '1399 Forest Drive', 'Annapolis', 'Maryland', '21403', 'Anne Arundel', '410-267-8658', NOW(), 'CIDM-11390', 'CIDM-11390', NOW(), 1) 
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag) VALUES ('Arundel Middle School', '1179 Hammond Lane', 'Odenton', 'Maryland', '21113', 'Anne Arundel', '410-674-6905', NOW(), 'CIDM-11390', 'CIDM-11390', NOW(), 1) 
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag) VALUES ('Brooklyn Park Middle School', '200 Hammonds Lane', 'Baltimore', 'Maryland', '21225', 'Anne Arundel', '410-636-2967', NOW(), 'CIDM-11390', 'CIDM-11390', NOW(), 1) 
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag) VALUES ('Central Middle School', '221 Central Avenue East', 'Edgwater', 'Maryland', '21037', 'Anne Arundel', '410-956-5800', NOW(), 'CIDM-11390', 'CIDM-11390', NOW(), 1) 
ON CONFLICT ("schoolname", address1) DO NOTHING;

INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag) VALUES ('Chesapeake Bay Middle School', '4804 Mountain Road', 'Pasadena', 'Maryland', '21122', 'Anne Arundel', '410-437-2400', NOW(), 'CIDM-11390', 'CIDM-11390', NOW(), 1) ON CONFLICT ("schoolname", address1) DO NOTHING;
INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag) VALUES ('Corkran Middle School', '7600 Quarterfield Road', 'Glen Burnie', 'Maryland', '21061', 'Anne Arundel', '410-787-6350', NOW(), 'CIDM-11390', 'CIDM-11390', NOW(), 1) ON CONFLICT ("schoolname", address1) DO NOTHING;
INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag) VALUES ('Crofton Middle School', '2301 Davidsonville Road', 'Gambrills', 'Maryland', '21054', 'Anne Arundel', '410-793-0280', NOW(), 'CIDM-11390', 'CIDM-11390', NOW(), 1) ON CONFLICT ("schoolname", address1) DO NOTHING;
INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag) VALUES ('Lindale Middle School', '415 Andover Road', 'Linthicum Heights', 'Maryland', '21090', 'Anne Arundel', '410-691-4344', NOW(), 'CIDM-11390', 'CIDM-11390', NOW(), 1) ON CONFLICT ("schoolname", address1) DO NOTHING;
INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag) VALUES ('MacArthur Middle School', '3500 Rockenbach Road', 'Fort George G Meade', 'Maryland', '20755', 'Anne Arundel', '410-674-0032', NOW(), 'CIDM-11390', 'CIDM-11390', NOW(), 1) ON CONFLICT ("schoolname", address1) DO NOTHING;
INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag) VALUES ('Magothy River Middle School', '241 Peninsula Farm Road', 'Arnold', 'Maryland', '21012', 'Anne Arundel', '410-544-0926', NOW(), 'CIDM-11390', 'CIDM-11390', NOW(), 1) ON CONFLICT ("schoolname", address1) DO NOTHING;
INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag) VALUES ('Marley Middle School', '10 Davis Court', 'Glen Burnie', 'Maryland', '21060', 'Anne Arundel', '410-424-3220', NOW(), 'CIDM-11390', 'CIDM-11390', NOW(), 1) ON CONFLICT ("schoolname", address1) DO NOTHING;
INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag) VALUES ('Meade Middle School', '1103 26th Street', 'Fort George G Meade', 'Maryland', '20755', 'Anne Arundel', '410-305-2400', NOW(), 'CIDM-11390', 'CIDM-11390', NOW(), 1) ON CONFLICT ("schoolname", address1) DO NOTHING;
INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag) VALUES ('Northeast Middle School', '7922 Outing Avenue', 'Pasadena', 'Maryland', '21122', 'Anne Arundel', '410-437-5512', NOW(), 'CIDM-11390', 'CIDM-11390', NOW(), 1) ON CONFLICT ("schoolname", address1) DO NOTHING;
INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag) VALUES ('Old Mill Middle School North', '610 Patriot Lane', 'Millersville', 'Maryland', '21108', 'Anne Arundel', '410-969-5950', NOW(), 'CIDM-11390', 'CIDM-11390', NOW(), 1) ON CONFLICT ("schoolname", address1) DO NOTHING;
INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag) VALUES ('Old Mill Middle School South', '430 Old Mill Road', 'Millersville', 'Maryland', '21108', 'Anne Arundel', '410-923-5250', NOW(), 'CIDM-11390', 'CIDM-11390', NOW(), 1) ON CONFLICT ("schoolname", address1) DO NOTHING;
INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag) VALUES ('Severn River Middle School', '241 Peninsula Farm Road', 'Arnold', 'Maryland', '21012', 'Anne Arundel', '410-544-0922', NOW(), 'CIDM-11390', 'CIDM-11390', NOW(), 1) ON CONFLICT ("schoolname", address1) DO NOTHING;
INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag) VALUES ('Southern Middle School', '5235 Solomons Island Road', 'Lothian', 'Maryland', '20711', 'Anne Arundel', '410-867-0050', NOW(), 'CIDM-11390', 'CIDM-11390', NOW(), 1) ON CONFLICT ("schoolname", address1) DO NOTHING;
INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag) VALUES ('Wiley H. Bates Middle School', '701 Chase Street', 'Lothian', 'Maryland', '21401', 'Anne Arundel', '410-263-0270', NOW(), 'CIDM-11390', 'CIDM-11390', NOW(), 1) ON CONFLICT ("schoolname", address1) DO NOTHING;
INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag) VALUES ('Appeal Elementary School', '11655 H.G. Trueman Road', 'Lusby', 'Maryland', '20657', 'Calvert', '443-550-9670', NOW(), 'CIDM-11390', 'CIDM-11390', NOW(), 1) ON CONFLICT ("schoolname", address1) DO NOTHING;
INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag) VALUES ('Calvert Country School', '1350 Dares Beach Road', 'Prince Frederick', 'Maryland', '20678', 'Calvert', '443-550-9910', NOW(), 'CIDM-11390', 'CIDM-11390', NOW(), 1) ON CONFLICT ("schoolname", address1) DO NOTHING;
INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag) VALUES ('Barstow Elementary School', '295 J.W. Williams Road', 'Prince Frederick', 'Maryland', '20678', 'Calvert', '443-550-9510', NOW(), 'CIDM-11390', 'CIDM-11390', NOW(), 1) ON CONFLICT ("schoolname", address1) DO NOTHING;
INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag) VALUES ('Beach Elementary School', '7900 Old Bayside Road', 'Chesapeake Beach', 'Maryland', '20732', 'Calvert', '443-550-9520', NOW(), 'CIDM-11390', 'CIDM-11390', NOW(), 1) ON CONFLICT ("schoolname", address1) DO NOTHING;
INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag) VALUES ('Calvert Elementary School', '1450 Dares Beach Road', 'Prince Frederick', 'Maryland', '20678', 'Calvert', '443-550-9550', NOW(), 'CIDM-11390', 'CIDM-11390', NOW(), 1) ON CONFLICT ("schoolname", address1) DO NOTHING;
INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag) VALUES ('Dowell Elementary School', '12680 H.G. Trueman Road', 'Lusby', 'Maryland', '20657', 'Calvert', '443-550-9480', NOW(), 'CIDM-11390', 'CIDM-11390', NOW(), 1) ON CONFLICT ("schoolname", address1) DO NOTHING;
INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag) VALUES ('Huntington Elementary School', '4345 Huntingtown Road', 'Huntingtown', 'Maryland', '20639', 'Calvert', '443-550-9360', NOW(), 'CIDM-11390', 'CIDM-11390', NOW(), 1) ON CONFLICT ("schoolname", address1) DO NOTHING;
INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag) VALUES ('Mount Harmony Elementary School', '900 West Mt. Harmony Road', 'Owings', 'Maryland', '20736', 'Calvert', '443-550-9620', NOW(), 'CIDM-11390', 'CIDM-11390', NOW(), 1) ON CONFLICT ("schoolname", address1) DO NOTHING;
INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag) VALUES ('Mutual Elementary School', '1455 Ball Road', 'Port Republic', 'Maryland', '20676', 'Calvert', '443-550-9650', NOW(), 'CIDM-11390', 'CIDM-11390', NOW(), 1) ON CONFLICT ("schoolname", address1) DO NOTHING;
INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag) VALUES ('Plum Point Elementary School', '1245 Plum Point Road', 'Huntingtown', 'Maryland', '20639', 'Calvert', '443-550-9730', NOW(), 'CIDM-11390', 'CIDM-11390', NOW(), 1) ON CONFLICT ("schoolname", address1) DO NOTHING;
INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag) VALUES ('St. Leonard Elementary School', '5370 St. Leonard Road', 'St. Leonard', 'Maryland', '20685', 'Calvert', '443-550-9760', NOW(), 'CIDM-11390', 'CIDM-11390', NOW(), 1) ON CONFLICT ("schoolname", address1) DO NOTHING;
INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag) VALUES ('Sunderland Elementary School', '150 Clyde Jones Road', 'Sunderland', 'Maryland', '20689', 'Calvert', '443-550-9390', NOW(), 'CIDM-11390', 'CIDM-11390', NOW(), 1) ON CONFLICT ("schoolname", address1) DO NOTHING;
INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag) VALUES ('Windy Hill Elementary School', '9550 Boyd’s Turn Road', 'Owings', 'Maryland', '20736', 'Calvert', '443-550-9790', NOW(), 'CIDM-11390', 'CIDM-11390', NOW(), 1) ON CONFLICT ("schoolname", address1) DO NOTHING;
INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag) VALUES ('Patuxent Appeal Elementary School (Patuxent Campus)', '35 Appeal Lane', 'Lusby', 'Maryland', '20657', 'Calvert', '443-550-9710', NOW(), 'CIDM-11390', 'CIDM-11390', NOW(), 1) ON CONFLICT ("schoolname", address1) DO NOTHING;
INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag) VALUES ('Calvert Middle School', '655 Chesapeake Boulevard', 'Prince Frederick', 'Maryland', '20678', 'Calvert', '443-550-8970', NOW(), 'CIDM-11390', 'CIDM-11390', NOW(), 1) ON CONFLICT ("schoolname", address1) DO NOTHING;
INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag) VALUES ('Mill Creek Middle School', '12200 Southern Connector Boulevard', 'Lusby', 'Maryland', '20657', 'Calvert', '443-550-9190', NOW(), 'CIDM-11390', 'CIDM-11390', NOW(), 1) ON CONFLICT ("schoolname", address1) DO NOTHING;
INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag) VALUES ('Northern Middle School', '2954 Chaneyville Road', 'Owings', 'Maryland', '20736', 'Calvert', '443-550-9230', NOW(), 'CIDM-11390', 'CIDM-11390', NOW(), 1) ON CONFLICT ("schoolname", address1) DO NOTHING;
INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag) VALUES ('Plum Point Middle School', '1475 Plum Point Road', 'Huntingtown', 'Maryland', '20639', 'Calvert', '443-550-9170', NOW(), 'CIDM-11390', 'CIDM-11390', NOW(), 1) ON CONFLICT ("schoolname", address1) DO NOTHING;
INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag) VALUES ('Southern Middle School', '9615 H.G. Trueman Road', 'Lusby', 'Maryland', '20657', 'Calvert', '443-550-9250', NOW(), 'CIDM-11390', 'CIDM-11390', NOW(), 1) ON CONFLICT ("schoolname", address1) DO NOTHING;
INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag) VALUES ('Windy Hill Middle School', '9560 Boyd’s Turn Road', 'Owings', 'Maryland', '20736', 'Calvert', '443-550-9310', NOW(), 'CIDM-11390', 'CIDM-11390', NOW(), 1) ON CONFLICT ("schoolname", address1) DO NOTHING;
INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag) VALUES ('Calvert High School', '600 Dares Beach Road', 'Prince Frederick', 'Maryland', '20678', 'Calvert', '443-550-8880', NOW(), 'CIDM-11390', 'CIDM-11390', NOW(), 1) ON CONFLICT ("schoolname", address1) DO NOTHING;
INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag) VALUES ('Huntingtown High School', '4125 Solomons Island Road', 'Huntingtown', 'Maryland', '20639', 'Calvert', '443-550-8810', NOW(), 'CIDM-11390', 'CIDM-11390', NOW(), 1) ON CONFLICT ("schoolname", address1) DO NOTHING;
INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag) VALUES ('Northern High School', '2950 Chaneyville Road', 'Owings', 'Maryland', '20736', 'Calvert', '443-550-8950', NOW(), 'CIDM-11390', 'CIDM-11390', NOW(), 1) ON CONFLICT ("schoolname", address1) DO NOTHING;
INSERT INTO cjams.schoollistreference ("schoolname", address1, city, state, zipcode, county, phoneno, insertedon, insertedby, updatedby, updatedon, activeflag) VALUES ('Patuxent High School', '12485 Southern Connector Boulevard', 'Lusby', 'Maryland', '20657', 'Calvert', '443-550-8840', NOW(), 'CIDM-11390', 'CIDM-11390', NOW(), 1) ON CONFLICT ("schoolname", address1) DO NOTHING;

