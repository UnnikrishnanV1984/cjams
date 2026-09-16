-- CDM-28070 - clear intake 
/*
-- Issue Description: 
	Please delete these intakes from user tree.

	I221010306371
	I211010204057


-- Category/ Module: Intake Referral (Intake Management) 
-- Root cause: User Error 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Intake Number: I221010306371, I211010204057
select routingid, objectid, activeflag , updatedby, updatedon 
	from routing
where objectid in ('I221010306371', 'I211010204057') 
	and activeflag = 1 ;
	
update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-28070'
where objectid in ('I221010306371', 'I211010204057') 
	and activeflag = 1 ;

select intakenumber, activeflag , updatedby, updatedon 
	from intakedastatus
where intakenumber in ('I221010306371', 'I211010204057') 
	and activeflag = 1 ;
	
update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-28070'
where intakenumber in ('I221010306371', 'I211010204057') 
	and activeflag = 1 ;

select intakenumber, activeflag , updatedby, updatedon 
	from intakedastaging
where intakenumber in ('I221010306371', 'I211010204057') 
	and activeflag = 1 ;
	
update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-28070'
where intakenumber in ('I221010306371', 'I211010204057') 
	and activeflag = 1 ;

select intakenumber, activeflag , updatedby, updatedon 
	from intakesnapshot
where intakenumber in ('I221010306371', 'I211010204057') 
	and activeflag = 1 ;
	
update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-28070'
where intakenumber in ('I221010306371', 'I211010204057') 
	and activeflag = 1 ;