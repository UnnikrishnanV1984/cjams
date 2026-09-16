/*
   Issue Description: CDM-22320
   Category/ Module  : case missing from my appeals tab
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update routing
set fromsecurityusersid = '2749e1a9-7e03-45ec-9127-cbdd9870b55d',
updatedon = now(), updatedby = 'CDM-22320'
where routingid = 'c60ff969-1928-491c-9a8d-4db53ba3e615';