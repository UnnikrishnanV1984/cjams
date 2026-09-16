/*
 * CDM-36717 - Deleting a Intake
 * Customer Email ID:lamon.anderson@maryland.gov
 * delete this intake : I241012019263
 * Description - I241012019263:Please Delete this Intake as it has the incorrect person involved.
 * 
 */

-- Delete Intake Number: I241012019263
select routingid, objectid, activeflag , updatedby, updatedon 
	from routing
where objectid in ('I241012019263') 
	and activeflag = 1 ;
	
update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-36717'
where objectid in ('I241012019263') 
	and activeflag = 1 ;

select intakenumber, activeflag , updatedby, updatedon 
	from intakedastatus
where intakenumber in ('I241012019263') 
	and activeflag = 1 ;
	
update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-36717'
where intakenumber in ('I241012019263') 
	and activeflag = 1 ;

select intakenumber, activeflag , updatedby, updatedon 
	from intakedastaging
where intakenumber in ('I241012019263') 
	and activeflag = 1 ;
	
update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-36717'
where intakenumber in ('I241012019263') 
	and activeflag = 1 ;

select intakenumber, activeflag , updatedby, updatedon 
	from intakesnapshot
where intakenumber in ('I241012019263') 
	and activeflag = 1 ;
	
update intakesnapshot
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-36717'
where intakenumber in ('I241012019263') 
	and activeflag = 1 ;
	