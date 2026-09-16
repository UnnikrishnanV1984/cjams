-- CDM-22511 - Incorrect Program Area
/*
-- Issue Description: 
   User request to delete the incorrect CPS Program Areas 
   Inactive CPS - servicerequestnumber: 221020215647 - a8a2de25-7305-4492-b824-2708ed2eeab1

-- Category/ Module: Program Assignment (Case Management) 
-- Root cause: TBD
-- Pull request# TBD
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

-- Datafix to to delete the incorrect CPS Program Areas 
-- Inactive CPS ID: 221020215647
select programkey, subprogramkey, startdate, enddate, activeflag, updatedby, updatedon, personprogramid
	from cjams.personprogramarea 
where objectid = 'a8a2de25-7305-4492-b824-2708ed2eeab1'
	and activeflag = 1 ;

update cjams.personprogramarea 
set enddate = startdate,
	activeflag = 0,
	updatedby = 'CDM-22511',
	updatedon = now()
where objectid = 'a8a2de25-7305-4492-b824-2708ed2eeab1'
	and activeflag = 1 ;
