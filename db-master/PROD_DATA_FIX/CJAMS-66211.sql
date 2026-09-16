/*
Issue: CJAMS-66211 Duplicate removals
Category/Module: Child Removal
Root cause: User requested to remove the review child removal as it is a duplicate record.
            Client ID: 200900506 (HALEY JOHNSON)
Fix provided: Data fix has been done to remove the duplicate child removal record from the Client ID: 200900506
Data/Code fix ticket#: CJAMS-66211
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data entry error
*/


update intakeservreqchildremoval
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-66211'
where intakeservreqchildremovalid = '9d7cafe7-7099-41b8-a662-041440c2030d'
and activeflag=1;

update intakeservreqchildremoval_history
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-66211'
where intakeservreqchildremovalid = '9d7cafe7-7099-41b8-a662-041440c2030d'
and activeflag=1;


update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-66211'
where objectid = '9d7cafe7-7099-41b8-a662-041440c2030d'
and activeflag=1;