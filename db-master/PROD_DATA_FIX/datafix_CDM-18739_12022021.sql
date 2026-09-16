-- CDM-18739 - System Adjustment not generated
/*
-- Issue Description: 
   Provider Patricia Salaam (5806592) system adjustment payment did not generate 
   once the agreement for Tresleem Salaam was approved on Friday November 19th.
   
-- Case ID: 3252215
-- Client ID: 3728028 (TRESLEEM	SALAAM) - b8f1c5ca-06a9-484f-a972-0fe5ef8b551d
-- GAP ID: 1005572 - 2018-06-05 To 2022-04-10 - a0488f22-bfc4-499d-b731-a814e02327a4
-- Provider ID: 5086592	(Patricia Salaam)
   
-- Category/ Module: Accounts Payable (Finance Management)
-- Root cause: GAP is having one Rejected rate slab (Exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Delete Rejected Rate Slab
select activeflag, startdate, enddate, rateapprovaldate, paymentamout, status , updatedby, updatedon 
	from gapagreementrate 
where gapagreementrateid = 'e56d3c1f-0570-43dc-899e-d6618935b049'
	and activeflag  = 1 ;

update gapagreementrate
set activeflag = 0,
	updatedby = 'CDM-18739',
	updatedon = now()
where gapagreementrateid = 'e56d3c1f-0570-43dc-899e-d6618935b049'
	and activeflag  = 1 ;

select ratestartdate, rateenddate, approvalstatustypekey, approvaldate, updatedby, updatedon
	from gapratesrevision 
where gaprateid = 'e56d3c1f-0570-43dc-899e-d6618935b049'
	and activeflag = 1 ; 

update gapratesrevision
set activeflag = 0,
	updatedby = 'CDM-18739',
	updatedon = now()
where gaprateid = 'e56d3c1f-0570-43dc-899e-d6618935b049'
	and activeflag = 1 ; 

select routingid, routingstatustypeid, remarks, insertedon, insertedby, activeflag
	from routing 
where objectid = 'e56d3c1f-0570-43dc-899e-d6618935b049'
	and eventcode = 'GARR'
	and activeflag = 1 ;

update routing
set activeflag = 0,
	updatedby = 'CDM-18739',
	updatedon = now()
where objectid = 'e56d3c1f-0570-43dc-899e-d6618935b049'
	and eventcode = 'GARR'
	and activeflag = 1 ;
	
-- To Trigger Under Over 
select ratestartdate, rateenddate, approvalstatustypekey, approvaldate, updatedby, updatedon
	from gapratesrevision 
where gaprateid = '1a0e0fb8-a5ee-41d2-a003-643ec80f5bd7'
	and activeflag = 1 ;

update cjams.gapratesrevision
set approvaldate = now(),
	updatedby = 'CDM-18739',
	updatedon = now()
where gaprateid = '1a0e0fb8-a5ee-41d2-a003-643ec80f5bd7'
	and activeflag = 1 ;
