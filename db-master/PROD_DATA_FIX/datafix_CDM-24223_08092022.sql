-- CDM-24223 - S20220216042916 - URGENT
/*
-- Issue Description: 
   Permanency Plan Approval Issue 
   
-- Case ID: 3169337 - e71d21d0-d979-4b4d-808d-0ece6e9e50ae
-- Client ID: 4425807 (AURORA YEAGER) - 0a65ae29-b257-4234-bede-e57821e48fb4
-- permanencyplanid: 2020-10-21 To 2022-07-22 -  '486b0874-1673-4fef-86f5-bf6aa1fdc5f1'
   
-- Category/ Module: Accounts Payable (Finance Management)
-- Root cause: Data Migration issue, intakeservicerequestactorid and intakeserviceid are missing in the permanencyplan table. (Exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update permanencyplan
select establisheddate, enddate, intakeservicerequestactorid, intakeserviceid, updatedby, updatedon 
	from permanencyplan  
where permanencyplanid = '486b0874-1673-4fef-86f5-bf6aa1fdc5f1'
	and activeflag = 1 ;

-- 27fb091d-63fe-4d6c-8787-749eb9a13809 (CHILD)
update cjams.permanencyplan 
set intakeservicerequestactorid = '27fb091d-63fe-4d6c-8787-749eb9a13809',
	intakeserviceid = '2f66b1ed-db6e-443c-8dcb-9f8ad2a82cbf', -- CW10214786
	updatedby = 'CDM-24223',
	updatedon = now()
where permanencyplanid = '486b0874-1673-4fef-86f5-bf6aa1fdc5f1'
	and activeflag = 1 ;
