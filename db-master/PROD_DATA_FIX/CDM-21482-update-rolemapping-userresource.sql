/*
  Issue Description: CDM-21482 Supervisor now caseworker still showing supervisor
   Category/ Module  :  user management
   Root cause: Supervisor role is still active and caseworker roles are missing
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 1
*/
-- email:'amanda.richardson@maryland.gov'
-- id : 3987
-- role to be deactivated : CJAMS_CWSUPERVISOR(36), CJAMS_ASSUPERVISOR(34)
-- role added : CJAMS_CWCASEWORKER(71), CJAMS_ASCASEWORKER(38)

update rolemapping set activeflag =0 , updatedby ='CDM-21482',updatedon = now() where principalid = 3987 and activeflag =1 and roleid in (36,34);

update userresource set activeflag =0 , updatedby ='CDM-21482',updatedon = now() where userid = 3987 and activeflag = 1 and roleid in (36,34);

INSERT INTO cjams.rolemapping
(principaltype, principalid, roleid, activeflag, insertedby, updatedby, insertedon, updatedon, old_id, teamtypekey)
VALUES( 'USER', '3987', 71, 1, 'CDM-21482', 'CDM-21482', now(), now(), NULL, 'CW');

INSERT INTO cjams.rolemapping
( principaltype, principalid, roleid, activeflag, insertedby, updatedby, insertedon, updatedon, old_id, teamtypekey)
VALUES('USER', '3987', 38, 1, 'CDM-21482', 'CDM-21482', now(), now(), NULL, 'AS');

update teammember set roletypekey ='CWCW',updatedby='CDM-21482',updatedon= now() where teammemberid = '0812e1c2-e187-4351-9e1d-f36d6be4719f';
update teammember set roletypekey ='ASCW',updatedby='CDM-21482',updatedon= now() where teammemberid = 'f86f3b22-01b9-46e7-aa32-0d13be8bbe1c';