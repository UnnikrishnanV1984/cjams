update actor
set activeflag=1, updatedon =now(), updatedby  = 'CDM-11603'
where actorid  = 'e8fc77e2-0d80-4151-ae6f-0bd7a0ead669';

update intakeservicerequestactor
set activeflag=1,isheadofhousehold= true, updatedon =now(), updatedby  = 'CDM-11603'
where actorid  = 'e8fc77e2-0d80-4151-ae6f-0bd7a0ead669';

update personrole
set activeflag=1, ishouseholdmember = 1, updatedon =now(), updatedby  = 'CDM-11603'
where personroleid  = '445e5477-822a-4736-ac3d-66fe4bd2e893';


INSERT INTO cjams.servicecasedisposition
( servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, 
insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date)
VALUES('9bb45aec-ca5f-44c5-a021-015a6cfd1cec', now(), 'Reopen', 'Inprogress', 'Case Re-Opened', now(), 1, 
'CDM-11603', now(), 'CDM-11603', now(), NULL, null, NULL, null);

UPDATE servicecase SET statustypekey ='Open', dispositioncode = 'Open', enddate = null, updatedby = 'CDM-11603',updatedon = now() WHERE servicecaseid = '9bb45aec-ca5f-44c5-a021-015a6cfd1cec';

UPDATE caseassignment SET enddate =null, updatedby = 'CDM-11603',updatedon = now()
WHERE caseassignmentid = '546fbcf9-1a0f-4f72-b056-9ef2ab0580c6' ;
