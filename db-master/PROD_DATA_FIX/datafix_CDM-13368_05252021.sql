-- CDM-13368 - Service Log Can Not Be Submitted
/*
-- Issue Description: 
    Child the OOH Program Assignment is end dated even though the Child removal is not end dated. 
	This prevent user from creating a Service from 5/28/2020 with an end date in 2021.
	Need to remove the OOH Program assignment end date.
   
-- Case ID: 3251793 - tyshea.shields1@maryland.gov
-- Client ID: 1875367 (SYRAI Y KNIGHT) - cf1e3848-1e44-47f9-81e6-0e5033059e01
-- Program Assignment: OOH	- 05/28/2020 To 08/09/2020 - f3d95d21-5cdf-492c-9ea6-fe13959c16a0

-- Category/ Module: Service Log  (Case Management) 
-- Root cause: Data issue; Active Removal/Placement with closed OOH Program Assignment.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Active Removal/Placement with closed OOH Program Assignment.
-- Datafix to re-open the OOH Program Assignment
select personid, programkey, startdate, enddate, updatedby, updatedon, activeflag 
	from personprogramarea 
where personprogramid = 'f3d95d21-5cdf-492c-9ea6-fe13959c16a0' 
	and activeflag = 1;

update personprogramarea
set enddate = null,
	updatedby = 'CDM-13368',
	updatedon = now()
where personprogramid = 'f3d95d21-5cdf-492c-9ea6-fe13959c16a0' 
	and activeflag = 1;

	