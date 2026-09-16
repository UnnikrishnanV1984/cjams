/*
 * CDM-34235 - Error
 * Customer Email ID:chelsey.miller@maryland.gov
 * Customer Name:Chelsey Miller
 * Description - Dashboard:A CPS referral was accidentally started instead of an APS referral. Referral #: I231011161039
 * Need data fix to delete the intake.
 * 
 */


select routingid, objectid, activeflag , updatedby, updatedon 
	from routing
where objectid in ('I231011161039') 
	and activeflag = 1 ;
	
update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-34235'
where objectid in ('I231011161039') 
	and activeflag = 1 ;

select intakenumber, activeflag , updatedby, updatedon 
	from intakedastatus
where intakenumber in ('I231011161039') 
	and activeflag = 1 ;
	
update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-34235'
where intakenumber in ('I231011161039') 
	and activeflag = 1 ;

select intakenumber, activeflag , updatedby, updatedon 
	from intakedastaging
where intakenumber in ('I231011161039') 
	and activeflag = 1 ;
	
update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-34235'
where intakenumber in ('I231011161039') 
	and activeflag = 1 ;

select intakenumber, activeflag , updatedby, updatedon 
	from intakesnapshot
where intakenumber in ('I231011161039') 
	and activeflag = 1 ;
	
update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-34235'
where intakenumber in ('I231011161039') 
	and activeflag = 1 ;