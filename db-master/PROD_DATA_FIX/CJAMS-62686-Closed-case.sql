/*
   Issue Description: CDM-36188
   Category/ Module  :  Case Issue
   Root Cause: partial datafix was made on this migrated adoption case back in 2021 to close the adoption case using datafix but case assignment was still open leading to have the open case assignment 
   and eventually user requested to closed the assignment with this ticket.
    Fix provided: datafix done to update the case assignment table with the correct case assignment date.
    Regression Impacts: case assignment
    Is Code fix Required?: No
    Code fix ticket#: NA
    Reason why no related code fix: need datafix to update the case assignment data.
*/

--3054377
update caseassignment
set activeflag = 0,
	updatedby = 'CJAMS-62686',
	updatedon = now()
where caseassignmentid in ('681b64e5-11bb-4e2d-807c-c297ebf6c5d2',
'dc6b70ca-35ee-4dd3-a13e-1ba4e97fd615')
and activeflag = 1;

update caseassignment
set enddate = '2021-03-01 09:16:59', --2022-05-19 14:51:21
	updatedby = 'CJAMS-62686',
	updatedon = now()
where caseassignmentid = '32440ec0-0b0e-4177-8f5b-e7f71db2a549'
and activeflag = 1;