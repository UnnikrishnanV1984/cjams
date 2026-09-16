/*
   Issue Description: CDM-32279
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
	updatedby ='CDM-32279',
    updatedon = now()
WHERE intakeservreqchildremovalid = '8fb116c2-630b-4712-ab87-b3afe1a1a386';

UPDATE tb_client_eligibility 
SET 
     end_dt = Null
	, update_user_id = 'CDM-32279'
	, update_ts = now()
WHERE removal_id ='252117' and delete_sw = 'N';

UPDATE personprogramarea 
SET   enddate = Null
	, updatedby ='CDM-32279'
	, updatedon = now() 
WHERE personprogramid  ='e514bfa7-3f51-4a7c-b10d-9fc3fab00407' and activeflag =1;