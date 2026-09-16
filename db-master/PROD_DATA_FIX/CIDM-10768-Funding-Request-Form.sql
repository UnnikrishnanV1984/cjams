/* 
    Issue Description: CIDM-10768
   Category/ Module  : Purchase Authorization
   Root cause: Wrong data was inserted into the snapshot table resulting in worng superviosr name for the PA approval.
   Pull request# for code fix: 
   Reason why no related code fix: User Error 
*/
update tb_slpa_snapshot
set supervisor_name = 'Megan M. McCaskill',
	update_ts = now(),
	update_user_id = 'CIDM-10768',
	supervisor_staff_id = '200008497'
where authorization_id in ('3856550','3856552')
and delete_sw = 'N';
