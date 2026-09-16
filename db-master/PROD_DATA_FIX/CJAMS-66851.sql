/*
Issue Description: Wrong Response Timer
Category/Module: Bug
Root cause: This is a known issue and code fix will be done, Proceeding with datafix for this case
Fix provided:Data fix is done to update record in intakeservicerequest table.
Data/Code fix ticket#: CJAMS-66851
Regression Impacts: N/A
Is Code fix Required?: Y - CIDM-11278
Code fix ticket#: CIDM-11278.
Reason why no related code fix: Support 
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/




update intakeservicerequest
set reporteddate = '2026-03-27 11:30:57',
updatedby = 'CJAMS-66851',
updatedon = now()
where intakeserviceid='390c1479-b764-44c5-b9c2-532d21472389';

update cjams.cpsresponsetimeractions
    set activeflag = 0, 
        updatedby = 'CJAMS-66851',
        updatedon = now()
where intakeserviceid  = '390c1479-b764-44c5-b9c2-532d21472389' and activeflag = 1;