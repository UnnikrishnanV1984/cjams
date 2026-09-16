-- CDM-16203 - Removal dates
/*
-- Issue Description: 
   User Request to Void the Removal, OOH and Placement of duplicate Client on teh Service Case

-- Case ID: 3151160
-- Client ID: 200139056	(Deniesha Lindsay) - d125386e-8750-4966-96fc-9613ee86ee5b
-- Placement ID: 1558005 - 2020-07-27 To 2020-07-28 - d3321c60-ecff-49d8-bee0-b9776e3a46db
-- Provider ID: 5071644 (Maria Kovacs)

-- Removal
-- 250673 - 2020-07-27 To 2020-07-28 - bc3389d0-6a8c-4b62-a87b-6e539dced94b

-- Category/ Module: Placements  (Case Management) 
-- Root cause: Currently CJAMS is not allowing the users to modify the placement dates after the exit.
-- Pull request# TDB
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: TDB
*/

-- Update OOH Dates same as Removal Dates

-- Update OOH
select startdate, enddate, programkey, updatedby, updatedon 
	from personprogramarea  
where personprogramid = 'dd584d9f-7fcc-4362-907e-ceb1ae265f73'
	and activeflag = 1 ;

update personprogramarea
set startdate = '2020-07-27 00:00:00',
	enddate = '2020-07-27 00:00:00',
	updatedby = 'CDM-16203_1',
	updatedon = now()
where personprogramid = 'dd584d9f-7fcc-4362-907e-ceb1ae265f73'
	and activeflag = 1 ;
