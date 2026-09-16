/*
 * CDM-34500 - delete duplicate, made in error
 * Customer Email ID:yvette.bennerson@maryland.gov
 * Customer Name:Yvette Bennerson
 * Focus Area:Persons: Others
 * Description - I231011242408:Delete duplicate intake referral Screen URL:
 * 
 */


select routingid, objectid, activeflag , updatedby, updatedon 
	from routing
where objectid in ('I231011242408') 
	and activeflag = 1 ;
	
update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-34500'
where objectid in ('I231011242408') 
	and activeflag = 1 ;

select intakenumber, activeflag , updatedby, updatedon 
	from intakedastatus
where intakenumber in ('I231011242408') 
	and activeflag = 1 ;
	
update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-34500'
where intakenumber in ('I231011242408') 
	and activeflag = 1 ;

select intakenumber, activeflag , updatedby, updatedon 
	from intakedastaging
where intakenumber in ('I231011242408') 
	and activeflag = 1 ;
	
update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-34500'
where intakenumber in ('I231011242408') 
	and activeflag = 1 ;

select intakenumber, activeflag , updatedby, updatedon 
	from intakesnapshot
where intakenumber in ('I231011242408') 
	and activeflag = 1 ;
	
update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-34500'
where intakenumber in ('I231011242408') 
	and activeflag = 1 ;
	