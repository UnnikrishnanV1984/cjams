-- CDM-17984 - Agreement tab stuck in review mode
/*
-- Issue Description: 
   3117916:Subsidy payment in the agreement tab stuck in the review mode and not being approved.
   3154538:Agreement tab stuck in the review mode and not being approved
   
-- Category/ Module: Guardianship Assistance Program  (Case Management) 
-- Root cause: Code Deployed Issue; was fixed & deployed on Prod 10/22
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

/*
-- Case ID: 3117916 
-- Client ID: 1909890 (ZYARA HOLMES) e7a52928-5b50-40fb-9d3f-a304c4dba3bf 
-- GAP ID: 1385 - 543cc2a6-da80-4e0a-a5f9-66132b06e38d
-- GAP Agreement ID: 9c3960ed-1f1f-4904-9478-a1314b84d8e4
-- gapagreementrateid: dca3c7c4-4abb-4885-9c9a-efc52d285a57

-- Case ID: 3154538
-- Client ID: 2018137 (MICHAEL DICKEY) - 895b2217-5032-4f99-8598-9a6a1c5beb75 
-- GAP ID: 1166 - a3c06216-8b15-4ee2-9d40-e4760666f5e4
-- GAP Agreement ID: 3a013131-69b3-4cc0-b0c2-27118d84458a 
-- gapagreementrateid: 8b37cc57-868a-4000-b0b4-83009f5dc8de & 5ce1f005-d500-4275-9456-6a68323d3a5f
*/

-- Soft-delete GAP Rate in Review
select activeflag, startdate, enddate, rateapprovaldate, paymentamout, status , updatedby, updatedon 
	from gapagreementrate 
where gapagreementrateid in (
		'dca3c7c4-4abb-4885-9c9a-efc52d285a57',
		'8b37cc57-868a-4000-b0b4-83009f5dc8de',
		'5ce1f005-d500-4275-9456-6a68323d3a5f'
	)
	and lower(status) = 'review' 
	and activeflag = 1 ;

update gapagreementrate 
set activeflag = 0,
	updatedby = 'CDM-17984',
	updatedon = now()
where gapagreementrateid in (
		'dca3c7c4-4abb-4885-9c9a-efc52d285a57',
		'8b37cc57-868a-4000-b0b4-83009f5dc8de',
		'5ce1f005-d500-4275-9456-6a68323d3a5f'
	)
	and lower(status) = 'review' 
	and activeflag = 1 ;
