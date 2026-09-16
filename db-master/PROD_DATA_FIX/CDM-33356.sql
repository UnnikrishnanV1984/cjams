/*
-- Issue Description: 
	User Request to delete Intake# I231010620773 
-- Category/ Module: Intake Referral (Intake Management) 
-- Root cause: TDB 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-33356'
where intakenumber = 'I231010620773'
	and activeflag = 1 ;
	


update intakeservicerequestactor
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-33356'
where activeflag = 1
	and actorid 
		in ( select actorid 
				from actor 
			 where intakenumber = 'I231010620773' 
			);
			
		

update actor
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-33356'
where intakenumber = 'I231010620773'
	and activeflag = 1;
	


update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-33356'
where intakenumber = 'I231010620773'
	and activeflag = 1 ;