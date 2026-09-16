-- CDM-29624 - Overpayment on the CJAMS system
/*
-- Issue Description: 
	It seems that the rate for the previous GAP year was updated on 02/01/2022. 
	This caused the A/R to be generated for the 3 months.

-- Case ID: 3224116
-- Client ID: 3115319 (JAHEIM BROOKS) - 93218f28-9389-4a8d-9580-0bc5db77e389
-- GAP ID: 3986 - 2015-10-06 To 2027-02-13 - 49127762-8a0e-431e-883e-96c7b6ea88be
-- Provider ID: 5072071	(Valerie D Bertley) 
 
-- Category/ Module: Accounts Payable (Finance Management)
-- Root cause: The prior ticket # CDM-10617 fix was wrong and due to which these incorrect ARs are generated.
-- Fix Provided: Datafix has been promoted to trigger the Finance under over batch and re-calculate the payments for this GAP and generate the system adjustment payments against those wrong ARs.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To Trigger Under Over 
select ratestartdate, rateenddate, approvalstatustypekey, approvaldate, updatedby, updatedon
	from cjams.gapratesrevision
where guardiansubsidyid  = '49127762-8a0e-431e-883e-96c7b6ea88be'
	and approvalstatustypekey = '3047'
	and activeflag  = 1
	and gapratesrevisionid  in ( 
				'68434113-e559-455a-8108-3e2359335aed',
				'363c8d0e-e4ea-4d49-9586-a7b222aee31f',
				'e05431a9-2328-40d5-bd9f-2fdeacc24f90',
				'0175ff14-8a78-47b0-bf4d-c476289c0843',
				'e189ecdf-b8ad-4c48-aa25-4fec3f2a70ae',
				'a7096acc-ff11-4ad9-8b07-ed64f8a1f83a',
				'60381c15-eafc-4ca3-9355-0224f4a64798',
				'5e334170-bf96-429f-a676-191745286abb',
				'140938b6-8b2b-4350-8790-4060b6812317' 
				) ;

update cjams.gapratesrevision
set approvaldate = now(),
	updatedby = 'CDM-29624',
	updatedon = now()
where guardiansubsidyid  = '49127762-8a0e-431e-883e-96c7b6ea88be'
	and approvalstatustypekey = '3047'
	and activeflag  = 1
	and gapratesrevisionid  in ( 
				'68434113-e559-455a-8108-3e2359335aed',
				'363c8d0e-e4ea-4d49-9586-a7b222aee31f',
				'e05431a9-2328-40d5-bd9f-2fdeacc24f90',
				'0175ff14-8a78-47b0-bf4d-c476289c0843',
				'e189ecdf-b8ad-4c48-aa25-4fec3f2a70ae',
				'a7096acc-ff11-4ad9-8b07-ed64f8a1f83a',
				'60381c15-eafc-4ca3-9355-0224f4a64798',
				'5e334170-bf96-429f-a676-191745286abb',
				'140938b6-8b2b-4350-8790-4060b6812317' 
				) ;