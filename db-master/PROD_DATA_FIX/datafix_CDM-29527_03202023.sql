-- CDM-29527 - PROVIDER NOT RECIEVING SUBSIDY
/*
-- Issue Description: 
	Guardianship Assistance was approved on 12/27/2022 and the provider has not received any subsidy payment 
	specific for this child since the beginning of this case. 

-- Case ID: 3220740
-- Client ID: 200137365 (Trinity Ours) - 22fed7cb-b50a-4b2b-a4e1-f66cab7dd69d
-- GAP ID: 1007207 - 2022-11-22 to 2038-07-24 - 0ed09c67-eefd-4b75-b96b-ed690b1caf08
-- Provider ID: 6012191	(ANITA  CARTER) 
-- permanencyplanid: df860bc6-8a70-4f3d-8342-c247a1ece0e6

  
-- Category/ Module: Accounts Payable (Finance Management)
-- Root cause: Data issue, Inactive actor id in the permanencyplan table. (Exception scenario)
-- Fix Provided: Datafix has been promoted to resolve the data discrepancy (update active intakeservicerequestactorid in permanencyplan table)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update GAP permanencyplan
-- 1	973b41d1-c417-4584-9ee3-06495f1d2df0	CHILD
-- 0	a65dc4f6-5aa6-4e55-a174-5d3086171fb2	AV

select intakeservicerequestactorid, updatedby, updatedon, servicecaseid
	from cjams.permanencyplan
where permanencyplanid = 'df860bc6-8a70-4f3d-8342-c247a1ece0e6'
	and activeflag  = 1 ;

update cjams.permanencyplan 
set intakeservicerequestactorid = '973b41d1-c417-4584-9ee3-06495f1d2df0',
	updatedby = 'CDM-29527',
	updatedon = now()
where permanencyplanid = 'df860bc6-8a70-4f3d-8342-c247a1ece0e6'
	and activeflag  = 1 ;
	
-- To Trigger Under Over 
select ratestartdate, rateenddate, approvalstatustypekey, approvaldate, updatedby, updatedon
	from cjams.gapratesrevision
where gaprateid = '88d4947c-9a78-40ef-b69b-d0ed8add8dc2' ;

update cjams.gapratesrevision
set approvaldate = now(),
	updatedby = 'CDM-29527',
	updatedon = now()
where gaprateid = '88d4947c-9a78-40ef-b69b-d0ed8add8dc2' ;

