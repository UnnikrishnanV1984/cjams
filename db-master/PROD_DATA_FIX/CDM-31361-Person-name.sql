/*
   Issue Description: CDM-31361
   Category/ Module  : person  
   Root cause: user request 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/


-- 1. execute the data fix
-- 2. need to take the payload from prod
-- 3. Need to do postman update


update cjams.person set lastname ='Lopez-Meneses', dob ='1978-03-12 00:00:00', updatedby ='CDM-31361', updatedon = now()

where  personid ='7769f88f-b0eb-4b30-a7bb-8284c0bfe4f9';