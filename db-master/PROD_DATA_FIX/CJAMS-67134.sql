/*
Issue Description: Wrong Response Timer
Category/Module: Bug
Root cause: This is a known issue and code fix will be done, Proceeding with datafix for this case
Fix provided:Data fix is done to update record in intakeservicerequest table.
Data/Code fix ticket#: CJAMS-67134
Regression Impacts: N/A
Is Code fix Required?: Y - CIDM-11278
Code fix ticket#: CIDM-11278.
Reason why no related code fix: Support 
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/



update intakeservicerequest
set reporteddate = '2026-04-15 11:40:14.223',
updatedby = 'CJAMS-67134',
updatedon = now()
where intakeserviceid='71309b99-74ad-4c42-9524-ab8a1ef00d7f' and activeflag =1;

update cjams.cpsresponsetimeractions
    set activeflag = 0, 
        updatedby = 'CJAMS-67134',
        updatedon = now()
where intakeserviceid  = '71309b99-74ad-4c42-9524-ab8a1ef00d7f' and activeflag = 1;