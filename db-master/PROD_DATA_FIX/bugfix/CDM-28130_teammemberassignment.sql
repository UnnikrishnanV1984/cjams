/*
   Issue Description: CDM-28130
   Category/ Module  : User Management
   Pull request# for code fix: 
   Reason why no related code fix: Fix should be done from corticon 
   Status of the code fix if already submitted and expected prod fix date: 
*/

UPDATE cjams.teammemberassignment
SET activeflag=0, updatedby='CDM-28130', updatedon=now()
WHERE teammemberassignmentid='9c615b8e-fd5b-41b2-b4a1-208affdd3ddf' and securityusersid='994fa3e0-e397-4920-ac1d-69911cce9055';

UPDATE cjams.teammember
SET activeflag=0, updatedby='CDM-28130', updatedon=now()
WHERE teammemberid='07359cdf-dd12-4dc6-97d6-f9867972d36c';

UPDATE cjams.userprofile
SET  updatedby='CDM-28130', updatedon=now(), teamtypekey='AS'
WHERE securityusersid='994fa3e0-e397-4920-ac1d-69911cce9055' and email='ben.bernard@maryland.gov';

UPDATE cjams.rolemapping
SET activeflag=0, updatedby='CDM-28130', updatedon=now()
WHERE id=100680340 and principalid='14544' and roleid=71 and teamtypekey = 'CW';
