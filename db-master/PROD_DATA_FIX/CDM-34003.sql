/*
   Issue Description: CDM-34003
   Category/ Module  : Child Removal
   Root cause: As requested by user
   Fix Privided: Did data fix to remove that exit date  
*/


update intakeservreqchildremoval set exitdate = null , 
updatedby = 'CDM-34003', updatedon  = now() 
where intakeservreqchildremovalid = '4913fd4a-3810-4162-acd3-b22220cacb63';


update personprogramarea SET enddate = null,  updatedby = 'CDM-34003', updatedon = now()
where personprogramid='7707273e-f7d0-4220-b49e-c3c64d4e8f2b';

update tb_client_eligibility
set end_dt = null,
    update_user_id = 'CDM-34003',
    update_ts = now()
where removal_id = 184439;