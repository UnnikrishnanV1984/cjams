/*
  Issue Description: CJAMS-69455-Unable-to-Reassign
   Category/ Module  :  Case assignment.
   Root cause: Need dev analysis on why user is able to re-assign child rights in assignment tab
   241040274637:Supervisor is unable to reassign child rights for this adoption case. Worker is leaving the agency but rights to the case are unable to be end-dated. 
  Fix provided :
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date:  
   Backup before update/ delete:
*/


update caseassignment
set assignmenttype = 'W',objecttypekey='adoptioncase', updatedon =now(), updatedby ='CJAMS-69455'
where caseassignmentid = '30601467-1d88-47cf-808b-83f341fa0908' and activeflag = 1;
