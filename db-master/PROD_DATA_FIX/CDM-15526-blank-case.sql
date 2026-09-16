/*
   Issue Description: CDM-17468
   Category/ Module  :  Blank case
   Root cause: user has nothing to approve as case in blank
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update servicecase set activeflag =0 , updatedby = 'CDM-15526' where servicecaseid='5ffa18ba-cc49-4bf6-a547-ef321719b140';

