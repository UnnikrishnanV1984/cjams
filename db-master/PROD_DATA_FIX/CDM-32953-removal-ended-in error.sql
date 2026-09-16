/*
   Issue Description: CDM-32953
   Category/ Module  :Child removal
   Root cause: user requested to remove the child removal added, as the removal ended in error
   Pull request# for code fix: 
   Reason why no related code fix: 
   requested a data fix to resolve:
*/

UPDATE intakeservreqchildremoval 
SET exitdate = Null,
	returndate = Null,
	returntime = Null,
	removalexitreason = NULL,
	updatedby ='CDM-32953',
    updatedon = now()
WHERE intakeservreqchildremovalid = '0df85f23-9ef3-4202-b2c2-034c02acef35';

UPDATE tb_client_eligibility 
SET 
     end_dt = Null
	, update_user_id = 'CDM-32953'
	, update_ts = now()
WHERE removal_id ='194885' and delete_sw = 'N';



UPDATE personprogramarea 
SET   enddate = Null
	, updatedby ='CDM-32953'
	, updatedon = now() 
WHERE personprogramid   = '8460e2e4-0e75-47d2-9e93-86c32585cf3e';
