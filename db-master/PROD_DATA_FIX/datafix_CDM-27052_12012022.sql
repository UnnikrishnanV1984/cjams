-- CDM-27052 - Payment issue GAP won't approve
/*
-- Issue Description: 
   Subsidy rate stuck in review mode with the incorrect supervisor listed. 
   
-- Case ID: 3184485
-- Client ID: 2218346 (AVIANASHBY ANDRE ATKINSON) - 3cbf4494-adc8-48de-a264-6cb48b9541fb
-- GAP ID: 2437 - 2012-08-22 To 2024-09-03 - 930e8cb9-74d9-4f37-80e5-6435fc1d6e88
-- Provider ID: 5025346 (Ashby Coles) - Local Department Home
-- Rate Slab: 08/22/2022 To 08/21/2023 - $616.00 - Review
-- gapagreementrateid: 1223b115-2d25-421b-8b65-b8902b2cd7da

-- Category/ Module: Accounts Payable (Finance Management)
-- Root cause: Partial Transaction (Routing record is missing) 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Delete Rate Slab stuck in review
select activeflag, startdate, enddate, rateapprovaldate, paymentamout, status , updatedby, updatedon 
	from gapagreementrate 
where gapagreementrateid = '1223b115-2d25-421b-8b65-b8902b2cd7da'
	and activeflag  = 1 ;

update gapagreementrate
set activeflag = 0,
	updatedby = 'CDM-27052',
	updatedon = now()
where gapagreementrateid = '1223b115-2d25-421b-8b65-b8902b2cd7da'
	and activeflag  = 1 ;

select ratestartdate, rateenddate, approvalstatustypekey, approvaldate, updatedby, updatedon
	from gapratesrevision 
where gaprateid = '1223b115-2d25-421b-8b65-b8902b2cd7da'
	and activeflag = 1 ; 

update gapratesrevision
set activeflag = 0,
	updatedby = 'CDM-27052',
	updatedon = now()
where gaprateid = '1223b115-2d25-421b-8b65-b8902b2cd7da'
	and activeflag = 1 ; 

/*
select routingid, routingstatustypeid, remarks, insertedon, insertedby, activeflag
	from routing 
where objectid = '1223b115-2d25-421b-8b65-b8902b2cd7da'
	and eventcode = 'GARR'
	and activeflag = 1 ;

update routing
set activeflag = 0,
	updatedby = 'CDM-27052',
	updatedon = now()
where objectid = '1223b115-2d25-421b-8b65-b8902b2cd7da'
	and eventcode = 'GARR'
	and activeflag = 1 ;
*/
