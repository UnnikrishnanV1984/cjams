/*
Issue Description: Please do a data fix to screen out the intake and update the submission history.
Category/Module: Bug
Root cause: Users not able to approve after override when there is a reason for delay
Fix provided: Db query to close the intake as screenout.
Data/Code fix ticket#: CDM-40771
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: CIDM-9167
Reason why no related code fix: Codefix to be deployed.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating existing approval request record to approved in routing 
update routing
set routingstatustypeid = 8, intakerecommendation = 'screenout', updatedby = 'ba384e95-a535-4b1f-b9ea-b94c4f9ef782', updatedon = now()
where routingid = '17f7aa6d-6535-4888-bacb-c1b670c11a27';

--Updating intake recommendation to screenout in routing
update routing 
set intakerecommendation = 'screenout', updatedby = 'CDM-40771', updatedon = now()
where routingid = 'f47c6eae-2f6a-47f8-8f77-2544a2cf1415';

--Updating case pending status in intakedastaging
update intakedastaging 
set status = 'Closed', ispreintake = true, updatedby = 'CDM-40771', updatedon = now()
where intakenumber = 'I241012861080' and activeflag = 1;