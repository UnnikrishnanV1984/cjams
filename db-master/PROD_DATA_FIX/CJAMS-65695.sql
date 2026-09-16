/*
   Issue Description: CJAMS-65695
   Category/ Module  : personprogramarea
   Root cause:Requested to remove CJAMS PID 204769331 ,204769327 and add program assignment for 204769312
   Fix type: Data fix is done remove CJAMS PID 204769331 ,204769327 and add program assignment for 204769312
   Pull request# for code fix: It's a data fix
   Reason why no related code fix:  
   
*/


update actor
set activeflag = 0, updatedby = 'CJAMS-65695', updatedon = now()
where personid in ('8c1e99c8-2b73-406b-8b93-b7fd743710d8','5a4851c8-8bf1-45e4-990d-3b387d6d0028') and actorid in ('19b3f482-4a14-40e7-be65-74f2fd6d23df','822618d1-32e4-44fa-bd6c-90bfcf01805f')
and activeflag = 1;


update intakeservicerequestactor    
set activeflag = 0, updatedby = 'CJAMS-65695', updatedon = now()
where personid in ('8c1e99c8-2b73-406b-8b93-b7fd743710d8','5a4851c8-8bf1-45e4-990d-3b387d6d0028')
and intakeservicerequestactorid in('5b7d7df2-760a-4232-a919-b5eeb568d76c','61bb536d-2f5b-4300-8c58-2baae1e574f5') and activeflag = 1;


update actorrelationship set activeflag = 0, updatedby = 'CJAMS-65695', updatedon = now() 
where intakeservicerequestactorid in (  
    select intakeservicerequestactorid 
    from intakeservicerequestactor
    where personid in ('8c1e99c8-2b73-406b-8b93-b7fd743710d8','5a4851c8-8bf1-45e4-990d-3b387d6d0028') )  
and activeflag = 1; 


update personrole
set activeflag = 0,
    updatedby = 'CJAMS-65695',
    updatedon = now()
where personroleid in ('142ad3a2-b510-4be3-b712-6b9560099caf','786ac743-1b64-439f-bf0a-00061fa7df89') and activeflag = 1;

update personroletype
set activeflag = 0,
    updatedby = 'CJAMS-65695',
    updatedon = now()
where personroletypeid in ('92290db6-a750-4cc7-a954-ea04f808e32d','c8442847-5b63-4f17-aa26-b4b3fdd66f72') and activeflag = 1;

delete from cjams.personprogramarea where updatedby='CJAMS-65695' and personid='39c8dcd2-cf61-4e45-9ba2-0bdff96eafa6';

INSERT INTO cjams.personprogramarea
(personprogramid, personid, startdate, enddate, insertedon, insertedby, updatedon, updatedby, activeflag, datavalidflag, clientmergeid, endreasonkey, ifpsatriskflag, old_id, programkey, subprogramkey, objecttypekey, objectid, entityid, alternateid, datatransferflag, datasentdate, etl_userid, etl_load_date, sourcetype)
VALUES(gen_random_uuid(), '39c8dcd2-cf61-4e45-9ba2-0bdff96eafa6', '2026-03-12 00:00:00.000', NULL, now(), 'CJAMS-65695', now(), 'CJAMS-65695', 1, NULL, NULL, NULL, NULL, NULL, 'CPS', 'AR', 'servicerequest', 'b7da2d31-1eb3-4264-8018-9da3c3deeb80', '261023593980', NULL, NULL, NULL, NULL, NULL, 'CW');