/*
   Issue Description: CDM-37203
   Category/ Module  :  create service case
   Root cause: Screened in Service Case Cannot be Found
   Pull request# for code fix: na
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
-- Created a new servicecase as no existing service case connected and case assignment done as mentioned

select * from cjams.createservicecase('5b54a158-48ae-4315-9992-0715455014d8','',1,'f758b860-0a83-4aac-8157-87267159abcf','ASSGN','CDM-37203');

INSERT INTO cjams.caseassignment
(caseassignmentid, eventidno_fk, eventdttmkey_fk, fromworkeridno, fromsupervisoridno, fromofficecode, toworkeridno, tosupervisoridno, toofficecode, caseassigncode, effectivedate,
effectivetime, frombizunitidno, tobizunitidno, old_id, foldergroupindc, cmfldrgrpasgnkey, insertedby, updatedby, insertedon, updatedon, objecttypekey, objectid, responsibilitytypekey, activeflag,
startdate, enddate, fromteamid, toteamid, remarks, statustypekey, fromldssid, toldssid, assignmenttype, fk_id, assigndate, isrestricted, assigndescription, summary, isnew, expungementflag, 
entityopendate, etl_userid, etl_load_date, servicetype, transferreason, communicationtype)
VALUES('2179d956-1d30-4e3c-ab52-723ababa5bc8'::uuid, '63b267a4-051e-4f8d-8f57-c55abbbae164'::uuid, NULL, 'f758b860-0a83-4aac-8157-87267159abcf', NULL, NULL, 'bd2be887-3873-4ff2-b6a9-8bafa585aba0',
NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'f758b860-0a83-4aac-8157-87267159abcf', 'CDM-37203', '2024-02-12 05:00:00.000', now(), 'servicecase',
(select servicecaseid from intakeservicerequest where intakeserviceid='5b54a158-48ae-4315-9992-0715455014d8'), 'family', 1, '2024-02-12 05:00:00.000', NULL, '1be296ef-d018-4c25-ad8a-9f5070f5b115'::uuid, 'af69904f-dfd3-4793-9f07-d186f7760cb8'::uuid, '', NULL,
'f5214cb2-953e-41a9-a4ad-71341501e2ad'::uuid, 'f5214cb2-953e-41a9-a4ad-71341501e2ad'::uuid, 'U', NULL,'2024-02-12 05:00:00.000', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);