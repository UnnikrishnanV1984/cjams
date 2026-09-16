-- CDM-17217 - TYSHAWN CRUDUP
/*
-- Issue Description: 
   This Caseworker submitted an annual reconsideration for the case of Tyshawn Crudup,
   It continues to disappear prior to my supervisor approving it, 
   
-- Category/ Module: Guardianship Assistance Program  (Case Management) 
-- Root cause: Code Deployed Issue; was fixed & deployed on Prod 10/22
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

/*
-- Case ID: 3106134 
-- Client ID: 1742828 (TYSHAWN CRUDUP) - 4d7a2346-eb8f-4cbb-b77d-876094784fb8  
-- GAP ID: 421 - ff74928c-1331-4ecf-83fe-ea66c5395b29
-- GAP Agreement ID: 0a3f15ac-be1e-4714-85a0-09bc8ca455b5
-- gapagreementrateid: 0e242750-a9ff-4bc6-a36d-db15b9764ee7
*/

-- Soft-delete GAP Rate in Review
select activeflag, startdate, enddate, rateapprovaldate, paymentamout, status , updatedby, updatedon 
	from gapagreementrate 
where gapagreementrateid = '0e242750-a9ff-4bc6-a36d-db15b9764ee7'
	and lower(status) = 'review' 
	and activeflag = 1 ;

update gapagreementrate 
set activeflag = 0,
	updatedby = 'CDM-17217',
	updatedon = now()
where gapagreementrateid = '0e242750-a9ff-4bc6-a36d-db15b9764ee7'
	and lower(status) = 'review' 
	and activeflag = 1 ;
