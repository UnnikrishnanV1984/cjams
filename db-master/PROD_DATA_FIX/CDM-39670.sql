/*
 * CDM-39670 - Incorrect phone number on service log
 * Customer Email ID:ashley.amoroso@maryland.gov
 * Description - Dashboard:When printing a service log it is print as my personal number. 
 * If it could be updated to my work number 240-609-6855. 
 * 
 */

--select * from get_authorization_request(2740214);
--select requestor_name, requestor_phone, * from tb_slpa_snapshot where worker_staff_id=200805721;
UPDATE cjams.tb_slpa_snapshot
SET requestor_phone='2406096855', update_user_id='CDM-39670', update_ts=now() 
where worker_staff_id=200805721;

--select * from v_userprofile where email='ashley.amoroso@maryland.gov';
--select phonenumber,*
--from userprofilephonenumber
--where securityusersid = 'faaed8a5-cc16-47fc-a733-f77532c69ffa';
UPDATE cjams.userprofilephonenumber
SET phonenumber='2406096855', updatedby='CDM-39670', updatedon=now(), effectivedate=now() 
WHERE userprofilephonenumberid='227914b5-1c4d-497b-b9ba-c187f95fcc6c'::uuid;
