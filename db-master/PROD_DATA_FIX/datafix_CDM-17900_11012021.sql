-- CDM-17900 - GAP approval
/*
-- Issue Description: 
   Supervisor not able to approve the new GAP rate.
   
-- Category/ Module: Guardianship Assistance Program  (Case Management) 
-- Root cause: Code Deployed Issue; was fixed & deployed on Prod 10/22
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

/*
-- Case ID: 3248198 
-- Client ID: 3737963 (ZOIE	ELIZABETH HOOVER) - 088c0cd7-7abb-4994-8e84-7e4abeecb697  
-- GAP ID: 3885 - 5b3619e1-1aaf-4e65-b503-788d369c4a1f
-- GAP Agreement ID: d59ae51e-d65a-473c-955f-2214f56ea7a2
-- gapagreementrateid: 299ef6e7-a0dc-4c2b-8e56-01649d9ac646
*/

-- Soft-delete GAP Rate in Review
select activeflag, startdate, enddate, rateapprovaldate, paymentamout, status , updatedby, updatedon 
	from gapagreementrate 
where gapagreementrateid = '299ef6e7-a0dc-4c2b-8e56-01649d9ac646'
	and lower(status) = 'review' 
	and activeflag = 1 ;

update gapagreementrate 
set activeflag = 0,
	updatedby = 'CDM-17900',
	updatedon = now()
where gapagreementrateid = '299ef6e7-a0dc-4c2b-8e56-01649d9ac646'
	and lower(status) = 'review' 
	and activeflag = 1 ;
