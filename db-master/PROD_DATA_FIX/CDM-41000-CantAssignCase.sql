/*
Issue Description: Please do a data fix to remove the supervisor decision and make the intake in review status so that the supervisor can approve it once again. Also make sure to list the intake in the pending review dashboard.
Category/Module: Bug
Root cause: Users unable to assign intake after approval
Fix provided: DB query to revert the status to pending
Data/Code fix ticket#: CDM-41000
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: CIDM-8936
Reason why no related code fix: Codefix in progress by dev team
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Reverting decision to pending in routing
update routing
set routingstatustypeid = 1, supervisordecision = null, updatedby = 'CDM-41000', updatedon = now()
where routingid = 'fde2dd51-615e-48ad-97d3-077784f3c2a7' and activeflag = 1;

--Reverting status to pending in intakedastaging
update intakedastaging
set status = 'pending', ispreintake = false, updatedby = 'CDM-41000', updatedon = now()
where intakenumber = 'I241013004008' and activeflag = 1;

--Removing supervisor decision from intakesnapshot
update intakesnapshot
set
	jsondata = jsonb_set(
		jsonb_set(
			jsonb_set(
				jsondata, '{DAType, DATypeDetail, 0, supDisposition}', 'null'::jsonb),
				'{disposition, 0, supDisposition}', 'null'::jsonb),
				'{intakeDATypeDetails, 0, supDisposition}', 'null'::jsonb),
	updatedby = 'CDM-41000', updatedon = now()
where intakenumber = 'I241013004008' and activeflag = 1;