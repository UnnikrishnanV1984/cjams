-- case CW2954698
UPDATE assessment SET submissiondata = REPLACE (submissiondata::TEXT, 'Shelley Sexton', 'Kelly Glotfelty')::jsonb 
WHERE assessmentid =  'a18bc22f-5da2-4cd8-86c9-bf89938568bd';


-- CDM-490 2020062016289
UPDATE progressnote SET activeflag = 0, updatedon = now(), updatedby = 'CDM-490' 
WHERE entitytypeid = '883e83e5-c3d0-41ca-9161-437bf7200cb1' 
and (insertedon = '2020-04-22 13:53:42' OR  insertedon = '2020-04-22 13:53:41' ) 
AND progressnoteid <> '0ad460a8-91f0-4e64-9c69-e9a2b0c1f037' ;

--update mdm id

UPDATE personidentifier pid SET personidentifiervalue = 'MDT-125337896', updatedon = now() WHERE 
personidentifiervalue = 'MDT-132014198' AND pid.personidentifiertypekey = 'MDM_ID';

--CDM-475

UPDATE permanencyplan SET activeflag = 0, updatedby = 'CDM-475', updatedon = now() WHERE 
servicecaseid = '90a4296a-d106-4b7b-a0f1-54252d9b7bff' AND trunc(insertedon) = '2020-04-21';

--CDM-503
UPDATE person SET activeflag = 1, updatedby = 'CDM-503', updatedon = now() WHERE 
cisclientid = '453044264' AND NOT EXISTS (SELECT 1 FROM intakeservicerequestactor ia, person p 
WHERE p.cisclientid = '453044264' AND p.personid = ia.personid AND ia.activeflag = 1 );


-- CDM-399

UPDATE intakeservicerequestactor SET activeflag = 1, updatedby = 'CDM-399', updatedon = now() WHERE 
intakeservicerequestactorid = 'a6c13e3f-caa1-48fa-84a5-23f5cd565727' AND activeflag = 0 ;