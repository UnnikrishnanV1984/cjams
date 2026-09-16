/*
-- Issue Description: 
	Please delete referral

The referral number is I251013323669. 
-- email: selina.henry@montgomerycountymd.gov
-- Category/ Module: Intake Referral (Intake Management) 
-- Root cause: User Error 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

/*
select routingid, objectid, activeflag , updatedby, updatedon 
	from routing
where objectid in ('I251013323669') 
	and activeflag = 1 ;
*/

update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-60825'
where objectid in ('I251013323669') 
	and activeflag = 1 ;

/*select intakenumber, activeflag , updatedby, updatedon 
	from intakedastatus
where intakenumber in ('I251013323669') 
	and activeflag = 1 ;
	*/
update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-60825'
where intakenumber in ('I251013323669') 
	and activeflag = 1 ;

/*
select intakenumber, activeflag , updatedby, updatedon 
	from intakedastaging
where intakenumber in ('I251013323669') 
	and activeflag = 1 ;
*/
	
update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-60825'
where intakenumber in ('I251013323669') 
	and activeflag = 1 ;
/*
select intakenumber, activeflag , updatedby, updatedon 
	from intakesnapshot
where intakenumber in ('I251013323669') 
	and activeflag = 1 ;
	*/
update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-60825'
where intakenumber in ('I251013323669') 
	and activeflag = 1 ;

--select * from intakeservicerequest where intakenumber = 'I251013323669' and activeflag = 1 ;

update intakeservicerequest
set activeflag = 0,
	updatedby = 'CJAMS-60825',
	updatedon = now()
where intakenumber = 'I251013323669' and activeflag = 1 ;