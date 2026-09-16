/*
   Issue Description: CDM-26123
   Category/ Module  : Deleting duplicate assignments
   Root cause:CJAMS created duplicate program assignment again
   Pull request# for code fix: It's a data fix
   Reason why no related code fix:  
   
*/

update caseassignment set activeflag = 0, updatedon = now(), updatedby = 'CDM-27548' where caseassignmentid='18b4b8e1-ce14-4bb9-83c4-34d7459443f7';