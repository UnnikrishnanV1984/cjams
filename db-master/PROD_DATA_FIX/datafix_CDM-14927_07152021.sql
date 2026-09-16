-- CDM-14927 - Payment did not generate
/*
-- Issue Description: 
   The GAP The Agreement has been updated and Approved, however, no payment has generated.
   
-- Case ID: 3193952 - ahmun.williams@maryland.gov
-- Client ID: 3147394 (ANESHIA ROBINSON) - d86ecef3-13ab-433e-9898-bd0826a9076d
-- GAP ID: 4953 - 2018-06-07 To 2024-08-15  - ba833cc4-b980-4673-aba7-e3bdd42fe2bd
-- Provider ID: 5084311	(Pearl Wilson) 
-- PP ID: 546e15e1-2581-4194-8df7-fd15b2b48e23
   
-- Category/ Module: Accounts Payable (Finance Management)
-- Root cause: Data issue, Inactive actor id in the permanencyplan table. (Exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update permanencyplan
-- afbc037e-1753-4a39-88bb-93e8d4834058 - active
-- 45a140d4-2515-4748-9436-1aff3a2ebfbd - current Inactive

select intakeservicerequestactorid, updatedby, updatedon, servicecaseid
	from cjams.permanencyplan
where permanencyplanid = '546e15e1-2581-4194-8df7-fd15b2b48e23'
	and activeflag  = 1 ;

update cjams.permanencyplan 
set intakeservicerequestactorid = 'afbc037e-1753-4a39-88bb-93e8d4834058',
	updatedby = 'CDM-14927',
	updatedon = now()
where permanencyplanid = '546e15e1-2581-4194-8df7-fd15b2b48e23'
	and activeflag  = 1 ;
	
-- To Trigger Under Over 
select ratestartdate, rateenddate, approvalstatustypekey, approvaldate, updatedby, updatedon
	from cjams.gapratesrevision
where guardiansubsidyid = 'ba833cc4-b980-4673-aba7-e3bdd42fe2bd'
	and gapratesrevisionid  in ( 'e5af6a03-1dd7-4048-ae3c-9b5415219cb5','47e82699-7fbf-4c39-add8-e47f8982cf42')
	and activeflag = 1 ;

update cjams.gapratesrevision
set approvaldate = now(),
	updatedby = 'CDM-14927',
	updatedon = now()
where guardiansubsidyid = 'ba833cc4-b980-4673-aba7-e3bdd42fe2bd'
	and gapratesrevisionid  in ( 'e5af6a03-1dd7-4048-ae3c-9b5415219cb5','47e82699-7fbf-4c39-add8-e47f8982cf42')
	and activeflag = 1 ;
