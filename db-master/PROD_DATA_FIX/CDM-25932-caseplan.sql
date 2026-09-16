/*
  Issue Description:  CDM-25932
   Category/ Module  :  Approval inbox 
   Root cause: wrongly created
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
   
*/

-- caseworker submitted to another supervisor , user requeted to change supervisor

update routing set tosecurityusersid ='4b8d30e9-1b01-47cb-9cdf-9308451bf98a', updatedby ='CDM-25932', updatedon = now()

where routingid in ('4527b03b-7f9b-45a6-a4fb-1b8870dc38f6','520060b9-457a-435f-bc59-73948d0416ca');

