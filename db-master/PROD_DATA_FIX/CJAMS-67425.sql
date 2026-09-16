/*
Issue Description: CJAMS-67425
Category/Module: Placement 
Root cause: user error, user requested to remove Placement End Date and CPA Home Exit Date and Exit Time and modify the vacancy number
Fix provided: Data fix to remove the Placement End Date and CPA Home Exit Date and Exit Time and modify the vacancy number for MATTHEW CHRISTOPHE YOUNG CJAMS PID# : 4105165
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
    updatedby = 'CJAMS-67425'
where
    placementid = 'a29a0b7e-f0d9-40fc-b688-cb6a7a9175f0';

update placementrevision
set
    exitdate = null,
    exittime = null,
    exittypekey = null,
    updatedon = now (),
    updatedby = 'CJAMS-67425'
where
    placementid = 'a29a0b7e-f0d9-40fc-b688-cb6a7a9175f0';

update placementcpahomes
set
    exitdt = null,
    exittm = null,
    updatets = now (),
    updateuserid = 'CJAMS-67425'
where
    placementcpahomeid = '90600e5a-f6f9-4b4d-ab17-d8d81b928504'
    and activeflag = 1;

update prov.tb_contract_program
set
    vacancy_no = vacancy_no - 1,
    update_ts = now (),
    update_user_id = 'CJAMS-67425'
where
    program_id = 2817
    and delete_sw = 'N';