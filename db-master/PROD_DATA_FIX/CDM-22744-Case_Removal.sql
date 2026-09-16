/*
   Issue Description: CDM-22744
   Category/ Module  : Case Removal
   Root cause: user wants to remove the case which is opened by error
   Pull request# for code fix: 5646
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
update servicecase set activeflag = 0, updatedby = 'CDM-22744', updatedon = now() where servicecasenumber = '221030015901';
update servicecasedisposition set activeflag = 0,updatedby = 'CDM-22744', updatedon = now() where  servicecaseid ='ff36fceb-165c-4ec9-9c62-a876c21db790';

update servicecase set activeflag = 0, updatedby = 'CDM-22744', updatedon = now() where servicecasenumber = '221030015902';
update servicecasedisposition set activeflag = 0,updatedby = 'CDM-22744', updatedon = now() where  servicecaseid ='cb551606-aa43-4a58-a0e4-aaa17418618d';

update servicecase set activeflag = 0, updatedby = 'CDM-22744', updatedon = now() where servicecasenumber = '221030015885';
update servicecasedisposition set activeflag = 0,updatedby = 'CDM-22744', updatedon = now() where  servicecaseid ='f0ca879d-7250-4ec3-b5ee-c4bf19c260ae';
