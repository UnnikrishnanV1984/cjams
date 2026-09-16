-- CDM-20942 - Case Needs Expunged
/*
-- Issue Description: 
	User Request to delete referral I221010247463 
	A new referral has been entered to take it's place. 
	This is with approval from SSA.


-- Category/ Module: Intake Referral (Intake Management) 
-- Root cause: User Error 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Intake Number: I221010247463
select routingid, objectid, activeflag , updatedby, updatedon 
	from routing
where objectid = 'I221010247463'
	and activeflag = 1 ;
	
update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-20942'
where objectid = 'I221010247463'
	and activeflag = 1 ;

select intakenumber, activeflag , updatedby, updatedon 
	from intakedastatus
where intakenumber = 'I221010247463'
	and activeflag = 1 ;
	
update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-20942'
where intakenumber = 'I221010247463'
	and activeflag = 1 ;

select intakenumber, activeflag , updatedby, updatedon 
	from intakedastaging
where intakenumber = 'I221010247463'
	and activeflag = 1 ;
	
update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-20942'
where intakenumber = 'I221010247463'
	and activeflag = 1 ;

select intakenumber, activeflag , updatedby, updatedon 
	from intakesnapshot
where intakenumber = 'I221010247463'
	and activeflag = 1 ;
	
update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-20942'
where intakenumber = 'I221010247463'
	and activeflag = 1 ;
