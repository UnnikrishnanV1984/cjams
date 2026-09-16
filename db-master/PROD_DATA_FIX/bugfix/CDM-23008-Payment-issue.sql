
/*
   Issue Description: CDM-23008
   Category/ Module  : Payment Issue
   Root cause: user wants to change the address of living arrangement and end data change 
   Pull request# for code fix: 5705
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/





update cjams.intakeservreqchildremoval set exitdate= '2022-01-05 00:00:00', updatedon = now(), updatedby = 'CDM-23008' where removalid = 253352 and activeflag = 1;



update cjams.intakeservreqchildremoval set exitdate= '2022-01-05 00:00:00', updatedon = now(), updatedby = 'CDM-23008' where removalid = 253351 and activeflag = 1;

update tb_client_eligibility set end_dt = '2022-01-05 00:00:00',update_ts = now(), update_user_id = 'CDM-23008' where removal_id = 253352; 

update tb_client_eligibility set end_dt = '2022-01-05 00:00:00',update_ts = now(), update_user_id = 'CDM-23008' where removal_id = 253351;
