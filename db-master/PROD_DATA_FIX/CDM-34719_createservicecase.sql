-- CDM-34719-Incorrect case connected to referral
-- Issue Description: Disconnect - 3305392 with the CPS - 231020878040 and connect to other Service case 3302372
-- Need data fix to Disconnect - 3305392 with the CPS - 231020878040 and connect to other Service case 3302372.
-- Resolution: Updated the servicecaseid to null in intakeservicerequest and create existing servicecase 
-- Category/ Module: Case Management
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A


update 	intakeservicerequest 
set		servicecaseid = NULL , updatedby = 'CDM-34719', updatedon = now()
WHERE 	servicerequestnumber = '231020878040' and activeflag = 1;

select * from createservicecase('978068a0-8c2e-4b17-ac56-8cc487b0c25a', '5626f603-bf9d-4f52-9f31-cc2cb503d5c3',0,'1f5d2877-a717-4eb7-8ad0-42fa47da39b2','intake','IHM');

-- update servicecasedisposition                     
-- set statusdate = '2023-10-02 09:23:00', effectivedate = '2023-10-02 09:23:00'
-- where servicecaseid = ( select servicecaseid
--                             from intakeservicerequest
--                         where intakeserviceid  ='978068a0-8c2e-4b17-ac56-8cc487b0c25a'
--                      ) and intakeserreqstatustypekey = 'Open' and "comments" = 'Case Reopened';

INSERT INTO cjams.caseassignment
(fromworkeridno, toworkeridno, insertedby, updatedby, insertedon, updatedon, objecttypekey, objectid, responsibilitytypekey, activeflag, startdate, enddate, fromteamid, toteamid, remarks, statustypekey, fromldssid, toldssid, assignmenttype, fk_id, assigndate)
VALUES('1f5d2877-a717-4eb7-8ad0-42fa47da39b2', '4002cf57-effe-4c32-8619-d679cdc7acf7', '1f5d2877-a717-4eb7-8ad0-42fa47da39b2', '1f5d2877-a717-4eb7-8ad0-42fa47da39b2', now(), now(), 'servicecase', '5626f603-bf9d-4f52-9f31-cc2cb503d5c3', 'family', 1, now(), NULL, 'abb1f2db-e34f-4e98-92c1-99e9749f2239', '07c4e2d4-bad1-4da1-8e54-6a03a987307f', NULL, NULL, '34457960-811a-4d35-a416-b8941d6974cc', '34457960-811a-4d35-a416-b8941d6974cc', 'W', NULL, now());

