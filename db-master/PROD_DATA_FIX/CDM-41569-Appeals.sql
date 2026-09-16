/*
Issue Description: Please carry out data fix to
1. Upload 3 PDF documents to this closed CPS IR case (attached 3 PDF documents in this ticket).
2. Modify the Investigation Findings to Unsubstantiated instead of Indicated
Category/Module: Bug
Root cause: Old migration case needs investigation finding changed
Fix provided: DB queries to reopen the case
Data/Code fix ticket#: CDM-41569
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Old case issue
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Reopening the case in intakeservicerequest
update intakeservicerequest 
set intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690', updatedby = 'CDM-41569', updatedon = now()
where intakeserviceid = 'e6fee1ec-91d1-49cb-9ecb-f069cce8ef53' and activeflag = 1;

--Reopening the case in intakeservicerequestdispositioncode
update intakeservicerequestdispositioncode
set intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690', updatedby = 'CDM-41569', updatedon = now()
where intakeserviceid = 'e6fee1ec-91d1-49cb-9ecb-f069cce8ef53' and activeflag = 1;

--Updating status in routing
update routing
set routingstatustypeid = 2, updatedby = 'CDM-41569', updatedon = now()
where routingid in ('6a3d9c62-138b-4755-bd1f-9d978253ead1', '0588df15-d2b5-4235-8d43-2007efc7a3f3') and activeflag = 1;

--Assigning case to user
update caseassignment
set toworkeridno = 'b28a47f7-fb75-4f4e-9e15-da1ea41d71c3', enddate = null, updatedby = 'CDM-41569', updatedon = now()
where caseassignmentid = '1ad1acb7-1fbc-4155-b598-fa7cd8c0b961' and activeflag = 1;

--Changing finding in tb_conv_inv_finding
update tb_conv_inv_finding
set investigation_finding_cd = 'Unsubstantiated'
where inv_finding_id = 112881;