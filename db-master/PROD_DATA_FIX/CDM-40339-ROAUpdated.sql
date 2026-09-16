/*
Issue Description: Please do a data fix to remove the supervisor decision, so that the supervisor can screen in again
Category/Module: Error
Root cause: ROA CPS info wasn't entered before approval so decision needs to be reverted to review
Fix provided: DB query to revert the decision back to review
Code/Data fix ticket#: CDM-40339
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Page working as intended
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--Reverting decision to review in routing
update routing 
set routingstatustypeid = 1, activeflag = 1, intakerecommendation = 'Scrnin', supervisordecision = null, updatedby = 'CDM-40339', updatedon = now()
where routingid = 'd6af2bd1-a8f2-443a-9b63-c434c3f387b0';

--Setting case as pending in intakedastaging
update intakedastaging
set status = 'pending', ispreintake = false, updatedby = 'CDM-40339', updatedon = now()
where intakenumber = 'I241012806737' and activeflag = 1;

--Removing autoselected supervisor decision to null in intakesnapshot
update intakesnapshot
set
	jsondata = jsonb_set(
		jsonb_set(
			jsonb_set(
				jsondata, '{DAType, DATypeDetail, 0, supDisposition}', 'null'::jsonb),
				'{disposition, 0, supDisposition}', 'null'::jsonb),
				'{intakeDATypeDetails, 0, supDisposition}', 'null'::jsonb),
	updatedby = 'CDM-40339', updatedon = now()
where intakenumber = 'I241012806737' and activeflag = 1;