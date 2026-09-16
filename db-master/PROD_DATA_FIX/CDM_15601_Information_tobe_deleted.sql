/*
   Issue Description: CDM-15601
   Category/ Module  :  service plan  
   Root cause: Service plan needs to be deleted
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/



UPDATE serviceplan 
SET activeflag = 0, updatedby = 'CDM-15601', updatedon = now() 
WHERE serviceplanid = '944df445-a96f-4ba3-b1ac-078ce506ca46';