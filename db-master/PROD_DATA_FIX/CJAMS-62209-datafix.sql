/*
Issue Description: CJAMS-62209  antoneina.goines3@maryland.gov
Category/Module: User/ Roles
Root cause: This is a know sailpoint issue and data fix is needed to resolve the roles.
Datafix to remove case worker and make case management specialist as the primary role for the user
Fix provided: Data fix has been done to update the roles in teammember and user resource tables.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix:It was a known sailpoint integration issue and data fix is needed to resolve it.
*/


update rolemapping 
 set roleid = 135, 
     updatedby = 'CJAMS-62209',
     updatedon = now()
where principalid = '46424'
 and roleid = 71;

update userresource
 set activeflag = 0,
     updatedby = 'CJAMS-62209',
     updatedon = now()
where userid = '46424'
 and activeflag = 1;

update teammember 
 set roletypekey = 'CWCMSP',
     updatedby = 'CJAMS-62209',
     updatedon = now()
 where teammemberid = '6814941c-0e50-41fa-83d6-27723116c055'
  and teamid = 'a3e7e955-0e92-4e92-b4a8-0a51ee45841d'
  and activeflag = 1;

