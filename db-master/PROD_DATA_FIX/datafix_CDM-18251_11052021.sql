-- CDM-18251 - GAP rate not able to approve
/*
-- Issue Description:
	Supervisor not able to approve the new GAP rate. 
	Once she hits approve, the approval does not stay. 
	Provider needs to be paid. Approval was not in supervisor in box either.
   
-- Category/ Module: Guardianship Assistance Program  (Case Management) 
-- Root cause: Code Deployed Issue; was fixed & deployed on Prod 10/22
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

/*
-- Case ID: 3246776
-- Client ID: 3921337 (CALEB JACELEE LINDNER) - cb02e27a-3cf5-47ea-b20f-98d815fd07a5
-- GAP ID: 1005498 - 2020-08-26 To 2037-02-27 - 80f028a8-3ec7-4002-a9d0-f19dd448489c
-- Provider ID: 5085010 (Cristie Griffin)
-- GAP Agreement ID: c3e21c3e-2a8d-440a-a04e-3c8923e48b04 
-- gapagreementrateid: c416018c-9081-43b0-af3f-7c57ede20df9
*/

-- Soft-delete GAP Rate in Review
select activeflag, startdate, enddate, rateapprovaldate, paymentamout, status , updatedby, updatedon 
	from gapagreementrate 
where gapagreementrateid = 'c416018c-9081-43b0-af3f-7c57ede20df9'
	and lower(status) = 'review' 
	and activeflag = 1 ;

update gapagreementrate 
set activeflag = 0,
	updatedby = 'CDM-18251',
	updatedon = now()
where gapagreementrateid = 'c416018c-9081-43b0-af3f-7c57ede20df9'
	and lower(status) = 'review' 
	and activeflag = 1 ;
