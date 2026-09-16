/*
Issue Description: CJAMS-67277
Category/Module: Placement 
Root cause: user error, user requested to remove Placement End Date for CJAMS PID# : 201122703
Fix provided: Data fix to remove the Placement End Date for CJAMS PID# : 201122703
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
*/


update placement
set
    enddatetime = null,
    endtime = null,
    exittypekey = null,
    updatedon = now (),
    updatedby = 'CJAMS-67277'
where
    placementid = '9fcc2b56-93c5-446f-9d25-9916611f64e1';

update placementrevision
set
    exitdate = null,
    exittime = null,
    exittypekey = null,
    updatedon = now (),
    updatedby = 'CJAMS-67277'
where
    placementid = '9fcc2b56-93c5-446f-9d25-9916611f64e1';

update prov.tb_provider
set vacancy_no = vacancy_no - 1,
	update_ts = now(),
	update_user_id = 'CJAMS-67277'
where provider_id = 6066571
	and delete_sw = 'N' ;