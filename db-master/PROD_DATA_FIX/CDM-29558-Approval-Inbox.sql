/*
   Issue Description: CDM-29558
   Category/ Module  : approval inbox
   Root cause: user wants to remove approved record
   Pull request# for code fix: 8578
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/
update routing 
set activeflag = 0,
    updatedby = 'CDM-29558',
    updatedon = now()
where routingid = 'ebd7d43d-ea74-4662-beb5-fd679f4ab101';
