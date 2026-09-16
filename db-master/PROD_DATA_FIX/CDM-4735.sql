
-- CDM-4735


UPDATE intakeservicerequestactor SET servicecaseid = NULL, personid = 'de5728e6-212a-4f9d-b4a6-e63e5a2e510e', updatedon =now()
WHERE servicecaseid = '3c5004bc-32a9-41dc-ab43-8f4abef3715a' AND personid = 'c5287929-8424-48de-8a3c-2c071b4dedb2' ;

UPDATE actor SET personid = 'de5728e6-212a-4f9d-b4a6-e63e5a2e510e', updatedon = now(), updatedby = 'CDM-4735'
WHERE actorid IN ('a5e49803-c416-415d-aaaf-f083a390e6c5', '88502d24-f076-4de9-b65e-e6f5cf83184c') 
AND personid = 'c5287929-8424-48de-8a3c-2c071b4dedb2' ;

UPDATE person SET activeflag = 0, updatedon = now(), updatedby = 'CDM-4735' WHERE cjamspid = 200147332 AND activeflag = 1;
