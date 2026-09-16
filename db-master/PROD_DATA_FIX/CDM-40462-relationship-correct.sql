
/* 
   Issue Description: CDM-40462
   Category/ Module  : GAP
   Root cause: User Request
   Pull request# for code fix: N/A
   Reason why no related code fix: N/A
   Status of the code fix if already submitted and expected prod fix date: N/A
    
*/

update guardianship 
set 
primaryrelationshipkey = 'FOSPARNT', 
updatedby = 'CDM-40462', 
updatedon =  now()
where gapid = 'f1f85d4f-5677-449d-a4f7-661a0d323c4b';