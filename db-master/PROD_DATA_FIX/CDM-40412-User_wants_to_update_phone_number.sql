/*
  Issue Description: CDM-40412-User error-Need to update phone number.
   Category/ Module  :  User management
   Root cause: User asked to updated the phone number
   Pull request# for code fix: NA
   Reason why no related code fix: NA
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete:
*/

update userprofilephonenumber
set updatedby='CDM-40412', updatedon=now(),phonenumber='443-307-1772'
where securityusersid='58205b9b-de03-443a-b044-640b8140cda6' and activeflag=1;


update tb_slpa_snapshot
set worker_phone='443-307-1772',update_user_id='CDM-40412', update_ts=now()
where worker_name = 'Julia Kilduff' and worker_phone = '410-952-5285';