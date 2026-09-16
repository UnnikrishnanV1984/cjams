/*
   Issue Description: CDM-29512-missing-perm-plan-to-approve
   Category/ Module  : CDM
   Pull request# for code fix: 
   Reason why no related code fix: User wants a data fix to close the case
   Status of the code fix if already submitted and expected prod fix date: 

*/

update routing set activeflag = 0,updatedby='CDM-29512', updatedon=now() where 
routingid
in ('783de85d-ce99-4d07-a366-074b4f6d23c8','49eee6fc-89de-4109-8d83-05418340f28e');