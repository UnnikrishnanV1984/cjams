/*  Issue Description:CJAMS-62760-service case
  Root cause: User accidentally connected the CPS IR# 251023147208 with a new service case # 251030581986. The CPS IR should connected to case number 3178890.
  Fix provided : Data fix is done to Disconnect the CPS IR# 251023147208 with a new service case # 251030581986.
  and Delete the service case # 251030581986 and Connect the CPS IR# 251023147208 with case number 3178890
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date:  
   Backup before update/ delete:
*/



update intakeservicerequest set servicecaseid = NULL , updatedby = 'CJAMS-62760', updatedon = now()
WHERE    intakenumber = 'I251013379235' and servicecaseid = '1baa3153-cb73-4231-87b9-ce89df4b4165';

update servicecase 
set activeflag =0, 
    updatedby = 'CJAMS-62760', 
    updatedon = now() where servicecaseid = '1baa3153-cb73-4231-87b9-ce89df4b4165';

update caseassignment 
set activeflag = 0, 
    updatedby = 'CJAMS-62760', 
    updatedon = now() 
where 
    objectid = '1baa3153-cb73-4231-87b9-ce89df4b4165' and activeflag = 1 ;

update servicecasedisposition 
set activeflag = 0, 
    updatedby = 'CJAMS-62760', 
    updatedon = now() 
where 
    servicecaseid = '1baa3153-cb73-4231-87b9-ce89df4b4165';
 
  
update routing 
set activeflag = 0, 
    updatedby = 'CJAMS-62760', 
    updatedon = now() 
where 
    objectid = '1baa3153-cb73-4231-87b9-ce89df4b4165' 
    and activeflag = 1;
    
   
update actor 
set activeflag = 0, 
    updatedby = 'CJAMS-62760', 
    updatedon = now() 
    where 
        servicecaseid = '1baa3153-cb73-4231-87b9-ce89df4b4165' 
        and activeflag = 1;
    
update intakeservicerequestactor 
set activeflag = 0, 
    updatedby = 'CJAMS-62760', 
    updatedon = now() 
where 
    servicecaseid = '1baa3153-cb73-4231-87b9-ce89df4b4165' 
    and activeflag = 1;
    
select * from createservicecase('2e5221d3-ff91-4416-a185-ed21f69048bd', 'f03a2ba6-f31a-4888-b561-65360da0f4e0',0,'23fadb6e-6404-4f6a-95c1-efd49225fe34',null,'intake','IHM',null);



INSERT INTO cjams.caseassignment
(caseassignmentid, eventidno_fk, eventdttmkey_fk, fromworkeridno, fromsupervisoridno, fromofficecode, toworkeridno, tosupervisoridno, toofficecode, caseassigncode, effectivedate, effectivetime, frombizunitidno, tobizunitidno, old_id, foldergroupindc, cmfldrgrpasgnkey, insertedby, updatedby, insertedon, updatedon, objecttypekey, objectid, responsibilitytypekey, activeflag, startdate, enddate, fromteamid, toteamid, remarks, statustypekey, fromldssid, toldssid, assignmenttype, fk_id, assigndate, isrestricted, assigndescription, summary, isnew, expungementflag, entityopendate, etl_userid, etl_load_date, servicetype, transferreason, communicationtype)
VALUES('6d39b747-0bb5-4c02-8e2e-924e9a1a6b56', '7bafbfa1-78d9-4be8-9a01-2093f0f891e0'::uuid, NULL, '69b55bdc-1611-4219-bf06-79b4a5f9e5b7', NULL, NULL, '23fadb6e-6404-4f6a-95c1-efd49225fe34', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '69b55bdc-1611-4219-bf06-79b4a5f9e5b7', '69b55bdc-1611-4219-bf06-79b4a5f9e5b7', now(), now(), 'servicecase', 'f03a2ba6-f31a-4888-b561-65360da0f4e0'::uuid, 'family', 1, '2025-10-15 14:41:17.501', NULL, 'f2d84715-e9cd-414c-a9d9-276d2182204b'::uuid, 'f2d84715-e9cd-414c-a9d9-276d2182204b'::uuid, NULL, NULL, '817e0751-1fa8-4c31-8233-8fffd6426235'::uuid, '817e0751-1fa8-4c31-8233-8fffd6426235'::uuid, 'W', NULL, now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)on conflict do nothing;

INSERT INTO cjams.servicecasedisposition
(servicecasedispositionid, servicecaseid, statusdate, intakeserreqstatustypekey, dispositioncode, "comments", effectivedate, activeflag, insertedby, insertedon, updatedby, updatedon, expirationdate, old_id, etl_userid, etl_load_date, supervisorcomment, reopenreasonkey)
VALUES('e46d071e-3057-46f0-a00d-07e7deebcb1c', 'f03a2ba6-f31a-4888-b561-65360da0f4e0', '2025-10-15 14:41:17.501', 'Open', 'Inprogress', 'Case Reopened', now(), 1, '69b55bdc-1611-4219-bf06-79b4a5f9e5b7', now(), '69b55bdc-1611-4219-bf06-79b4a5f9e5b7', now(), NULL, NULL, NULL, NULL, NULL, NULL)on conflict do nothing;