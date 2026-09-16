-- CDM-18188 - partial payment
/*
-- Issue Description:
	The following providers are receiving a partial or no payment. 
	The Annual Agreement has been approved (10/22/2021) 
	but is showing in Review in the agreement section.
   
-- Category/ Module: Guardianship Assistance Program  (Case Management) 
-- Root cause: Code Deployed Issue; was fixed & deployed on Prod 10/22
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

/*
-- Case ID: 3185593
-- Client ID: 2370369 (KEITH WILLIAM FREEMAN) - bc523491-cceb-4611-bbc3-a4a258fbcafa
-- GAP ID: 1912 - 2011-10-18 To 2026-09-14 - 449f0183-62ec-4a24-8f80-81233bd70c61
-- Provider ID: 5049094 (Sharon Bell)
-- GAP Agreement ID: 5dfc4f3f-6eae-420b-9383-e259b97c4ea7 
-- gapagreementrateid: 6407a98a-2e60-4b4d-8fcb-6b6ac0338371 
*/

-- Soft-delete GAP Rate in Review
select activeflag, startdate, enddate, rateapprovaldate, paymentamout, status , updatedby, updatedon 
	from gapagreementrate 
where gapagreementrateid = '6407a98a-2e60-4b4d-8fcb-6b6ac0338371'
	and lower(status) = 'review' 
	and activeflag = 1 ;

update gapagreementrate 
set activeflag = 0,
	updatedby = 'CDM-18188',
	updatedon = now()
where gapagreementrateid = '6407a98a-2e60-4b4d-8fcb-6b6ac0338371'
	and lower(status) = 'review' 
	and activeflag = 1 ;
