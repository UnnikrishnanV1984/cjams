/*
-- Issue Description: 
   Incorrect GAP Rate $29.16 
-- Case ID: 3296501 
-- Client ID:  3886877 (JOSIAH WHITFIELD)
-- Rate Fix to $887 (old value is $29.16)   
-- Category/ Module: Accounts Payable (Finance Management) 
-- Root cause: User error 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

/*
select * from gapagreement g where gapid ='c2761356-6fca-4db1-bee8-71087fbad716';
select gapagreementid,gapagreementrateid , startdate, enddate, paymentamout, updatedby, updatedon, activeflag 
	from gapagreementrate 
where gapagreementid  in ('08c513c4-ab01-4160-9dc8-7e53b0566dc9')
	and activeflag = 1 ;
*/
	
update gapagreementrate 
set paymentamout = 887.00,
	updatedby = 'CJAMS-61586',
	updatedon = now()
where gapagreementrateid in ('71b026fa-dcd9-4b97-8ed3-3ada4675d94e')
	and activeflag = 1 ;

-- Datafix to trigger Under/Over 
/*
select approvalstatustypekey, approvaldate, ratestartdate, rateenddate, paymentamt, activeflag, updatedby, updatedon 
	from gapratesrevision 
where gaprateid in ('71b026fa-dcd9-4b97-8ed3-3ada4675d94e') ;
*/

update gapratesrevision 
set paymentamt = 887.00,
	approvaldate = now(),
	updatedby = 'CJAMS-61586',
	updatedon = now()
where gaprateid in ('71b026fa-dcd9-4b97-8ed3-3ada4675d94e');