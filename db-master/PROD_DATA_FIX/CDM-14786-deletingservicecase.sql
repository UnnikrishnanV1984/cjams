 /*
  Issue Description: CDM-14786
   Category/ Module  :  Removing Service case
   Root cause: user asked to update it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update servicecase set activeflag = 0, updatedby = 'CDM-14786', updatedon = now() where servicecasenumber = '211030009158';