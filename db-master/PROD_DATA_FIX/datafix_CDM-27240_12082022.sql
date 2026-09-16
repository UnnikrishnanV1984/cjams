-- CDM-27240 - Reopen Case
/*
-- Issue Description: 
   Data issue with Re-open Service case

-- Case ID: 3194990 - 6bfa107d-2204-48af-8c62-da3b121c7ace
-- Client ID: 3178861 (SHANICE MELODY HAMMOND) - 54d5718c-dce6-43c2-9f85-ab55e417788c
-- Placement ID: 1564484 - 2021-01-01 To Current - 607a7332-1936-407f-a1ed-4ac9a028ea0b

-- Category/ Module: Servicecase Decision (Case Management) 
-- Root cause: User error, case was closed with active placement
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

-- Revision
-- to re-open OOH - 10/21/2017 to 11/15/2022 - db046392-9365-4126-8734-80b9cb45d2a5 
*/

-- Update Service case status
select servicecasenumber, statustypekey, enddate, dispositioncode, activeflag, updatedby, updatedon 
	from servicecase 
where servicecasenumber = '3194990' 
	and activeflag = 1 ;

update servicecase 
set statustypekey = 'Open', 
    dispositioncode = 'Open', 
    enddate = null, 
    updatedby = 'CDM-27240',
    updatedon = now() 
where servicecasenumber = '3194990' 
	and activeflag = 1 ;

-- Re-open OOH
select programkey, startdate, enddate, updatedby, updatedon
	from cjams.personprogramarea 
where personprogramid = 'db046392-9365-4126-8734-80b9cb45d2a5'
	and activeflag = 1 ;

update cjams.personprogramarea 
set enddate = Null, 
	updatedby = 'CDM-27240',
	updatedon = now()
where personprogramid = 'db046392-9365-4126-8734-80b9cb45d2a5'
	and activeflag = 1 ;