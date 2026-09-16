/*
Issue:Authorization #1823445 for Case 3263267 (Client: Davon Harper, Provider: Jumoke Behavioral Services, LLC) is not appearing in the Director approval queue. The purchase authorization was originally submitted under Christina Law on 03/22/2022, but the respective user no longer holds a Director approval role.
Root Cause:The Purchase Authorization was routed to a Director which was not approved and at present that user does not have a Director approval role and preventing it from appearing in the Director approval queue. This Purchase Authorization re-routed to another Director with the Data fix.Additionally, the system is preventing to end the related Service Log due to overlapping with another Service log. As part of the data fix, an end date was added to close the Service Log and maintain data consistency.
Fix Provided (Data Fix Only):Data fix was done by Updated intakedastaging table  routing table..
Data/Code fix ticket#: CJAMS-62570
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/
update routing
set tosecurityusersid = 'd636ac2f-53ff-43e0-adbf-35c97e0427ec', teamid = '29b0a383-1ea4-49a8-a782-f9edaeb994c1',updatedby='CJAMS-62570',updatedon=now()
where routingid = 'a0b98028-3387-4ca7-a47e-ddeaa84f85e5' and activeflag = 1;

update tb_service_log
set end_dt='2024-07-31' ,estimated_end_dt='2024-07-31',update_ts=now(),update_user_id='CJAMS-62570',end_service_reason_cd='1824'
where service_log_id = '2027056' and delete_sw = 'N';


