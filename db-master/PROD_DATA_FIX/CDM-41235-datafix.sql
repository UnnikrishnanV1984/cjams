/*
  Issue Description: CDM-41235
   Category/ Module  :Assignments
   Root cause: As megan.lantz@maryland.gov, cwcaseworker role 
   has been removed in sailpoint. datafix is requested to deactivate the same in cjams db as well.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 1
*/

update rolemapping set activeflag = 0, updatedby = 'CDM-41235', updatedon = now() 
where id='127253524' and activeflag = 1;

update userresource set activeflag = 0, updatedby = 'CDM-41235', updatedon = now() 
where userid='9902' and activeflag=1;

update teammember set roletypekey ='CWIW', updatedby = 'CDM-41235', updatedon = now()
where teammemberid ='31b832e0-7352-406f-a725-5acef97611aa' and activeflag =1;

DELETE FROM cjams.rolemapping
WHERE roleid=41 and updatedby='CDM-41235';

INSERT INTO cjams.rolemapping
( principaltype, principalid, roleid, activeflag, insertedby, updatedby, insertedon, updatedon, old_id, teamtypekey)
VALUES( 'USER', '9902', 41, 1, 'ADMIN', 'CDM-41235', now(), now(), '', 'CW');
