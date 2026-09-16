-- CDM-17773 - unable to approve subsidy rate
/*
-- Issue Description: 
   GAP RATE Approval Issue for the follwoing Cases Kevin Bowie under case of Monica Seals.
   
-- Category/ Module: Guardianship Assistance Program  (Case Management) 
-- Root cause: Code Issue 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: deployed in Prod 10/22
*/

/*
Case ID: 3164579
Client ID: 2301704 (KEVIN MARK BOWIE) - 4c5cef87-2f03-4ca3-bcd7-90404cc577c7
GAP ID: 2426 - 1a028515-01fc-4ca4-b201-0969729e4b10
GAP Aggrement ID: 81bcdb85-0214-4f22-9252-8f78657a94c1
gapagreementrateid: e3511709-df58-486e-bff8-43a7ceefdfd4
*/

-- Soft-delete GAP Rate in Review
select activeflag, startdate, enddate, rateapprovaldate, paymentamout, status , updatedby, updatedon 
	from gapagreementrate 
where gapagreementrateid = 'e3511709-df58-486e-bff8-43a7ceefdfd4'
	and lower(status) = 'review' 
	and activeflag = 1 ;

update gapagreementrate 
set activeflag = 0,
	updatedby = 'CDM-17773',
	updatedon = now()
where gapagreementrateid = 'e3511709-df58-486e-bff8-43a7ceefdfd4'
	and lower(status) = 'review' 
	and activeflag = 1 ;