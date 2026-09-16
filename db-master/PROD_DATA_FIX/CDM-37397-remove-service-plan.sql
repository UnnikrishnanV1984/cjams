/* Issue Description:CDM-37397 - unable to delete service plan created in error
   Category/ Module  :  Services
   Root cause: User requested to remove the service plan
   Resolution: Provided data fix to remove service plan by setting activeflag to 0
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 

*/

select * from serviceplan where serviceplanid = 'a303d91d-1f77-44ac-b8e6-a170b06a2e5e';


update serviceplan set activeflag ='0', updatedby ='CDM-37397', updatedon =now()  where serviceplanid='a303d91d-1f77-44ac-b8e6-a170b06a2e5e';