/*
 * CDM-37807 - Deleting a Intake
 * Customer Email ID:leah.borkowski2@maryland.gov
 * Root cause: user wants to delete this intake I241012086248
 * Fix: data fix promoted to delete intake.
 */

-- Delete Intake Number: I241012086248
select routingid, objectid, activeflag , updatedby, updatedon 
	from routing
where objectid in ('I241012086248') 
	and activeflag = 1 ;

-- Backup
select intakenumber, activeflag , updatedby, updatedon 
	from intakedastatus
where intakenumber in ('I241012086248') 
	and activeflag = 1 ;

-- Update
update intakedastatus
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-37870'
where intakenumber in ('I241012086248') 
	and activeflag = 1 ;

-- Backup
select intakenumber, activeflag , updatedby, updatedon 
	from intakedastaging
where intakenumber in ('I241012086248') 
	and activeflag = 1 ;

-- Update	
update intakedastaging
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-37870'
where intakenumber in ('I241012086248') 
	and activeflag = 1 ;

select intakenumber, activeflag , updatedby, updatedon 
	from intakesnapshot
where intakenumber in ('I241012086248') 
	and activeflag = 1 ;