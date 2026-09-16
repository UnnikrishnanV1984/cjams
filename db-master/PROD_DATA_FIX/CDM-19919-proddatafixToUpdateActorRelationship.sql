\/*
   Issue Description: CDM-19919
   Category/ Module  : Prod data fix to update timestamp for IVE
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update actorrelationship set updatedon = now(), updatedby = 'CDM-19199' where  actorrelationshipid = 'e5cc9685-95fc-4618-a936-ec8e9636b97d';
