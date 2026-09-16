
/*
   Issue Description: CDM-18726
   Category/ Module  : change removal date
   Root cause: user asked to update
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/



update intakeservreqchildremoval 
set removaldate = '2021-11-15 00:00:00', 
    updatedby = 'CDM-18726', 
    updatedon = now() 
where intakeservreqchildremovalid =  '18d16e1b-5c9d-4dd6-8ed5-4865b149509e';

update personprogramarea 
set startdate = '2021-11-15 00:00:00',
    updatedby = 'CDM-18726', 
    updatedon = now()  
where personprogramid = '00c2e89d-f0c9-48a2-bffb-3a9aa250924a';