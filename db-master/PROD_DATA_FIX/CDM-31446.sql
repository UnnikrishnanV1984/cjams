/*
   Issue Description: CDM-31446
   Category/ Module  :Routing 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
update cjams.routing set activeflag =0,
updatedby ='CDM-31446', updatedon = now()
where routingid in ('5ffb6512-ea58-4d1a-aef7-663463aff61d','ff107ed6-0a6e-4d35-9835-ac1433c15958','7972d8d3-1061-4de7-8f2f-68907216f8f5','9e86087d-2366-480f-bb66-e0df34e93f1e','c73600ca-e945-4fab-a647-0550c7d7bc03',
'81eebf57-630c-4caa-bb16-437f2213f36f' )