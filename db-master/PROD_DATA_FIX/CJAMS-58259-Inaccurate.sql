/*
Issue Description: Need to delete 2026-2027 rate begin and end. Accidentally added an additional rate list for GAP Screen 
Category/Module: Bug
Root cause:data glitch casused the review status  not be approved as updated.
Fix provided:DB queries to update record in routing,placementrevision,livingarrangement table.
Data/Code fix ticket#: CJAMS-58259
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error  
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/


update placement
set approvalstatustypekey = '3047', updatedby = 'CJAMS-58259',updatedon = now()
where  placementid = '69c1072a-490c-4061-9823-04ef6f599b22' and activeflag =1;

update placementrevision
set approvalstatustypkey = '3047', updatedby = 'CJAMS-58259', updatedon = now()
where  placementrevisionid = '8655c4d6-0707-4380-a9e0-617e03033312' and activeflag =1;


update routing
set activeflag = 0, updatedby = 'CJAMS-58259',updatedon = now()
where routingid = '1c167c91-3344-43d8-83d6-fc6f8716cd94' and activeflag = 1;
