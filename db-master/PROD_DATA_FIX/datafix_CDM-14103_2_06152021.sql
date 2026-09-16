-- CDM-14103 - Duplicate placement
/*
-- Issue Description: 
   User request delete the living arrangement (Placement)
   
-- Case ID: 3299979 - markeita.matthews@maryland.gov
-- Client ID: 4389600 (JASHON MOSWENN) - 8bcaabf9-d5bc-4cd9-afdb-85a6062291bb
-- LA Placement ID: 1557415 - 2020-09-01  To Current - 1ecec216-a7a1-4512-a0da-4d122c0dc982

-- Category/ Module: Living Arrangement (Case Management) 
-- Root cause: User error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select activeflag, alternateid, placementtypekey, startdatetime, enddatetime, updatedby, updatedon
	from placement 
where placementid = '1ecec216-a7a1-4512-a0da-4d122c0dc982'
	and activeflag = 1 ;

update placement 
set activeflag = 0,
	enddatetime = startdatetime,
	updatedby = 'CDM-14103_2',
	updatedon = now()
where placementid = '1ecec216-a7a1-4512-a0da-4d122c0dc982'
	and activeflag = 1 ;
	
select activeflag, entrydate, exitdate, updatedby, updatedon 
	from placementrevision 
where placementid = '1ecec216-a7a1-4512-a0da-4d122c0dc982'
	and activeflag  = 1 ;

update placementrevision 
set activeflag = 0,
	exitdate = entrydate,
	updatedby = 'CDM-14103_2',
	updatedon = now()
where placementid = '1ecec216-a7a1-4512-a0da-4d122c0dc982'
	and activeflag = 1 ;
	
-- No data in the livingarrangement & routing tables	

