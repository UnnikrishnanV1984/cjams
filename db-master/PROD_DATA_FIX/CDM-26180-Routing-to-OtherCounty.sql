/*
   Issue Description: CDM-26180
   Category/ Module  : case transfer
   Root cause: user wants to transfer case to other county 
   Pull request# for code fix: 6723
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/
update routing 
set activeflag = 0,
    updatedby = 'CDM-26180',
    updatedon = now()
where routingid = '9075791f-f73b-4d0a-b4c6-aa9061f025ce';