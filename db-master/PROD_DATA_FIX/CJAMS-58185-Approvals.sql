/*
Issue Description: Please remove the removal review for Case: 3285902 from the supervisor approval inbox,
Category/Module: Bug
Root cause: Due to data glitch caused to get records in STG3
Fix provided: DB queries  update routing table.
Data/Code fix ticket#: CJAMS-58185
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Bug
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/
update routing 
set activeflag = 0 , updatedby = 'CJAMS-58185',updatedon = now()
where routingid in ('d79ef66f-10de-4c60-b642-f287dba8d2b7','595ff89f-0079-4c02-a1f9-b5c66de6219a','69d3e362-a82e-4b85-8454-1cf295802ae2');


update  intakeservreqchildremoval
set activeflag = 0 , updatedby = 'CJAMS-58185',updatedon = now()
where intakeservreqchildremovalid in ('125bdfc8-1b13-4056-a43d-0d82e4ac13a5','77350530-9f47-4e38-b032-eb279eef118a') and activeflag = 1;

update  intakeservreqchildremoval
set activeflag = 0 , updatedby = 'CJAMS-58185',updatedon = now()
where intakeservreqchildremovalid = 'ff423d30-f720-4669-9899-8a1d793a65e4' and activeflag =1;
