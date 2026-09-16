/*
  Issue Description: CJAMS-63470 Kent County - Staff Name Changes
  Category/ Module : Case assignment / My Tasks Dashboard
  Root cause: Two staff members who are in the process of legally changing their names due to getting married.
              New emails have been updated with the sailpoint.
              We need to do a data fix to reassign the case assignments to the new emails
              jessica.jones5@maryland.gov was changed to jessica.jonesinge@maryland.gov
              emma.roth@maryland.gov was changed to emma.brown@maryland.gov
  Fix Provided: Data fix has been done to end date the active case assignments and start the new case assignments from the date the new ID's have been created.
  Regression Impacts: N/A
  Is Code fix needed: No
  Code fix ticket # : N/A
  Reason why no related code fix: User error and data fix needed to resolve it.
*/


-- old name emma.roth@maryland.gov  d6409d68-18d9-4e04-a925-053a99e364dc
-- new name emma.brown@maryland.gov d25c7040-7b9e-4552-9781-b7090864580c


--service case#3266673 Ending  the case assigned to emma.roth@maryland.gov and creating a new record with emma.brown@maryland.gov credentials
update caseassignment
set enddate =now(),
    updatedby = 'CJAMS-63470',
    updatedon = now()
where caseassignmentid = '947dec4b-eb8c-4abb-a363-a52f33870afd';

---Inserting a new insertion record for the active assignment with new user email
INSERT INTO cjams.caseassignment
(caseassignmentid, eventidno_fk, eventdttmkey_fk, fromworkeridno, fromsupervisoridno, fromofficecode, toworkeridno, tosupervisoridno, toofficecode, caseassigncode, effectivedate, effectivetime, frombizunitidno, tobizunitidno, old_id, foldergroupindc, cmfldrgrpasgnkey, insertedby, updatedby, insertedon, updatedon, objecttypekey, objectid, responsibilitytypekey, activeflag, startdate, enddate, fromteamid, toteamid, remarks, statustypekey, fromldssid, toldssid, assignmenttype, fk_id, assigndate, isrestricted, assigndescription, summary, isnew, expungementflag, entityopendate, etl_userid, etl_load_date, servicetype, transferreason, communicationtype)
VALUES(gen_random_uuid(), '3b0ae1af-0c37-4ed6-9cf6-fbbbdbb8954a', NULL, '1a0996aa-442f-4d53-9a61-76c20d6d9d5a', NULL, NULL, 'd25c7040-7b9e-4552-9781-b7090864580c', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '1a0996aa-442f-4d53-9a61-76c20d6d9d5a', 'CJAMS-63470', now(), now(), 'servicecase', 'd220eb10-a6d3-4da3-8e70-d73fc53acff4', 'family', 1, '2023-09-20 11:26:34.000', NULL, 'f57e1f71-bac1-4773-8761-dc3a943fb797', '945a7955-d865-4520-abb0-b908b31db7c8', '', 'ASSGN', '1b7ae41e-e77a-4a1e-a0a3-cda5292cde0b', '1b7ae41e-e77a-4a1e-a0a3-cda5292cde0b', 'U', NULL, '2023-09-20 00:00:00.000', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);

---241030408257	Placement under review
update routing 
set tosecurityusersid = 'd25c7040-7b9e-4552-9781-b7090864580c',
    updatedon = now(),
    updatedby = 'CJAMS-63470'
where routingid = '3948810d-f39c-4801-8e27-df7b087f72f0';

--Updating the fromworkerid for active case assignments
update caseassignment
set fromworkeridno = 'd25c7040-7b9e-4552-9781-b7090864580c',
	updatedby ='CJAMS-63470',
	updatedon = now()
where enddate = null
and fromworkeridno = 'd6409d68-18d9-4e04-a925-053a99e364d'
and activeflag =1;

-- old name jessica.jones5@maryland.gov  97fb5e57-7c92-4534-b6fb-9063b8383e99
-- new name  jessica.jonesinge@maryland.gov 8cd55cc6-c425-4b00-b7ca-1b116c7b1be1

---No active case assignment or routing records available for this user .

