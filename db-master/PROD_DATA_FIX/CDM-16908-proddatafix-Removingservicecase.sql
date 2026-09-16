/*
   Issue Description: CDM-16908
   Category/ Module  :  
   Root cause: Deleting Service case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update servicecase set activeflag = 0, updatedby = 'CDM-16908', updatedon = now() where servicecasenumber = '211030010914';