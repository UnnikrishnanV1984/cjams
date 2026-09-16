-- Removing the living arrangment and Rejected Placement records
update cjams.placement  
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CDM-11983'
where placementid in ('936dbe78-20fd-4201-806b-9a5a25162a40','a28c4810-3cc9-4e6b-8bae-4d3e8f3804c6')
	and activeflag  = 1 ;

update cjams.placementrevision 
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CDM-11983'
where placementid in ('936dbe78-20fd-4201-806b-9a5a25162a40','a28c4810-3cc9-4e6b-8bae-4d3e8f3804c6')
	and activeflag  = 1 ;

update cjams.livingarrangement  
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CDM-11983'
where placementid in ('936dbe78-20fd-4201-806b-9a5a25162a40','a28c4810-3cc9-4e6b-8bae-4d3e8f3804c6')
	and activeflag  = 1 ;    


-- Removing the enddate so that user can void the placment
update cjams.placement  
set enddatetime = null, 
	endtime = null, 
	exitreasontypekey = null,
	exittypekey = null,
	updatedon = now(), 
	updatedby = 'CDM-11983'
where placementid = '19f29429-4f4b-4fdc-99dd-950f58b7f025'
	and activeflag  = 1 ;


update cjams.placementrevision  
set exitdate = null, 
	exittime = null, 
	exitreasontypkey = null,
	exittypekey = null,
	updatedon = now(), 
	updatedby = 'CDM-11983'
where placementid = '19f29429-4f4b-4fdc-99dd-950f58b7f025' 
	and exitdate is not null ;