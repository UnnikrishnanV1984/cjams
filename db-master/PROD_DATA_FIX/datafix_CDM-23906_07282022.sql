-- CDM-23906 - Wrong Subsidy Rate
/*
-- Issue Description: 
   User Request to change GAP subsidy rate from $887 to $902
   
-- Case ID: 3304946
-- Client ID: 3670326 (BRIE	N SUMMERS) - 43e35b23-49bb-4fe8-910f-6f29a42b4e7f
-- GAP ID: 1006055 - 2022-07-20 To 2027-04-26 - e0391055-60e2-4658-b921-b015dcc3143f
-- Provider ID: 5097016	(Brooke Ashleigh Summers)

-- Rate Fix to $902.00 (old value is $887.00)
  
-- Category/ Module: Accounts Payable (Finance Management) 
-- Root cause: User error 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- GAP Agreement Rate ID: '1f52eaf3-a340-4a78-a292-4103d92bfcda'
-- Update Rate
select gapagreementid, startdate, enddate, paymentamout, updatedby, updatedon, activeflag 
	from gapagreementrate 
where gapagreementrateid = '1f52eaf3-a340-4a78-a292-4103d92bfcda'
	and activeflag = 1 ;

update gapagreementrate 
set paymentamout = 902.00,
	updatedby = 'CDM-23906',
	updatedon = now()
where gapagreementrateid = '1f52eaf3-a340-4a78-a292-4103d92bfcda'
	and activeflag = 1 ;

-- Datafix to trigger Under/Over 
select approvalstatustypekey, approvaldate, ratestartdate, rateenddate, paymentamt, activeflag, updatedby, updatedon 
	from gapratesrevision 
where gaprateid = '1f52eaf3-a340-4a78-a292-4103d92bfcda' ;

update gapratesrevision 
set paymentamt = 902.00,
	approvaldate = now(),
	updatedby = 'CDM-23906',
	updatedon = now()
where gaprateid = '1f52eaf3-a340-4a78-a292-4103d92bfcda' ;

