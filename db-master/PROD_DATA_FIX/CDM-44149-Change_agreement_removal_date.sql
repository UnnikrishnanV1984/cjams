/*
   Issue Description: CDM-29734
   Category/ Module  : Child removal, Placement and Gap
   Root cause: : User requested to change the agreement, removal date, end of placement and subsidy rate to start dates
   Pull request# for code fix: It's a data fix
   Reason why no related code fix: User Error 
   
*/


update placement 
set enddatetime ='2024-12-13 00:00:00.000',updatedon = now(), updatedby ='CDM-44149' 
where placementid ='2ed03afd-b0c2-47fe-badc-4530ef718f2c' and activeflag =1;

update placementrevision 
set exitdate ='2024-12-13 00:00:00.000',updatedon = now(), updatedby ='CDM-44149' 
where placementid ='2ed03afd-b0c2-47fe-badc-4530ef718f2c' and activeflag =1;

update intakeservreqchildremoval 
set exitdate = '2024-12-13', updatedon = now(),updatedby = 'CDM-44149'
where intakeservreqchildremovalid = '5c30b70a-2f21-43c4-ada0-99d0fdf891b7' and activeflag = 1;

update personprogramarea
set enddate ='2024-12-13', updatedon = now(),updatedby = 'CDM-44149'
where personprogramid = 'ea91c626-aaa2-4bc2-a479-3433c623043e' and activeflag = 1;

update tb_client_eligibility 
set end_dt ='2024-12-13', update_user_id = 'CDM-44149', update_ts = now()  
where removal_id =250686 and client_id =4331873;


update gapagreementrate 
set startdate = '2024-12-13 04:00:00.000',
updatedby = 'CDM-44149',
updatedon = now() 
where gapagreementid= '1628bf65-1916-4097-8be6-1e5f142a7c54' and activeflag = 1;

update gapratesrevision
set ratestartdate = '2024-12-13 04:00:00.000',
updatedby = 'CDM-44149',
updatedon = now(),
approvaldate = now()
where gaprateid= '0bb10280-4329-41fa-b8be-4db51a71725d'
and activeflag = 1;

update gapagreement 
set startdate = '2024-12-13 04:00:00.000',
updatedby = 'CDM-44149',
updatedon = now() 
where gapagreementid= '1628bf65-1916-4097-8be6-1e5f142a7c54' and activeflag = 1;