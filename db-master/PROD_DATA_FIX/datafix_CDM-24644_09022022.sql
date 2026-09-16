-- CDM-24644 - Edit GAP Rate
/*
-- Issue Description: 
   CJAMS is not allowing the user to edit GAP subsidy rate. 

-- Case ID: 3222534
-- Client ID: 3500205 (MALLORY S YOUNG) - 78cfa22a-e81d-402f-a9e8-e16eb34a961c
-- GAP ID: 3421 - 2014-10-20 To 2023-03-31 - 25b13df6-1d8b-4107-a637-63f3a024427a
-- Provider ID: 5062823	(Elizabeth Burrus)
-- gapagreementrateid  = d22291b5-0f83-4f8c-a272-35e52c73b709 - Rejected
   
-- Category/ Module: Accounts Payable (Finance Management)
-- Root cause: GAP is having one Rejected rate slab (Exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Delete Rejected Rate Slab
select activeflag, startdate, enddate, rateapprovaldate, paymentamout, status , updatedby, updatedon 
	from gapagreementrate 
where gapagreementrateid = 'd22291b5-0f83-4f8c-a272-35e52c73b709'
	and activeflag  = 1 ;

update gapagreementrate
set activeflag = 0,
	updatedby = 'CDM-24644',
	updatedon = now()
where gapagreementrateid = 'd22291b5-0f83-4f8c-a272-35e52c73b709'
	and activeflag  = 1 ;

select ratestartdate, rateenddate, approvalstatustypekey, approvaldate, updatedby, updatedon
	from gapratesrevision 
where gaprateid = 'd22291b5-0f83-4f8c-a272-35e52c73b709'
	and activeflag = 1 ; 

update gapratesrevision
set activeflag = 0,
	updatedby = 'CDM-24644',
	updatedon = now()
where gaprateid = 'd22291b5-0f83-4f8c-a272-35e52c73b709'
	and activeflag = 1 ; 

select routingid, routingstatustypeid, remarks, insertedon, insertedby, activeflag
	from routing 
where objectid = 'd22291b5-0f83-4f8c-a272-35e52c73b709'
	and eventcode = 'GARR'
	and activeflag = 1 ;

update routing
set activeflag = 0,
	updatedby = 'CDM-24644',
	updatedon = now()
where objectid = 'd22291b5-0f83-4f8c-a272-35e52c73b709'
	and eventcode = 'GARR'
	and activeflag = 1 ;
	
