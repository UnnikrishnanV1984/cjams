-- CDM-17988 - GAP Approval
/*
-- Issue Description: 
   GAP RATE Approval Issue for James Watkins-Case #3185967 
   The system is not allowing Crystal Stewart, supervisor to approve the rate change. 
   It's continues to show "Review".
   
-- Category/ Module: Guardianship Assistance Program  (Case Management) 
-- Root cause: Code Deployed Issue; was fixed & deployed on Prod 10/22
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

/*
-- Case ID: 3238784 
-- Client ID: 3977986 (JOSHIA D	BLOUNT) - 40e7d08a-65ee-4465-a291-9bd51ac036f4  
-- GAP ID: 5415 - f88413ae-3530-4de4-ae0c-abe8c8f9a847
-- GAP Agreement ID: 369f0907-aed7-43d2-95d3-52d14426fd64
-- gapagreementrateid: 84aadebe-7b1f-40b3-9a68-b9b1f5f9115c
*/

-- Soft-delete GAP Rate in Review
select activeflag, startdate, enddate, rateapprovaldate, paymentamout, status , updatedby, updatedon 
	from gapagreementrate 
where gapagreementrateid = '84aadebe-7b1f-40b3-9a68-b9b1f5f9115c'
	and lower(status) = 'review' 
	and activeflag = 1 ;

update gapagreementrate 
set activeflag = 0,
	updatedby = 'CDM-17988',
	updatedon = now()
where gapagreementrateid = '84aadebe-7b1f-40b3-9a68-b9b1f5f9115c'
	and lower(status) = 'review' 
	and activeflag = 1 ;
