/*
   Issue Description: CDM-17468
   Category/ Module  :  payment not leaving approval box
   Root cause: user has services that are approved and still shows like does'nt
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update routing set activeflag =0, updatedby = 'CDM-17323', updatedon = now() where routingid = '235ae808-6d3f-4bab-b431-d7d9ae78c1ff';