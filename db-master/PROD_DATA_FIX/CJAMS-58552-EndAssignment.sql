
/*
Issue Description: The following investigation (241022923760) is assigned to my caseload for appeals however I do not need it and am unable to end date the assignment
Category/Module: Support
Root cause: Data glitch caused the case to not be ended when the case was marked complete.
Fix provided: DB queries to update  record in caseassignment tables.
Data/Code fix ticket#: CJAMS-58552
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: N/A
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:
*/

update caseassignment 
set enddate = '2024-11-18 13:47:04.859' ,updatedby = 'CJAMS-58552',updatedon = now()
where caseassignmentid = '9ad167f5-6c61-4892-bba5-49b83f1cc0cd' and activeflag = 1;


update caseassignment 
set enddate = '2024-11-22 14:19:00.499' ,updatedby = 'CJAMS-58552',updatedon = now()
where caseassignmentid = 'b5420691-9b96-4f1d-a53d-568162e5e0c0' and activeflag = 1;
