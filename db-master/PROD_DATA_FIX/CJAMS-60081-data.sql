/*
Issue Description: CJAMS-60081: Case incorrectly shows as closed
Category/Module: Payments/ Adoption subsidy
Root cause: case status showed as closed in the case prior history, So changhed it to open as requested by user
Data/Code fix ticket#: CJAMS-60081
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Migration issue and correction is needed as a data fix for the issue.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/


UPDATE cjams.servicecase 
SET statustypekey ='ASSGN', dispositioncode = 'Open', updatedby = 'CJAMS-60081',updatedon = now() 
where servicecaseid ='b5de9eb3-45c7-42c7-a747-6072ddd7b80a' and activeflag = 1;