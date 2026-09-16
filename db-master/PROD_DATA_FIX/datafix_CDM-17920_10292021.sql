-- CDM-17920 - Pending Approval Status
/*
-- Issue Description: 
   GAP RATE Approval Issue for the following case.
   The system is not allowing the supervisor to approve the rate changes. 
   It's continues to show "Review".

-- Case ID: 3164797
-- Client ID: 4064730 (SKYLAR JOHNSON) - 20843a61-4627-4967-a1cc-ac172cb53f01 
-- GAP ID: 5419 - e77f548a-92d5-4a48-950f-490446edd399
-- GAP Agreement ID: 56c7fb64-14a6-4edc-b08e-359f0cc5c3dd
-- gapagreementrateid: 538c8052-adaa-4a36-be7a-01881934bf71 
  
*/   

-- Soft-delete GAP Rate in Reviews
select activeflag, startdate, enddate, rateapprovaldate, paymentamout, status , updatedby, updatedon 
	from gapagreementrate 
where gapagreementrateid = '538c8052-adaa-4a36-be7a-01881934bf71'
	and lower(status) = 'review' 
	and activeflag = 1 ;

update gapagreementrate 
set activeflag = 0,
	updatedby = 'CDM-17920',
	updatedon = now()
where gapagreementrateid = '538c8052-adaa-4a36-be7a-01881934bf71'	
	and lower(status) = 'review' 
	and activeflag = 1 ;
