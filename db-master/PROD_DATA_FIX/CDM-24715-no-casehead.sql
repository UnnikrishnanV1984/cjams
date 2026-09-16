/*
   Issue Description: CDM-24715
   Category/ Module  : Prod data fix to remove casehead
   Root cause: User needs to delete
   Pull request# for code fix:6234
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update servicecase set activeflag =0, updatedby = 'CDM-24715', 
updatedon = now() where servicecasenumber = 221030017620 and activeflag =1;

update servicecasedisposition set activeflag =  0, updatedby = 'CDM-24715' , updatedon = now() where servicecaseid ='c537a7d4-70ec-445b-b261-9a5955f301cd'