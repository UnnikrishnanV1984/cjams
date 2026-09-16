
/*
   Issue Description: CDM-19192
   Category/ Module  : Case Type issue fix
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


--servicerequest
update caseassignment set objecttypekey = 'adoptioncase', updatedon = now(), updatedby = 'CDM-19192' where caseassignmentid = '800302db-274f-4855-8661-f739b38daaa8'
