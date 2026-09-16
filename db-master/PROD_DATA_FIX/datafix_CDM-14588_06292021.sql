-- CDM-14588 - Permanency plan needs fixed
/*
-- Issue Description: 
   The Guardianship by Relative Permanency plan was end dated by the worker 
   The end date needs to be deleted so that the GAP subsidy can be processed and generated. 
   
-- Case ID: 3300769 - eb307440-7fb4-47b5-9d8a-034a62940da8
-- Client ID: 4394809 (SEMAJ WARD) - 9472fd60-6177-42ff-a56c-aaa15a1dcf7e
-- PP ID: 9ec1dd56-b0c5-42c9-87da-909dae30d9a9
   
-- Category/ Module: Accounts Payable (Finance Management)
-- Root cause: Data issue, Inactive actor id in the permanencyplan table. (Exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update permanencyplan end date as null

select establisheddate, enddate, approvalstatustypekey, updatedby, updatedon 
	from permanencyplan
where permanencyplanid = '9ec1dd56-b0c5-42c9-87da-909dae30d9a9'
and activeflag  = 1 ;

update permanencyplan 
set enddate = null,
	updatedby = 'CDM-14588',
	updatedon = now()
where permanencyplanid = '9ec1dd56-b0c5-42c9-87da-909dae30d9a9'
	and activeflag  = 1 ;

