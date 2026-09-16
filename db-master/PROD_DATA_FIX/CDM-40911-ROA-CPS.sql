/*
Issue Description: Need data fix to revert the Intake# I241012958779 to "Review" status
Category/Module: Error
Root cause: Approved intake needs to be assigned to a different worker
Fix provided: Db query to revert intake status to review
Data/Code fix ticket#: CDM-40911
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Updating routing to review status
update routing
set routingstatustypeid = 1, supervisordecision = null, updatedby = 'CDM-40911', updatedon = now()
where routingid = '049890a6-d7e2-4f21-bed8-b5570c1b5f28' and activeflag = 1;

--Updating intakedastaging to pending
update intakedastaging
set status = 'pending', ispreintake = false, updatedby = 'CDM-40911', updatedon = now()
where intakenumber = 'I241012958779' and activeflag = 1;

--Removing autoselected supervisor decision to null in intakesnapshot
update intakesnapshot
set
	jsondata = jsonb_set(
		jsonb_set(
			jsonb_set(
				jsondata, '{DAType, DATypeDetail, 0, supDisposition}', 'null'::jsonb),
				'{disposition, 0, supDisposition}', 'null'::jsonb),
				'{intakeDATypeDetails, 0, supDisposition}', 'null'::jsonb),
	updatedby = 'CDM-40911', updatedon = now()
where intakenumber = 'I241012958779' and activeflag = 1;