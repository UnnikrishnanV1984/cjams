/*
   Issue Description: CDM-32737
   Category/ Module  :user roles
   Root cause: user requested to remove the supervisor roles of a caseworker who was a supervisor before , but not now
   Pull request# for code fix: 
   Reason why no related code fix: 
   requested a data fix to resolve:
*/

 delete from cjams.rolemapping  where principalid ='4135' and roleid ='71' and insertedby= 'CDM-32737';

 
INSERT INTO cjams.rolemapping
( principaltype, principalid, roleid, activeflag, insertedby, updatedby, insertedon, updatedon, old_id, teamtypekey)
VALUES('USER', '4135', 71, 1, 'CDM-32737', 'CDM-32737', now(), now(), '', 'CW');


update rolemapping set activeflag =0,updatedby='CDM-32737',updatedon =now() where principalid ='4135' and roleid =36 and activeflag = 1 and teamtypekey ='CW';



update teammember set roletypekey = 'CWCW',updatedby='CDM-32737',updatedon =now() where teammemberid ='988abd7a-d1aa-41e6-ac61-48260fa50b7d' ;

update userresource set activeflag =0 ,updatedby='CDM-32737',updatedon =now() where userresourceid ='0d043f3e-c156-451d-8696-05fde3a528c8' and userid ='4135';