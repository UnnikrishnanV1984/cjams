
/*
Issue Description: Need data fix to delete the duplicate Investigation finding for the Client: MIA MARIE EILERS, Maltreatment Type: Neglect.
Case# CPS-IR : 251022986637
Category/Module: Bug
Root cause: due to data glitch alleged victim role not removed  under the Investigation Findings..
Fix provided: DB queries to update  record in  investigationallegation table.
Data/Code fix ticket#: CJAMS-58926
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: data error	
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update investigationallegation
set activeflag = 0 ,updatedby = 'CJAMS-58926', updatedon = now()
where investigationallegationid = '3b483b04-1623-42e0-ab3c-37f23cf63fa0' and activeflag =1;