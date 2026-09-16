/* Issue Description:CDM-14052 - Service plan need to remove
   Category/ Module  :  Services
   Root cause: unable to reproduce this
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 

*/


update serviceplan set activeflag ='0', updatedby ='CDM-14052', updatedon =now()  where serviceplanid='e5273211-58c5-421f-acc9-911ef767fc5a';