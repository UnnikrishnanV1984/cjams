/*
   Issue Description: CDM-27265
   Category/ Module  : Approval INbox
   Root cause: user wants to  remove approved records from approval inbox 
   Pull request# for code fix:7285
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Need to do only data fix
*/
update routing set activeflag = 0, updatedby = 'CDM-27265', updatedon = now()
where routingid in (
'5d460414-3033-4166-8f88-52a5f44fd8ae', '55bf2c09-98f8-4abf-86ea-8e189a2c9816', 'aa6e6d23-b047-43f4-bb32-33b544e41142', 
'e1068724-2306-4a94-846f-6f5e43e420f3', 'd6f4930f-3ab1-4769-9b65-5b0067e36e06', '318512e5-7b5d-42fc-b2d7-6fb42377bb62', 
'9522f040-ec89-497f-8446-4c395804edee', '3e1cd1bb-5563-4017-9dcc-eaf7fd2c70e8', '9d3508c9-79f7-44f8-a6a8-e8cbb887a2f0');