
/*
   Issue Description: CDM-28595
   Category/ Module  :intake referral
   Root cause: User wants to remove duplicate referral
   Reason why no related code fix:  Data fix
   PR # : 7940
*/
update
	intakedastaging
set
	activeflag = 0,
	updatedby = 'CDM-28595',
	updatedon = now()
where
	intakenumber = 'I221010313236'
	and activeflag = '1';

update
	intakedastatus
set
	activeflag = 0,
	updatedby = 'CDM-28595',
	updatedon = now()
where
	intakenumber = 'I221010313236'
	and activeflag = '1'
	and intakedastatusid = '6773317f-e695-4b42-b968-dc301022a187';