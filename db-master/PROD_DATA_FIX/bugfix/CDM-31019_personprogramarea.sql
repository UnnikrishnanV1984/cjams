/*
   Issue Description: CDM-31019
   Category/ Module  : personprogramarea
   Root cause: n household clients do not have CPS program assignments which are auto generated at case creation. These clients should have a CPS IR program assignment.
   Pull request# for code fix: It's a data fix
   Reason why no related code fix:  
   
*/

	
   INSERT INTO cjams.personprogramarea
(personprogramid, personid, startdate, enddate, insertedon, insertedby, updatedon, updatedby, activeflag, datavalidflag, clientmergeid, endreasonkey, ifpsatriskflag, old_id, programkey, subprogramkey, objecttypekey, objectid, entityid, alternateid, datatransferflag, datasentdate, etl_userid, etl_load_date, sourcetype)
VALUES(gen_random_uuid(), 'bf289de1-bf5d-47d7-b5a0-c002f338ba5e', '2023-04-25 00:00:00.000', NULL, now(), 'CDM-31019', now(), 'CDM-31019', 1, NULL, NULL, NULL, NULL, NULL, 'CPS', 'IR', 'servicerequest', '30847b67-7eba-4132-aa20-9cc7dd6be878', '231020510808', NULL, NULL, NULL, NULL, NULL, 'CW');

 INSERT INTO cjams.personprogramarea
(personprogramid, personid, startdate, enddate, insertedon, insertedby, updatedon, updatedby, activeflag, datavalidflag, clientmergeid, endreasonkey, ifpsatriskflag, old_id, programkey, subprogramkey, objecttypekey, objectid, entityid, alternateid, datatransferflag, datasentdate, etl_userid, etl_load_date, sourcetype)
VALUES(gen_random_uuid(), '0a026f49-5afe-4c22-b7c4-a1b4bfbe5ffc', '2023-04-25 00:00:00.000', NULL, now(), 'CDM-31019', now(), 'CDM-31019', 1, NULL, NULL, NULL, NULL, NULL, 'CPS', 'IR', 'servicerequest', '30847b67-7eba-4132-aa20-9cc7dd6be878', '231020510808', NULL, NULL, NULL, NULL, NULL, 'CW');
