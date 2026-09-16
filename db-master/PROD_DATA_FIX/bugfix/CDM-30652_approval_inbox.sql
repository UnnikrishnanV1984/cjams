/*
   Issue Description: CDM-30652
   Category/ Module  : remove approved case from approval inbox
   Root cause: user wants to remove the case  from approval inbox
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/

update routing set activeflag = 0, updatedby = 'CDM-30652', updatedon = now() where routingid in
('482d4eda-c90e-48d6-9140-f75e414a3a8c'
,'af197f1a-e51d-4bbd-9729-5ab642c1c651');