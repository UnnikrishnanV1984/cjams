/*
   Issue Description: CDM-43697 Personal Cell Phone
   Category/ Module  :  Assignments
   Root cause: Incorrect phone number is updated due to know integration issue and sailpoint and data fix will be needed to fix this.
               User Details:
               Amy Crowley's -  240-609-8064.
               Patti Carter's - 240-727-4328.
               Brooke Liller's -240-522-6066.
               Brandi Jefts' - 301-784-9391. 
   Fix provided : Data fix has been promoted to update the phone number in userprofile and slpa snapshot table.
   Code fix ticket#: N/A
   Reason why no related code fix: This is a known sail point issue and data fix will resolve it. 
   Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete: N/A

*/




--Amy Crowley's
update userprofilephonenumber
set updatedby='CDM-43697', updatedon=now(),phonenumber='240-609-8064' 
where securityusersid='c2d970f4-7099-4239-b161-9463b41867fd' and activeflag=1;


--Patti Carter's
update userprofilephonenumber
set updatedby='CDM-43697', updatedon=now(),phonenumber='240-727-4328' 
where securityusersid='cf1ca693-0929-4fd7-aac5-dce6bd2f118e' and activeflag=1;

update tb_slpa_snapshot
set worker_phone='240-727-4328',update_user_id='CDM-43697', update_ts=now()
where worker_name = 'Patti Carter' and worker_phone = '240-920-3479';

--Brooke Liller

update userprofilephonenumber
set updatedby='CDM-43697', updatedon=now(),phonenumber='240-522-6066' 
where securityusersid='e1a629e8-ac0d-4fa4-bd92-9b21c60a681b' and activeflag=1;

update tb_slpa_snapshot
set worker_phone='240-522-6066',update_user_id='CDM-43697', update_ts=now()
where worker_name = 'Brooke Liller' and worker_phone = '301-268-6167';

--Brandi Jefts 

update userprofilephonenumber
set updatedby='CDM-43697', updatedon=now(),phonenumber='301-784-9391' 
where securityusersid='7f7f6a93-c36d-4ca1-b096-d716ca279cf5' and activeflag=1;

update tb_slpa_snapshot
set worker_phone='301-784-9391',update_user_id='CDM-43697', update_ts=now()
where worker_name = 'Brandi Jefts' and worker_phone = '301-876-1581';