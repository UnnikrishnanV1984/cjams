/*
    Issue Description: CJAMS-62687 Closed case
    Category/ Module  :  Case assignment
    Root Cause: This is an old migrated case where we need to manually end date the case assignment during the case closure.
                Case assignment was still missing leading to the new case assignments being done due to the recent case closure story changes.
                Data fix needs to be done to remove incorrectely inserted case assignment and update the old case assignment to match the case closure date.

    Fix provided: Data fix has been done for the case 3054292 to remove incorrectely inserted case assignment and update the old case assignment to match the case closure date.
    Regression Impacts: N/A
    Is Code fix Required?: No
    Code fix ticket#: NA
    Reason why no related code fix: This issue happened due to the old migration data and data fix should be sufficient to resolve it.
*/

--3054292
update caseassignment
set activeflag = 0,
	updatedby = 'CJAMS-62687',
	updatedon = now()
where caseassignmentid in ('868ed275-537c-4bed-aaee-522ffb6f48dc')
and activeflag = 1;

update caseassignment
set enddate = '2023-08-02 15:15:08', --2023-08-21 15:29:35 
	updatedby = 'CJAMS-62687',
	updatedon = now()
where caseassignmentid = '04b6198e-152d-434f-a803-446b0b0bc756'
and activeflag = 1;