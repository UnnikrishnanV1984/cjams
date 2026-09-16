/*
 Issue Description:CDM-44101
 Category/ Module:delete intake referral
 Root cause: delete
 Pull request# N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/

--No active records avaialble in routing, intakesnapshot, intakeservicerequest
update intakedastaging 
	set activeflag = 0, 
		updatedby = 'CDM-44101', 
		updatedon = now()
	where intakenumber = 'I251013215546' and activeflag=1;

update intakedastatus 
	set 
		activeflag = 0,
		updatedby = 'CDM-44101',
		updatedon = now()
	where intakenumber = 'I251013215546' and activeflag=1;