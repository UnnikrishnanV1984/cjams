-- CDM-13327 - Payment Interface Issue
/*
-- Issue Description: 
   The GAP payment is missing for April 2021 srevices. 
   
-- Case ID: 3154614 - 12eb0c8c-fe88-414f-bf46-4e27b390f916
-- Client ID: 2050792 (CHYNA ANIYA COPELAND) - b9f8337d-8e8f-494d-ae9b-bb9343c7f0e0
-- GAP ID: 1932 - 2011-10-20 to 2022-06-15 - 4a75f030-7c2e-4cc6-b8a6-5c036c2de761
-- Provider ID: 5045242 (Bonita Young) 
-- PP ID: 2322f66f-c71d-409e-bac4-280f12af8302
   
-- Category/ Module: Accounts Payable (Finance Management) 
-- Root cause: Data issue, Inactive actor id in the permanencyplan table. (Exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update permanencyplan
-- Client ID: 3477941
-- Actor ID: 13009e89-c929-4440-bb58-2d586e3df2e2 - active flag 0
-- New Actor ID: 0dc2fc2f-c054-4ff3-a252-09a308b284ee (update)

select intakeservicerequestactorid, updatedby, updatedon, servicecaseid 
	from cjams.permanencyplan  
where permanencyplanid = '2322f66f-c71d-409e-bac4-280f12af8302'
	and activeflag  = 1 ;

update cjams.permanencyplan  
	set intakeservicerequestactorid = '0dc2fc2f-c054-4ff3-a252-09a308b284ee',
		updatedby = 'CDM-13327',
		updatedon = now()	
where permanencyplanid = '2322f66f-c71d-409e-bac4-280f12af8302'
	and activeflag  = 1 ;
	
-- To Trigger Under Over -- 2020-10-20 to 2021-10-19 
select ratestartdate, rateenddate, approvalstatustypekey, approvaldate, updatedby, updatedon
	from cjams.gapratesrevision
where guardiansubsidyid = '4a75f030-7c2e-4cc6-b8a6-5c036c2de761'
	and activeflag = 1 ;

update cjams.gapratesrevision
set approvaldate = now(),
	updatedby = 'CDM-13327',
	updatedon = now()	
where guardiansubsidyid = '4a75f030-7c2e-4cc6-b8a6-5c036c2de761'
	and activeflag = 1 ;

