-- CJAMS-62007  SHAKUR SMITH#2640214- PAYMENTS
/*
-- Issue Description: 
	Incorrect Provider on the most recent GAP rate 
    
-- Case ID: 3286264
-- Provider ID: 2640214	(SHAKUR SMITH)

--1) Remove the open suspension with start date is 12/02/2024
--2) Update the current  auto suspension start date from 01/02/2025 to 12/02/2024
-- Category/ Module: GAP (Case Management) 
-- Root cause: User requested to change the start and remove the  open suspension with start date is 12/02/2024
-- Fix Provided: Datafix has been promoted to fix the GAP Rate and ned date the suspension. 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

--Update the current  auto suspension start date from 01/02/2025 to 12/02/2024
update gapsuspension
set startdate = '2024-12-02 05:00:00.000',
	updatedby = 'CJAMS-62007',
	updatedon = now()	
where gapsuspensionid  = '6da6d658-53e9-4018-a3d9-42f6f6fb2e66' 
	and activeflag = 1 ;
	
update gapsuspensionrevision
set startdate = '2024-12-02 05:00:00.000',
	approvaldate = now(),	
	updatedby = 'CJAMS-62007',
	updatedon = now()
where suspensionid  = '6da6d658-53e9-4018-a3d9-42f6f6fb2e66' ;

--Remove the open suspension with start date is 12/02/2024

update gapsuspension
set activeflag = 0,
	updatedby = 'CJAMS-62007',
	updatedon = now()	
where gapsuspensionid  = 'd31aedb7-64d4-4c0d-9601-f63aea6c9982' 
	and activeflag = 1 ;
	
update gapsuspensionrevision
set activeflag = 0,
	approvaldate = now(),	
	updatedby = 'CJAMS-62007',
	updatedon = now()
where suspensionid  = 'd31aedb7-64d4-4c0d-9601-f63aea6c9982' ;

