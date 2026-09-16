/*
   Issue Description: Re-Route Service log to all Directors
   Category/ Module  : Purchase Authorization
   Root cause: As Brandi is out of office, Requested to re direct the purchase authorization so any LDSS program manager can approve it
   Fix provided: Data fix is done to redirect the purchase authorization
   Pull request# for code fix:
   Reason why no related code fix: N
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update routing 
set eventcode ='PCAUTHR' ,tosecurityusersid =null,
updatedby ='CJAMS-67439',updatedon =now()
where routingid ='7ecc0bd8-b457-493e-a65f-8e725512e8e8' and routingstatustypeid ='42' and activeflag =1;