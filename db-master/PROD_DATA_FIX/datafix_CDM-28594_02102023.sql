-- CDM-28594 - delete referral
/*
-- Issue Description: 
	Please delete referral

	I221010332566:duplicate referral

-- email: devonne.jefferson@maryland.gov
-- Category/ Module: Intake Referral (Intake Management) 
-- Root cause: User Error 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Intake Number: I221010332566
select routingid, objectid, activeflag , updatedby, updatedon 
	from routing
where objectid in ('I221010332566') 
	and activeflag = 1 ;
	
update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-28594'
where objectid in ('I221010332566') 
	and activeflag = 1 ;

select intakenumber, activeflag , updatedby, updatedon 
	from intakedastatus
where intakenumber in ('I221010332566') 
	and activeflag = 1 ;
	
update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-28594'
where intakenumber in ('I221010332566') 
	and activeflag = 1 ;

select intakenumber, activeflag , updatedby, updatedon 
	from intakedastaging
where intakenumber in ('I221010332566') 
	and activeflag = 1 ;
	
update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-28594'
where intakenumber in ('I221010332566') 
	and activeflag = 1 ;

select intakenumber, activeflag , updatedby, updatedon 
	from intakesnapshot
where intakenumber in ('I221010332566') 
	and activeflag = 1 ;
	
update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-28594'
where intakenumber in ('I221010332566') 
	and activeflag = 1 ;