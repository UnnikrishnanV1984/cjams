-- CDM-14103 - Duplicate placement
/*
-- Issue Description: 
   User request delete the living arrangement (Placement)
   
-- Case ID: 3299979 - markeita.matthews@maryland.gov
-- Client ID: 4389601 (NAZIR DENNIS) - e4eb4fbd-5152-4139-b44d-47c809822f96
-- LA Placement ID: 1558752 - 2020-10-19 To Current - c0bf90cf-1297-4d2a-b25b-6b92f3369c1a

-- Category/ Module: Living Arrangement (Case Management) 
-- Root cause: User error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select activeflag, alternateid, placementtypekey, startdatetime, enddatetime, updatedby, updatedon
	from placement 
where placementid = 'c0bf90cf-1297-4d2a-b25b-6b92f3369c1a'
	and activeflag = 1 ;

update placement 
set activeflag = 0,
	enddatetime = startdatetime,
	updatedby = 'CDM-14103',
	updatedon = now()
where placementid = 'c0bf90cf-1297-4d2a-b25b-6b92f3369c1a'
	and activeflag = 1 ;
	
select activeflag, entrydate, exitdate, updatedby, updatedon 
	from placementrevision 
where placementid = 'c0bf90cf-1297-4d2a-b25b-6b92f3369c1a'
	and activeflag  = 1 ;

update placementrevision 
set activeflag = 0,
	exitdate = entrydate,
	updatedby = 'CDM-14103',
	updatedon = now()
where placementid = 'c0bf90cf-1297-4d2a-b25b-6b92f3369c1a'
	and activeflag = 1 ;
	
-- No data in the livingarrangement & routing tables	

