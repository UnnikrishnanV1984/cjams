/*
   Issue Description: CDM-19212
   Category/ Module  :  Remove Court Hearing
   Root cause: Remove Court Hearing for the individual
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/




update hearingclients set activeflag = 0, updatedby = 'CDM-19212', updatedon = now() 
where hearingclientid in
('99b55cb3-779e-4519-9d76-fe674a19d73a',
'11ca9898-5586-4a57-984a-0186414750ba',
'd10cda4a-911a-48b8-b6cc-7411363fc77e',
'db2bc073-77f4-4225-8b9d-e8dd46f432d5');