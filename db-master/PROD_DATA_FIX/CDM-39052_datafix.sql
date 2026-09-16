/*
   Issue Description: CDM-39052
   Category/ Module  : payments
   Root cause: Service auth approved, not showing to pay
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update routing set activeflag =1, updatedby='CDM-39052', updatedon=now()
where routingid = 'c443fa78-f7b9-409b-8457-2be4dc65a7ab' and objectid = '3153664'
and eventcode  in ( 'PCAUTHR', 'PCAUTH' ) and activeflag =0;