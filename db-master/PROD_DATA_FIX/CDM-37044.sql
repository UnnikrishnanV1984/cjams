/*
 * CDM-37044 - Duplicate Referral
 * Customer Email ID:meagan.watt1@maryland.gov
 * Description - I231011817850:There was a CJAMS error during entry and a new referral was entered. This referral can be deleted
 * Remove the Intake I231011817850 with status In-Progress as requested.
 *
 */

-- Delete Intake Number: I231011817850
select routingid, objectid, activeflag , updatedby, updatedon 
	from routing
where objectid in ('I231011817850') 
	and activeflag = 1 ;
	
update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-37044'
where objectid in ('I231011817850') 
	and activeflag = 1 ;

select intakenumber, activeflag , updatedby, updatedon 
	from intakedastatus
where intakenumber in ('I231011817850') 
	and activeflag = 1 ;
	
update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-37044'
where intakenumber in ('I231011817850') 
	and activeflag = 1 ;

select intakenumber, activeflag , updatedby, updatedon 
	from intakedastaging
where intakenumber in ('I231011817850') 
	and activeflag = 1 ;
	
update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-37044'
where intakenumber in ('I231011817850') 
	and activeflag = 1 ;

select intakenumber, activeflag , updatedby, updatedon 
	from intakesnapshot
where intakenumber in ('I231011817850') 
	and activeflag = 1 ;
	
update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-37044'
where intakenumber in ('I231011817850') 
	and activeflag = 1 ;
	