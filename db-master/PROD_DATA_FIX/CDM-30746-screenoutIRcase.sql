/*
   Issue Description: CDM-30746
   Category/ Module  : Dashboard
   Root cause: User wants to remove CPS-IR case
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update 
   intakeservicerequest
set activeflag = 0, 
   updatedby = 'CDM-30746',
   updatedon = now() 
where 
servicerequestnumber = '231020511991';

update 
   personprogramarea 
set
  activeflag = 0,  
  updatedby = 'CDM-30746',
  updatedon = now() 
where objectid = 'bcabd5b2-4af6-4c8d-ab39-3616c55fb50e';

update 
   caseassignment
set
  activeflag = 0,  
  updatedby = 'CDM-30746',
  updatedon = now() 
where objectid = 'bcabd5b2-4af6-4c8d-ab39-3616c55fb50e';

update 
  routing
set
  activeflag = 0,  
  updatedby = 'CDM-30746',
  updatedon = now() 
where objectid = 'bcabd5b2-4af6-4c8d-ab39-3616c55fb50e' and activeflag = 1;


