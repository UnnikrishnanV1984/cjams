/*
   Issue Description: CDM-28107 
   Category/ Module  : Safe-C Deletion
   Root cause: 221030015878:There is a safe-c in draft form that needs to be deleted.
   Pull request# for code fix: It's a data fix
   Reason why no related code fix:  
   
*/

update assessment set activeflag = 0, updatedby = 'CDM-28107', updatedon = now() where assessmentid = '8adc4884-701a-4905-9aa1-2660a00dfae1';