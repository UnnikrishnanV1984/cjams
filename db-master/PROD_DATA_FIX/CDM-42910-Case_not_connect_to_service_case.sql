/*
   Issue Description: CDM-42910
   Category/ Module  :  IVE - GAP
   Root cause: Case number is displayed in IV-E GAP, due to invalid intake service request actor id in permanancy plan table.
   Pull request# for code fix: 
   Reason why no related code fix: raised an internal ticket for RCA
   Status of the code fix if already submitted and expected prod fix date: 
*/

update permanencyplan
set intakeservicerequestactorid = 'da0a7b4e-28e5-4704-8129-5fa6d1f195f0',
    updatedon = now(),
    updatedby = 'CDM-42910'
where servicecaseid ='1bf96d1d-8632-43cf-867b-46401454cfb4' 
      and permanencyplanid ='9d5db0ee-9060-492c-b3a3-c504b32747e1';

