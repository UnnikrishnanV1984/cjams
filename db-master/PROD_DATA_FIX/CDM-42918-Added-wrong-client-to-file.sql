/*
Issue Description: Please remove the Client ID #204033753.
Category/Module: Error
Root cause: CPS referral was incorrectly connected with service case
Fix provided: DB queries remove person from the service case
Data/Code fix ticket#: CDM-42918
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update actor
set activeflag=0, updatedby='CDM-42918', updatedon=now()
where actorid='00308df9-b6ec-4c75-b3c0-73a80ee5e6c6' and activeflag=1;

update intakeservicerequestactor
set activeflag=0, updatedby='CDM-42918', updatedon=now()
where intakeservicerequestactorid='1d87e96d-e693-4feb-893e-97dbe0480b22' and activeflag=1;

update actorrelationship
set activeflag=0, updatedby='CDM-42918', updatedon=now()
where actorrelationshipid ='249c9894-ebfd-4740-a94d-4a7c89ea7c84' and activeflag=1;

update personrole
set activeflag=0, updatedby='CDM-42918', updatedon=now()
where personroleid='a3e971b2-8790-4115-97eb-88de65c40930' and activeflag=1;

update personroletype
set activeflag=0, updatedby='CDM-42918', updatedon=now()
where personroletypeid ='1389addc-d98e-40e3-87f6-2a78e1bba390' and activeflag=1;


