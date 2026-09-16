/*
   Issue Description: CDM-25209
   Category/ Module  : child removal end date 221030016870
   Root cause: user wants to remove
   Pull request# for code fix: 
  explanantion:  user asked tp remove the clid removal record
*/


UPDATE intakeservreqchildremoval 
SET exitdate = null,
	updatedby = 'CDM-25209',
	updatedon = now() 
WHERE intakeservreqchildremovalid = '334ce5c6-2f6a-4c08-9872-c90c34eda76f';

update tb_client_eligibility set end_dt =null, update_user_id = 'CDM-25209', update_ts = now()  where removal_id =254266;

update personprogramarea set enddate = null, updatedby = 'CDM-25209', updatedon = now() where personid = '4a6271a1-1965-47a8-a508-71bea347e615' and programkey = 'OOH';
