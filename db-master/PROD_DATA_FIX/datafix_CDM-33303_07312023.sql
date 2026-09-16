-- CDM-33303 - Duplicate finding
/*
-- Issue Description: 
	CPS IR case with Duplicate Investigation finding

-- CPS-IR ID: 231020558161 - 3bba1b03-f7ee-4148-ade2-7cda7c58a945
-- Delete 
-- maltreatmentid: 54a120a8-a838-4a99-940c-7ccdbe0f346a
-- investigationallegationid: 81c30e49-0ae7-4c97-b327-43a70a4bd450

-- Category/ Module: Maltreatment/Finding (Investigation Management)
-- Root cause: Data Issue (TBD)
-- Fix Provided: Datafix has been promoted to remove the duplicate Investigation finding.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

-- To remove the wrong Investigation Finding (CDM-32712)
select activeflag, updatedby, updatedon
	from investigationmaltreatment
where maltreatmentid = '54a120a8-a838-4a99-940c-7ccdbe0f346a'
	and activeflag = 1 ;
	
update investigationmaltreatment
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CDM-33303'	
where maltreatmentid = '54a120a8-a838-4a99-940c-7ccdbe0f346a'
	and activeflag = 1 ;

select activeflag, updatedby, updatedon 
	from investigationallegation
where investigationallegationid = '81c30e49-0ae7-4c97-b327-43a70a4bd450'
	and activeflag = 1 ;
	
update investigationallegation
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CDM-33303'	
where investigationallegationid = '81c30e49-0ae7-4c97-b327-43a70a4bd450'
	and activeflag = 1 ;

select activeflag, updatedby, updatedon
	from investigationfinding
where investigationallegationid = '81c30e49-0ae7-4c97-b327-43a70a4bd450'
	and activeflag = 1 ;

update investigationfinding
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CDM-33303'	
where investigationallegationid = '81c30e49-0ae7-4c97-b327-43a70a4bd450'
	and activeflag = 1 ;
	
select activeflag, updatedby, updatedon 
	from investigationallegationmaltreators
where investigationallegationid = '81c30e49-0ae7-4c97-b327-43a70a4bd450'
	and activeflag = 1 ;

update investigationallegationmaltreators
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CDM-33303'	
where investigationallegationid = '81c30e49-0ae7-4c97-b327-43a70a4bd450'
	and activeflag = 1 ;
