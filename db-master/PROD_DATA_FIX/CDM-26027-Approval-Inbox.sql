/*
   Issue Description: CDM-26027
   Category/ Module  : approval inbox
   Root cause: user wants to remove approved record
   Pull request# for code fix: 6672
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/
update routing 
set activeflag = 0,
    updatedby = 'CDM-26027',
    updatedon = now()
where routingid = '9e64948a-119e-4d5e-ba08-ceaf002b6047';