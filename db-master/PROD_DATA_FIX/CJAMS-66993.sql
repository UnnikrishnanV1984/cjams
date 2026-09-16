/*
Issue Description: Response Timer Issue 
Category/Module: Bug
Root cause: This is a known issue and code fix will be done, Proceeding with datafix for this case
Fix provided:Data fix is done to update record in intakeservicerequest table.
Data/Code fix ticket#: CJAMS-66993
Regression Impacts: N/A
Is Code fix Required?: Y - CIDM-11278
Code fix ticket#: CIDM-11278.
Reason why no related code fix: Support 
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/




update intakeservicerequest
set reporteddate = '2026-03-19 12:00:00.210',
updatedby = 'CJAMS-66993',
updatedon = now()
where intakeserviceid='901365d8-f897-4dba-8221-2d3f7ff137cb';

update cjams.cpsresponsetimeractions
    set activeflag = 0, 
        updatedby = 'CJAMS-66993',
        updatedon = now()
where intakeserviceid  = '901365d8-f897-4dba-8221-2d3f7ff137cb' and activeflag = 1;