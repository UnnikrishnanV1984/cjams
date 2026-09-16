
--CDM-534

update intakedastatus SET status = 11, updatedon = now(), updatedby = 'CDM-534' WHERE 
intakenumber IN ('CW9876940', 'CW10098643', 'CW10104498', 'CW10199290') AND activeflag = 1;

update intakedastaging SET activeflag = 0, updatedon = now(), updatedby = 'CDM-534' WHERE 
intakenumber= 'CW10199290'  AND activeflag = 1;

update intakedastaging SET activeflag = 0, updatedon = now(), updatedby = 'CDM-534' WHERE 
intakenumber= 'CW9876940'  AND activeflag = 1;

--CDM-574

UPDATE intakeservicerequest SET actiontype = NULL, intakeservicerequestclassid = '00000000-0000-0000-0000-000000000000',
intakeserreqstatustypeid = '642f18b0-ef6e-4d4b-9871-acc0734f3f5a', activeflag = 1 WHERE 
servicerequestnumber = '20200115017872' AND activeflag = 1 AND actiontype = 'AR' ;

--CDM-590
UPDATE intakeservicerequest SET actiontype = NULL, intakeservicerequestclassid = '00000000-0000-0000-0000-000000000000',
intakeserreqstatustypeid = '642f18b0-ef6e-4d4b-9871-acc0734f3f5a', activeflag = 1 WHERE 
servicerequestnumber = '2020043015563' AND activeflag = 1 AND actiontype = 'AR' ;

--CDM-514 uploader name
UPDATE documentproperties SET insertedby = 'faaf72bc-5da7-4caf-9413-7db22babe7af',
updatedby = 'faaf72bc-5da7-4caf-9413-7db22babe7af' WHERE servicecaseid = '31b02cca-9c27-4745-a9a1-d22f6f846d6d' AND 
insertedby = '5c38882f-227a-49ee-b516-b6a87dbc5b0a';

--CDM-511
UPDATE documentproperties SET insertedby = '7119301a-98ab-45f5-9a7d-e6317b8529fb',
updatedby = '7119301a-98ab-45f5-9a7d-e6317b8529fb' WHERE servicecaseid = 'd1457bb7-cd6b-495d-9d6a-55739277b576' 
AND insertedby = 'be997f35-227d-417f-a4d5-2df232639a24' ;

--CDM-417

UPDATE documentproperties SET insertedby = '8b57303b-06a1-4cd7-908a-3e3e54dda2fe',
updatedby = '8b57303b-06a1-4cd7-908a-3e3e54dda2fe' WHERE servicecaseid = '71f00619-4edc-443d-a64f-d4498bdae138' 
AND insertedby = '750e968a-30e5-4c24-b354-c653d682be59' AND trunc(updatedon) = '2020-04-21'; 

--CDM-589

UPDATE intakeservreqchildremoval SET activeflag = 0, updatedon = now(),
updatedby = 'CDM-589' WHERE intakeservreqchildremovalid = '7ba3d916-68c5-4b5e-af9b-86d07b3768aa';

--CDM-541

UPDATE assessment SET securityusersid = '4ac8b050-0eb5-48a1-933e-6f515ac2f11d', 
insertedby = '4ac8b050-0eb5-48a1-933e-6f515ac2f11d', 
updatedon = now() WHERE
assessmentid = 'a1b2865f-d231-4839-9eaa-d8390ffc353b' 
AND insertedby = '4d98a0c2-3006-4687-914a-72ae28497f68';

update routing SET fromsecurityusersid = '4ac8b050-0eb5-48a1-933e-6f515ac2f11d', updatedon = now()
WHERE routingid = '53d1c4a7-9c72-4a5b-b4ac-60bf704b9a21' ;

update routing SET tosecurityusersid = '4ac8b050-0eb5-48a1-933e-6f515ac2f11d', updatedon = now()
WHERE routingid = '690a8eb1-33cd-4b55-962d-10311c725be2' ;
