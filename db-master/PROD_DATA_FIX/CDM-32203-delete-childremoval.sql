/*
   Issue Description: CDM-32203
   Category/ Module  :Child removal
   Root cause: user requested to remove the child removal added by mistake
   Pull request# for code fix: 
   Reason why no related code fix: 
   requested a data fix to resolve:
*/

UPDATE intakeservreqchildremoval 
SET exitdate = Null,
	returndate = Null,
	returntime = Null,
	removalexitreason = NULL,
	updatedby ='CDM-32203',
    updatedon = now()
WHERE intakeservreqchildremovalid = '90e79f2c-b3e7-4fe3-90a9-dd8a47fc95b7';

UPDATE tb_client_eligibility 
SET 
     end_dt = Null
	, update_user_id = 'CDM-32203'
	, update_ts = now()
WHERE removal_id ='194882' and delete_sw = 'N';

UPDATE personprogramarea 
SET   enddate = Null
	, updatedby ='CDM-32203'
	, updatedon = now() 
WHERE personprogramid  ='d7b6da61-adb5-4617-b51e-57f38208636d' and activeflag =1;