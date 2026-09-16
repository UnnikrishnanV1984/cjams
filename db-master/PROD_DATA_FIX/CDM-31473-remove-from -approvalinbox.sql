/*
  Issue Description:  CDM-31473
   Category/ Module  : Approval Inbox
   Root cause: User requested to delete the pending approval
   Pull request# for code fix: 
   Reason why no related code fix: user requested 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
   
*/

update routing set activeflag =0, updatedby = 'CDM-31473', updatedon =now() where routingid = '0ac22729-a05b-43d1-b271-f25e1d072bae';

update routing set activeflag =0, updatedby = 'CDM-31473', updatedon =now() where routingid = '8ac91b8c-04b2-403b-b4d4-9f16aeb4c18d';