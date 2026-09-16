-- CDM-17860 - GAP Rate Approval
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
-- Case ID: 3185967
-- Client ID: 2963515 (JAMES WATSON) - 0d39756d-b75e-4421-8c60-69d6bedb1d2a
-- GAP ID: 1818 - 060f1f96-271c-4486-9113-60e67eda9911
-- GAP Agreement ID: a2309e49-6e53-42ce-92e9-d43ef0a5e1ae
-- gapagreementrateid: 12143f8e-4378-4e52-a32a-a5f1f96cda7d
*/

-- Soft-delete GAP Rate in Review
select activeflag, startdate, enddate, rateapprovaldate, paymentamout, status , updatedby, updatedon 
	from gapagreementrate 
where gapagreementrateid = '12143f8e-4378-4e52-a32a-a5f1f96cda7d'
	and lower(status) = 'review' 
	and activeflag = 1 ;

update gapagreementrate 
set activeflag = 0,
	updatedby = 'CDM-17860',
	updatedon = now()
where gapagreementrateid = '12143f8e-4378-4e52-a32a-a5f1f96cda7d'
	and lower(status) = 'review' 
	and activeflag = 1 ;

