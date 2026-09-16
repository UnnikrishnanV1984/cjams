/*
Issue Description: Response Timer Issue 
Category/Module: Bug
Root cause: This is a known issue and code fix will be done, Proceeding with datafix for this case
Fix provided:Data fix is done to update record in intakeservicerequest table.
Data/Code fix ticket#: CJAMS-67945
Regression Impacts: N/A
Is Code fix Required?: Y - CIDM-11278
Code fix ticket#: CIDM-11278.
Reason why no related code fix: Support 
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/




update intakeservicerequest
set reporteddate = '2026-05-01 15:24:12.441',
updatedby = 'CJAMS-67945',
updatedon = now()
where intakeserviceid='88a52dfc-144c-4ad7-97e9-9ab1065272a6';

update cjams.cpsresponsetimeractions
    set activeflag = 0, 
        updatedby = 'CJAMS-67945',
        updatedon = now()
where intakeserviceid  = '88a52dfc-144c-4ad7-97e9-9ab1065272a6' and activeflag = 1;