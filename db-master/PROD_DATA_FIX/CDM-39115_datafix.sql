/*
   Issue Description: CDM-39115
   Category/ Module  : Child removal
   Root cause: This case was reopened to correct a placement. Please remove the 12/12/23 end date of the Child's Removal so that this ticket can be resolved for SSA
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/




UPDATE intakeservreqchildremoval 
SET exitdate = Null,
    returndate = Null,
    returntime = Null,
    returntransts = NULL,
    removalexitreason = NULL, 
    updatedby ='CDM-39115',
    updatedon = now()
WHERE intakeservreqchildremovalid = 'ec85ccf1-5ba0-4ecb-a84a-41eb011df871';

UPDATE tb_client_eligibility 
SET 
     end_dt = null,
     update_user_id = 'CDM-39115',
     update_ts = now()
WHERE removal_id ='287356' and delete_sw = 'N';

UPDATE personprogramarea 
SET   enddate = null,
      updatedby ='CDM-39115',
      updatedon = now() 
WHERE personprogramid  ='8396e202-c11a-4bd7-95b0-74a7c00e81e7' and activeflag =1;