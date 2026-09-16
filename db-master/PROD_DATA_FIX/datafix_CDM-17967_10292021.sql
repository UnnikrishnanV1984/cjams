-- CDM-17967 - GAP RATE Approval Issue
/*
-- Issue Description: 
   GAP RATE Approval Issue for the following case.
   The system is not allowing the supervisor to approve the rate changes. 
   It's continues to show "Review".

-- Case ID: 3181274 
-- Client ID: 2854600 (CHARLES D WHIMS)	2edca0a6-b588-4e8f-8bed-c34952349ad6 
-- GAP ID: 1340 - f2af7b66-5078-4b20-ab85-06bdc32ca7ae
-- GAP Agreement ID: 90c0c397-2f38-4cb0-b159-e27543db619f
-- gapagreementrateid: 11d75dc5-a4da-43f6-a640-b5a7001b411e
  
*/   

-- Soft-delete GAP Rate in Reviews
select activeflag, startdate, enddate, rateapprovaldate, paymentamout, status , updatedby, updatedon 
	from gapagreementrate 
where gapagreementrateid = '11d75dc5-a4da-43f6-a640-b5a7001b411e'
	and lower(status) = 'review' 
	and activeflag = 1 ;

update gapagreementrate 
set activeflag = 0,
	updatedby = 'CDM-17967',
	updatedon = now()
where gapagreementrateid = '11d75dc5-a4da-43f6-a640-b5a7001b411e'	
	and lower(status) = 'review' 
	and activeflag = 1 ;
