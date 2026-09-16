/*
   Issue Description: CDM-20816
   Category/ Module  : purchase auth 
   Root cause: user wants to access purchase auth so routing the case 
   Pull request# for code fix: 5428
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/
update routing 
set eventcode = 'PCAUTHR', 
tosecurityusersid = null,
 updatedby = 'CDM-20816', 
    updatedon = now()
where routingid = '2ca29457-c023-4334-8320-bb477d4c724c';