
/*
Issue Description: remove the Child Removal & OOH Program Assignment End Date as requested.
Category/Module: Bug
Root cause: user could not abe to delete end dates  and placement structure,they can only create.
Fix provided: DB queries  update enddate intakeservreqchildremoval,personprogramarea tables
Data/Code fix ticket#: CJAMS-58777
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/
update intakeservreqchildremoval
set exitdate = null ,updatedby = 'CJAMS-58777', updatedon = now()
where intakeservreqchildremovalid = '7a95699c-02d4-40b2-b450-44b266882176' and activeflag =1;

--Updating intakeservreqchildremoval_history
update intakeservreqchildremoval_history
set exitdate = null, updatedby = 'CJAMS-58777', updatedon = now()
where intakeservreqchildremovalhistoryid = 'f480abcf-a9b3-4081-92bc-8babab2eec7a' and activeflag = 1;


update personprogramarea
set enddate = null, updatedby = 'CJAMS-58777', updatedon = now()
where personprogramid = '18226316-e35b-4372-8646-91fdc356ac0b' and activeflag = 1 ;


update tb_client_eligibility 
set end_dt = null, update_ts = now(),update_user_id  = 'CJAMS-58777'
where eligibility_id  = 10073354 and delete_sw = 'N';


--Updating placement
update placement
set exittypekey = 'CIPS', updatedby = 'CJAMS-58777', updatedon = now()
where placementid = '3bddc3e9-c54e-4248-84bc-6a3cbd438570' and activeflag = 1;

--Updating placementrevision
update placementrevision
set exittypekey = 'CIPS', updatedby = 'CJAMS-58777', updatedon = now()
where placementrevisionid = '77946de7-700d-4767-b823-fdf34711c9be' and activeflag = 1;