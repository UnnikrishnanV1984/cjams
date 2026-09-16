/*
   Issue Description: CDM-26613
   Category/ Module  : Prod data fix to update correct removal exit reason
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update intakeservreqchildremoval set removalexitreason = 'ADPFIN', updatedon = now(), updatedby = 'CDM-26613'
     where removalid  = '200044';