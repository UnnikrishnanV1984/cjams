/*
   Issue Description: CDM-24065
   Category/ Module  : The case is a complete duplicate, no work has been completed with the family yet, and there is no information that needs merged. The case number that needs deleted is 221030017520
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update servicecase s set activeflag = 0, updatedby = 'CDM-24065', updatedon = now() 
where s.servicecasenumber = '221030017520';