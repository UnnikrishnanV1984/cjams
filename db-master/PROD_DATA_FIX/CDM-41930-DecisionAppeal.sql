/*
Issue Description: Please close back the case as confirmed by the user.
Category/Module: Support
Root cause: Case was opened by dev so user can upload documents
Fix provided: DB queries to close the case back
Data/Code fix ticket#: CDM-41930
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support ticket
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating intakeservicerequest
update intakeservicerequest
set intakeserreqstatustypeid = '642f18b0-ef6e-4d4b-9871-acc0734f3f5a', updatedby = 'CDM-41930', updatedon = now()
where intakeserviceid = 'e6fee1ec-91d1-49cb-9ecb-f069cce8ef53' and activeflag = 1;

--Updating intakeservicerequestdispositioncode
update intakeservicerequestdispositioncode
set intakeserreqstatustypeid = '642f18b0-ef6e-4d4b-9871-acc0734f3f5a', updatedby = 'CDM-41930', updatedon = now()
where intakeserviceid = 'e6fee1ec-91d1-49cb-9ecb-f069cce8ef53' and activeflag = 1;

--Updating routing
update routing
set routingstatustypeid = 4, updatedby = 'CDM-41930', updatedon = now()
where routingid = '0588df15-d2b5-4235-8d43-2007efc7a3f3' and activeflag = 1;

update routing
set routingstatustypeid = 16, updatedby = 'CDM-41930', updatedon = now()
where routingid = '6a3d9c62-138b-4755-bd1f-9d978253ead1' and activeflag = 1;

--Updating caseassignment
update caseassignment
set toworkeridno = null, enddate = '2005-05-24 00:00:00.000', updatedby = 'CDM-41930', updatedon = now()
where caseassignmentid = '1ad1acb7-1fbc-4155-b598-fa7cd8c0b961' and activeflag = 1;