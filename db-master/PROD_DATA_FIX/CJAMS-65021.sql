/*
Issue: CJAMS-65021 
Category/Module: Program Assignments
Root cause: Delete Program Assignment not associated with any case.
Fix provided:  Data fix is done as the part of this ticket to remove the incorrect program assignment.
Regression Impacts: N/A
Is Code fix Required?: Yes
Code fix ticket#: NA
Reason why no related code fix: N/A
*/

update personprogramarea
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-65021'
where personprogramid = '57973667-af77-4deb-be4b-91a23a50f62c'
and activeflag =1;    