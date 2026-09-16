/*
-- CDM-15227

-- Issue Description: 
	Intake referral is not opening 
	   
-- Reverting the intake approval as requested by the user
*/

update routing
set routingstatustypeid  = 1,
activeflag = 1,
updatedon = now(),
updatedby = 'CDM-15227'
where objectid = 'I211010175127';

update intakedastatus
set status = 1,
updatedon = now(),
updatedby = 'CDM-15227'
where intakenumber = 'I211010175127';

update intakedastaging
set status = 'pending',
ispreintake = FALSE,
updatedon = now(),
updatedby = 'CDM-15227'
where intakenumber = 'I211010175127';

update intakesnapshot
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-15227'
where intakenumber = 'I211010175127';

