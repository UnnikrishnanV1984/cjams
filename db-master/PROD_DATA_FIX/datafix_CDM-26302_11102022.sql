-- CDM-26302 - Referral narrative disappeared
/*
-- Issue Description: 
	User Request to delete Intake# I221010332561 (Referral narrative was disappeared)
	User has created new Intake # I221010332899
	
-- Category/ Module: Intake Referral (Intake Management) 
-- Root cause: TDB 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Intake Number: I221010332561
select routingid, objectid, activeflag , updatedby, updatedon 
	from routing
where objectid = 'I221010332561'
	and activeflag = 1 ;
	
update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-26302'
where objectid = 'I221010332561'
	and activeflag = 1 ;

select intakenumber, activeflag , updatedby, updatedon 
	from intakedastatus
where intakenumber = 'I221010332561'
	and activeflag = 1 ;
	
update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-26302'
where intakenumber = 'I221010332561'
	and activeflag = 1 ;

select intakenumber, activeflag , updatedby, updatedon 
	from intakesnapshot
where intakenumber = 'I221010332561'
	and activeflag = 1 ;
	
update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-26302'
where intakenumber = 'I221010332561'
	and activeflag = 1 ;

select intakenumber, personid, intakeservicerequestpersontypekey, activeflag, updatedby, updatedon 
	from intakeservicerequestactor
where activeflag = 1
	and actorid 
		in ( select actorid 
				from actor 
			 where intakenumber = 'I221010332561' 
			);

update intakeservicerequestactor
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-26302'
where activeflag = 1
	and actorid 
		in ( select actorid 
				from actor 
			 where intakenumber = 'I221010332561' 
			);

select intakenumber, personid, activeflag , updatedby, updatedon  
	from actor 
where intakenumber = 'I221010332561'
	and activeflag = 1;

update actor
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-26302'
where intakenumber = 'I221010332561'
	and activeflag = 1;

select intakenumber, activeflag , updatedby, updatedon 
	from intakedastaging
where intakenumber = 'I221010332561'
	and activeflag = 1 ;
	
update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-26302'
where intakenumber = 'I221010332561'
	and activeflag = 1 ;

