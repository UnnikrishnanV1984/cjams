/*
Issue: Gap Initial - the Case number and home approval date is missing
Category/Module: Support
Root cause: Multiple records were found and it seems they were not saved properly
Fix provided: DB query to add the missing data to the worksheet
Data/Code fix ticket#: CDM-42727
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating gapeligibilityinfo
update gapeligibilityinfo
set providerapprovalid = 190379, dateofhomeapproval = '2024-01-25 00:00:00', casenumber = '3246690',
	haapprovaldtjson = '[{"text":"2023-11-17","value":174813}, {"text":"2024-01-25","value":190379}]',
	servicecaseid = '2a269043-275b-4abf-a7a0-0ef0bcfc0036', updatedby = 'CDM-42727', updatedon = now()
where gapeligibilityinfoid = '94930bc5-769e-44e7-bb6a-1111e96b5fb3' and activeflag = 1;