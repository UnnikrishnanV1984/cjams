/*
   Issue Description: CDM-32755
   Category/ Module  :Child removal
   Root cause: user requested to remove the child removal added, as the case was not closed in court on 5/16/23 
   Pull request# for code fix: 
   Reason why no related code fix: 
   requested a data fix to resolve:
*/

UPDATE intakeservreqchildremoval 
SET exitdate = Null,
	returndate = Null,
	returntime = Null,
	removalexitreason = NULL,
	updatedby ='CDM-32755',
    updatedon = now()
WHERE intakeservreqchildremovalid = '20e03726-a8c6-4b77-bf33-c8c74000dff6';

UPDATE tb_client_eligibility 
SET 
     end_dt = Null
	, update_user_id = 'CDM-32755'
	, update_ts = now()
WHERE removal_id ='254476' and delete_sw = 'N';

UPDATE intakeservreqchildremoval 
SET exitdate = Null,
	returndate = Null,
	returntime = Null,
	removalexitreason = NULL,
	updatedby ='CDM-32755',
    updatedon = now()
WHERE intakeservreqchildremovalid = 'a7053b63-43ff-416d-876b-ac3bc9e8229b';

UPDATE tb_client_eligibility 
SET 
     end_dt = Null
	, update_user_id = 'CDM-32755'
	, update_ts = now()
WHERE removal_id ='254477' and delete_sw = 'N';

UPDATE personprogramarea 
SET   enddate = Null
	, updatedby ='CDM-32755'
	, updatedon = now() 
WHERE personprogramid  in ('7cabda54-0348-463c-9862-a286383604d6','d43f7cbd-a7e1-48b2-af66-358de83a23a2')and activeflag =1;

