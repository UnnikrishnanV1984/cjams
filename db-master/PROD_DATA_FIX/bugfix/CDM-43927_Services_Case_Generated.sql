/*
   Issue Description: CDM-43972
   Description: 231030165692:It appears that a number of cases became assigned to supervisor on 1/17/25 and not clear why this occured. 
   This case does not show persons or contact info - case needs to be closed. Supervisor unable to close.
   Category/ Module  : Assignments
   Root cause: User request
   Pull request# for code fix: 
   Reason why no related code fix: 
*/

/*
select insertedon,updatedon,* from routing where objectid = '15032be1-987e-43ff-ac55-b1a71a06fb6b'
select dispositioncode,* from servicecase where servicecasenumber = '231030165692' and activeflag = 1;
select assigndate,* from caseassignment where caseassignmentid = '00b586f7-c6ec-41be-a766-33a9fa3ee319';
*/

--Ending assignment in caseassignment
update caseassignment
set enddate = '2025-01-17 00:00:00', activeflag = 0,updatedby = 'CDM-43927', updatedon = now()
where caseassignmentid = '00b586f7-c6ec-41be-a766-33a9fa3ee319' and activeflag = 1;

--Closing the case in servicecasedisposition
/*
select * from servicecasedisposition where servicecaseid = '15032be1-987e-43ff-ac55-b1a71a06fb6b';
*/

update servicecasedisposition
set intakeserreqstatustypekey = 'Closed', dispositioncode = 'Closed', "comments" = 'Dev Closed', updatedby = 'CDM-43927', updatedon = now()
where servicecasedispositionid = '25a04ba6-ef11-42e6-9564-84f29aaaa5ef' and activeflag = 1;

/*
select dispositioncode , statustypekey , * from servicecase s
where servicecaseid = '15032be1-987e-43ff-ac55-b1a71a06fb6b';
*/

UPDATE cjams.servicecase 
SET statustypekey ='Closed', dispositioncode = 'Closed', updatedby = 'CDM-43927',updatedon = now() 
WHERE servicecaseid = '15032be1-987e-43ff-ac55-b1a71a06fb6b' and activeflag = 1;