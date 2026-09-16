/*
   Issue Description: CDM-34356
   Category/ Module  : approval inbox
   Root cause: user wants to remove approved record
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/
update routing 
set activeflag = 0,
    updatedby = 'CDM-34356',
    updatedon = now()
where routingid in( '1b2a660a-1c52-4376-846f-756fea79ef6e','7e8f55cf-b072-4ab6-9625-12d968fec57d');