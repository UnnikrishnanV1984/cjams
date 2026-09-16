/*
Issue: CJAMS-65257 Duplicate removals
Category/Module: Child Removal
Root cause: Supervisor requested to remove the review child removal as it is a duplicate record.
            Client ID: 2810555 (HALEY JOHNSON)
Fix provided: Data fix has been done to remove the duplicate child removal record from the Client ID: 2810555
Data/Code fix ticket#: CJAMS-65257
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data entry error
*/


update intakeservreqchildremoval
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-65257'
where intakeservreqchildremovalid = 'c437ba12-0327-4158-8043-be1bcf3bdf52'
and activeflag=1;

update intakeservreqchildremoval_history
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-65257'
where intakeservreqchildremovalid = 'c437ba12-0327-4158-8043-be1bcf3bdf52'
and activeflag=1;


update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-65257'
where objectid = 'c437ba12-0327-4158-8043-be1bcf3bdf52'
and activeflag=1;

