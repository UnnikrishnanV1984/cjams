/*
  Issue Description: CDM-31243
  Root cause: case is closed and it is not removed from approval inbox
  Fix provided : Upon pasing the required param to the creteservice able to 
  see the service case in jump server
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date:  
   Backup before update/ delete:
*/

update cjams.routing set activeflag=0, updatedby='CDM-31243' ,updatedon=now() where routingid='0ac22729-a05b-43d1-b271-f25e1d072bae';
