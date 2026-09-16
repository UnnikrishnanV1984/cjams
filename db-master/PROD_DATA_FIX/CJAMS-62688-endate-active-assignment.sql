/*
    Issue Description: CJAMS-62688 Closed case
    Category/ Module  :  Case assignment
    Root Cause: This is an old migrated case where we need to manually end date the case assignment during the case closure.
                Case assignment was still missing leading to the new case assignments being done due to the recent case closure story changes.
                Data fix needs to be done to remove incorrectely inserted case assignment and update the old case assignment to match the case closure date.

    Fix provided: Data fix has been done for the case 3053779 to remove incorrectely inserted case assignment and update the old case assignment to match the case closure date.
    Regression Impacts: N/A
    Is Code fix Required?: No
    Code fix ticket#: NA
    Reason why no related code fix: This issue happened due to the old migration data and data fix should be sufficient to resolve it.
*/

--3053779
update caseassignment
set activeflag = 0,
	updatedby = 'CJAMS-62686',
	updatedon = now()
where caseassignmentid in ('d5842536-6ea7-4a01-9c3a-89fae4d4e326',
'b6358d02-7e44-46e4-9345-3051059bff0f')
and activeflag = 1;

update caseassignment
set enddate = '2020-06-11 07:26:00', --2022-05-19 16:13:20
	updatedby = 'CJAMS-62686',
	updatedon = now()
where caseassignmentid = 'fcf66ea1-632a-4d7e-839d-7d46314e01c2'
and activeflag = 1;