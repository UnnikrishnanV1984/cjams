/*
   Issue Description: CDM-25980
   Category/ Module  : Prod data fix To update approval status
   Pull request# for code fix:  
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

-- Category/ Module: Accounts Payable (Finance Management)
-- Root cause: TBD
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
--*/

-- Delete GAP Subsidy rate stuck in review mode
select activeflag, startdate, enddate, rateapprovaldate, paymentamout, status , updatedby, updatedon 
	from gapagreementrate 
where gapagreementrateid = '3671d5ae-b3ca-4a38-ba36-e38efb15b97b'
	and activeflag  = 1 ;

update gapagreementrate
set activeflag = 0,
	updatedby = 'CDM-25980',
	updatedon = now()
where gapagreementrateid = '3671d5ae-b3ca-4a38-ba36-e38efb15b97b'
	and activeflag  = 1 ;

select ratestartdate, rateenddate, approvalstatustypekey, approvaldate, updatedby, updatedon
	from gapratesrevision 
where gaprateid = '3671d5ae-b3ca-4a38-ba36-e38efb15b97b'
	and activeflag = 1 ; 

update gapratesrevision
set activeflag = 0,
	updatedby = 'CDM-25980',
	updatedon = now()
where gaprateid = '3671d5ae-b3ca-4a38-ba36-e38efb15b97b'
	and activeflag = 1 ; 

select routingid, routingstatustypeid, remarks, insertedon, insertedby, activeflag
	from routing 
where objectid = '3671d5ae-b3ca-4a38-ba36-e38efb15b97b'
	and eventcode = 'GARR'
	and activeflag = 1 ;

update routing
set activeflag = 0,
	updatedby = 'CDM-25980',
	updatedon = now()
where objectid = '3671d5ae-b3ca-4a38-ba36-e38efb15b97b'
	and eventcode = 'GARR'
	and activeflag = 1 ;