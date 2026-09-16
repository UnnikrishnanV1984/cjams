/*
Issue Description:Wrong removal is mapped to the placement
Root cause: QA requested to update the db, could be caused by a previous datafix to delete removal
Fix provided: DB query to udate placement.
Data/Code fix ticket#:CIDM-11338
Regression Impacts: N/A
Is Code fix Required?: Yes
Code fix ticket#:  no
Reason why no related code fix:User error, not logic error.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update placement
set  intakeservreqchildremovalid= '6aed1fbb-c4b7-4d28-b0fb-aeaa435a39e7', updatedby ='CIDM-11338', updatedon=now()
where placementid='b331ce1e-57e0-40af-8981-15394bbfb26d' and activeflag=1;