/*
  Issue Description: CDM-40128-User error-Need to update phone number.
   Category/ Module  :  User management
   Root cause: User asked to updated the phone number
   Pull request# for code fix: NA
   Reason why no related code fix: NA
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
*/

update userprofilephonenumber
set updatedby='CDM-40128', updatedon=now(),phonenumber='301-784-9671'
where securityusersid='066ee762-d671-46aa-852e-7b2c3a714532' and activeflag=1;

update tb_slpa_snapshot
set worker_phone='301-784-9671',update_user_id='CDM-40128', update_ts=now()
where worker_name = 'Lisa Wilson' and worker_phone = '301-268-9394';