
/*
Issue Description: The alleged victim role has been removed from Client ID: 200940966 (Mustafa Omar Wahedaldeen) on 03/24/2025. 
But the client name is still available under the Investigation Findings.
Category/Module: Bug
Root cause: due to data glitch alleged victim role not removed  under the Investigation Findings..
Fix provided: DB queries to update  record in  investigationallegation table.
Data/Code fix ticket#: CJAMS-58713
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: data error	
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update investigationallegation
set activeflag = 0 ,updatedby = 'CJAMS-58713', updatedon = now()
where investigationallegationid = '2f90f4d2-ca9e-40e4-a786-40fa52ce4e1f' and activeflag =1;