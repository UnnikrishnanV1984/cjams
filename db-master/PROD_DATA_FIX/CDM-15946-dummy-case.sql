/*
   Issue Description: CDM-15946
   Category/ Module  : dummy case
   Root cause: user wants to remove dummy case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update servicecase set activeflag =0, updatedby = 'CDM-15946', updatedon = now() where servicecasenumber = 211030008979 and activeflag =1;

update servicecasedisposition set activeflag =0, updatedby = 'CDM-15946', updatedon = now() where servicecasedispositionid ='4ea6e7d8-5462-4220-ace6-6352930113d9' and activeflag =1;
