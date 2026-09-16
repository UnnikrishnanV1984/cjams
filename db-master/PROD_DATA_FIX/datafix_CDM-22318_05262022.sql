-- CDM-22318 - Name wrong on program assignment closure
/*
-- Issue Description: 
   Ronda Lewis closed the program assignment on 4/5/2022, however it is showing up that Sherrie Ford
   
-- Case ID: 221030014166
-- Client ID: 1053856 (MELISSA R CURRENCE) - 0c9729a7-370b-4300-a87c-027872a42524
-- personprogramid: IHSFP - 2022-04-05 To 2022-04-05 - 28e00670-3b03-4360-aa8f-bf9a17e15a9c
-- In-Home Services/Family Preservation	- Consolidated Services
-- Coreect User: 299210ac-c6df-4985-a02b-bdeda0cdad67 Ronda Lewis
-- Worng User: e9ff2da6-3f06-4123-9788-acc6117867e0	Sherrie Ford

-- Category/ Module: Program Assignment (Case Management) 
-- Root cause: TBD
-- Pull request# TBD
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TBD
*/

-- Datafix to fix the updatedby usre name
-- personprogramid: IHSFP - 2022-04-05 To 2022-04-05 - 28e00670-3b03-4360-aa8f-bf9a17e15a9c
-- In-Home Services/Family Preservation	- Consolidated Services

select programkey, startdate, enddate, updatedby, updatedon
	from cjams.personprogramarea 
where personprogramid = '28e00670-3b03-4360-aa8f-bf9a17e15a9c'
	and activeflag = 1 ;

update cjams.personprogramarea 
	set updatedby = '299210ac-c6df-4985-a02b-bdeda0cdad67', -- Ronda Lewis
		updatedon = now()
where personprogramid = '28e00670-3b03-4360-aa8f-bf9a17e15a9c'
	and activeflag = 1 ;
