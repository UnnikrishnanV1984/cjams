
--CDM-8886 Denesa Churchey

UPDATE intakeservicerequestactor SET personid = '91407940-f9cd-44c8-8cce-9eddd09397e6', updatedby = 'CDM-8886', updatedon = now() WHERE 
personid IN ('dcf187b9-fe87-4e37-8693-49cdf1e3fcf3') ;

UPDATE actor SET personid = '91407940-f9cd-44c8-8cce-9eddd09397e6', updatedby = 'CDM-8886', updatedon = now() WHERE 
personid IN ('dcf187b9-fe87-4e37-8693-49cdf1e3fcf3') ;

UPDATE person SET activeflag = 0, updatedby = 'CDM-8886', updatedon = now() WHERE 
personid IN ('dcf187b9-fe87-4e37-8693-49cdf1e3fcf3');


--CDM-8885 Stella Edwards
UPDATE intakeservicerequestactor SET personid = '90a69a2b-bb88-480c-93e2-e1767c8e6ff5', updatedby = 'CDM-8885', updatedon = now() WHERE 
personid IN ('df085aff-2ab9-43be-9093-ae816c85b642') ;

UPDATE actor SET personid = '90a69a2b-bb88-480c-93e2-e1767c8e6ff5', updatedby = 'CDM-8885', updatedon = now() WHERE 
personid IN ('df085aff-2ab9-43be-9093-ae816c85b642') ;

UPDATE person SET activeflag = 0, updatedby = 'CDM-8885', updatedon = now() WHERE 
personid IN ('df085aff-2ab9-43be-9093-ae816c85b642');

UPDATE person SET ssnno='725423439', cisclientid = '413059199', updatedby = 'CDM-8885', updatedon = now() WHERE 
personid IN ('90a69a2b-bb88-480c-93e2-e1767c8e6ff5');

INSERT INTO cjams.personidentifier
(personid, personidentifiertypekey, personidentifiervalue, activeflag, insertedby, insertedon,  effectivedate)
VALUES('90a69a2b-bb88-480c-93e2-e1767c8e6ff5', 'SSN', '725423439', 1, 'CDM-8885', now(), now() ) ;

UPDATE personprogramarea SET personid = '90a69a2b-bb88-480c-93e2-e1767c8e6ff5', updatedby = 'CDM-8885', updatedon = now() WHERE 
personid IN ('df085aff-2ab9-43be-9093-ae816c85b642') ;

--CDM-8883 TAYLOR DENNER


UPDATE person SET ssnno='054846439', updatedby = 'CDM-8883', updatedon = now() WHERE 
personid IN ('801b5e99-14c1-4872-8ec7-955cfc027422');

INSERT INTO cjams.personidentifier
(personid, personidentifiertypekey, personidentifiervalue, activeflag, insertedby, insertedon,  effectivedate)
VALUES('801b5e99-14c1-4872-8ec7-955cfc027422', 'SSN', '054846439', 1, 'CDM-8883', now(), now() ) ;

UPDATE intakeservicerequestactor SET personid = '801b5e99-14c1-4872-8ec7-955cfc027422', updatedby = 'CDM-8883', updatedon = now() WHERE 
personid IN ('f76e0597-c92b-4da5-9a0e-185eea3f2c05') ;

UPDATE actor SET personid = '801b5e99-14c1-4872-8ec7-955cfc027422', updatedby = 'CDM-8883', updatedon = now() WHERE 
personid IN ('f76e0597-c92b-4da5-9a0e-185eea3f2c05') ;

UPDATE person SET activeflag = 0, updatedby = 'CDM-8883', updatedon = now() WHERE 
personid IN ('f76e0597-c92b-4da5-9a0e-185eea3f2c05');

UPDATE personprogramarea SET personid = '801b5e99-14c1-4872-8ec7-955cfc027422', updatedby = 'CDM-8883', updatedon = now() WHERE 
personid IN ('f76e0597-c92b-4da5-9a0e-185eea3f2c05') ;

UPDATE intakeservicerequestactor SET personid = '801b5e99-14c1-4872-8ec7-955cfc027422', updatedby = 'CDM-8883', updatedon = now() WHERE 
personid IN ('ee8a91ef-9727-4a81-81b5-03a45a54a545') ;

UPDATE actor SET personid = '801b5e99-14c1-4872-8ec7-955cfc027422', updatedby = 'CDM-8883', updatedon = now() WHERE 
personid IN ('ee8a91ef-9727-4a81-81b5-03a45a54a545') ;

UPDATE person SET activeflag = 0, updatedby = 'CDM-8883', updatedon = now() WHERE 
personid IN ('ee8a91ef-9727-4a81-81b5-03a45a54a545');

UPDATE personprogramarea SET personid = '801b5e99-14c1-4872-8ec7-955cfc027422', updatedby = 'CDM-8883', updatedon = now() WHERE 
personid IN ('ee8a91ef-9727-4a81-81b5-03a45a54a545') ;

-- Haley Thomas
UPDATE intakeservicerequestactor SET personid = '1e2cbc53-a5c5-4ea8-a7f8-516c879aad49', updatedby = 'CDM-8883', updatedon = now() WHERE 
personid IN ('69088324-0ccc-4e05-bdda-64df42a1dbc6') ;

UPDATE actor SET personid = '1e2cbc53-a5c5-4ea8-a7f8-516c879aad49', updatedby = 'CDM-8883', updatedon = now() WHERE 
personid IN ('69088324-0ccc-4e05-bdda-64df42a1dbc6') ;

UPDATE person SET activeflag = 0, updatedby = 'CDM-8883', updatedon = now() WHERE 
personid IN ('69088324-0ccc-4e05-bdda-64df42a1dbc6');

UPDATE personprogramarea SET personid = '1e2cbc53-a5c5-4ea8-a7f8-516c879aad49', updatedby = 'CDM-8883', updatedon = now() WHERE 
personid IN ('69088324-0ccc-4e05-bdda-64df42a1dbc6') ;
