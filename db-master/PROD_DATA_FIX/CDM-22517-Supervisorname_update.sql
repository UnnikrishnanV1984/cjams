-- CDM-22517 - Name wrong on program assignment closure
/*
-- Issue Description: 
   Supervisor Ronda Lewis program assigned Aux/ROA however it was showing up Diana Donoho.Should display updated by as Ronda Lewis
   
-- Case ID: 3301025
-- Client ID: 1053856 (MELISSA R CURRENCE) - 0c9729a7-370b-4300-a87c-027872a42524
*/

-- Datafix to fix the updatedby usre name
-- personprogramid: IHSFP - 59272162-022e-4970-a6ff-4fee2de028ab
-- In-Home Services/Family Preservation	- Consolidated Services

select programkey, startdate, enddate, updatedby, updatedon
	from cjams.personprogramarea 
where personprogramid = '59272162-022e-4970-a6ff-4fee2de028ab'
	and activeflag = 1 ;

update cjams.personprogramarea 
	set updatedby = '299210ac-c6df-4985-a02b-bdeda0cdad67', -- Ronda Lewis
		updatedon = now()
where personprogramid = '59272162-022e-4970-a6ff-4fee2de028ab'
	and activeflag = 1 ;