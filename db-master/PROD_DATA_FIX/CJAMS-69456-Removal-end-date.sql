/*
   Issue Description: CJAMS-69456
   Category/ Module  : Prod data fix to remove the removal endaate 
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/




update intakeservreqchildremoval
set exitdate = NULL,removalexitreason = NULL,returntransts = NULL,updatedby = 'CJAMS-69456',updatedon = now()
where intakeservreqchildremovalid = '8d15af41-7e8b-4e50-8ce0-95e1a598ab85' and activeflag = 1;


update tb_client_eligibility
set end_dt = null, update_user_id = 'CJAMS-69456', update_ts = now()
where removal_id = '392089';

update personprogramarea
set enddate = null, updatedby = 'CJAMS-69456', updatedon = now()
where  personprogramid = 'efdf266f-5001-4433-ad38-240173bd837f' and activeflag = 1;