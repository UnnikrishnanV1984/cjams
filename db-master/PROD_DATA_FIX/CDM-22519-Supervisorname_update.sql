-- CDM-22519 - Name wrong on program assignment closure
/*
-- Issue Description: 
   Supervisor Ronda Lewis program assigned Aux/ROA however it was showing up Diana Donoho.Should display updated by as Ronda Lewis
   
-- Case ID: 3301025

*/

-- Datafix to fix the updatedby usre name
-- personprogramid: IHSFP - 59272162-022e-4970-a6ff-4fee2de028ab
-- In-Home Services/Family Preservation	- Consolidated Services

select programkey, startdate, enddate, updatedby, updatedon
	from cjams.personprogramarea 
where personprogramid = '52406b13-4a62-4c99-90ba-b6d7e042ac91'
	and activeflag = 1 ;

update cjams.personprogramarea 
	set updatedby = '299210ac-c6df-4985-a02b-bdeda0cdad67', -- Ronda Lewis
		updatedon = now()
where personprogramid = '52406b13-4a62-4c99-90ba-b6d7e042ac91'
	and activeflag = 1 ;