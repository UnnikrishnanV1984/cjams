/*
   Issue Description: CDM-43486 Personal Cell Phone
   Category/ Module  :  Assignments
   Root cause: Incorrect phone number is updated due to know integration issue and sailpoint and data fix will be needed to fix this.
   Fix provided : Data fix has been promoted to update the phone number in userprofile and slpa snapshot table.
   Code fix ticket#: N/A
   Reason why no related code fix: This is a known sail point issue and data fix will resolve it. 
   Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete: N/A

*/


update userprofilephonenumber
set updatedby='CDM-43486', updatedon=now(),phonenumber='301-784-9391' 
where securityusersid='7f7f6a93-c36d-4ca1-b096-d716ca279cf5' and activeflag=1;

update tb_slpa_snapshot
set worker_phone='301-784-9391',update_user_id='CDM-43486', update_ts=now()
where worker_name = 'Brandi Jefts' and worker_phone = '301-876-1581';