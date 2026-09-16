/*
   Issue Description: CJAMS-64253
   Category/ Module  : Purchase Authorization
   Root cause:  Reason why no related code fix: Prod data fix to redirect purchase authorization Tyriqua Henry to carolyn.harding@maryland.gov
   Pull request# for code fix:
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/



update routing set tosecurityusersid = '6b3def22-8400-4e75-b7bd-266151923ca0', updatedby = 'CJAMS-64253', updatedon = now()
where routingid = 'ea38d62e-57b8-403d-875b-ed18541221c5' and objectid= '4070798';