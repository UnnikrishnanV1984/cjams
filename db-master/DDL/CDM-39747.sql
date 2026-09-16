/*
 * CDM-39747 - Incorrect phone number on service log
 * Customer Email ID:beth.davis@maryland.gov
 * Description - Dashboard:When printing a service log it is print as my personal number. 
 * If it could be updated to my work number 240-727-6631. 
 * 
 */

--select * from get_authorization_request(2740214);
--select requestor_name, requestor_phone, * from tb_slpa_snapshot where worker_staff_id=200936877;
UPDATE cjams.tb_slpa_snapshot
SET requestor_phone='2407276631', update_user_id='CDM-39747', update_ts=now() 
where worker_staff_id=200936877;

--select * from v_userprofile where email='beth.davis@maryland.gov';
--select phonenumber,*
--from userprofilephonenumber
--where securityusersid = '20f36ffc-7242-4658-b708-292af69bf357';
UPDATE cjams.userprofilephonenumber
SET phonenumber='2407276631', updatedby='CDM-39747', updatedon=now(), effectivedate=now() 
WHERE userprofilephonenumberid='9e230961-9ff3-412f-8071-a935c943ff15'::uuid;