-- CDM-22333 - Subsidy rate stuck in Review mode
/*
-- Issue Description: 
   Subsidy rate stuck in review mode with the incorrect supervisor listed. 
   
-- Case ID: 3174337 - veronica.stanton@maryland.gov
-- Client ID: 2630322 (MICHAEL JENKINS) - ef5f0cfa-3743-4429-89c4-e18127407842
-- GAP ID: 1776 - 2011-07-19 To 2029-09-01 - 1c398fda-f04d-490e-9101-9919fd7127ec
-- Provider ID: 5037701 (Nellie Burkhamer) - Local Department Home
-- gapagreementrateid: 2d1f5e17-aab3-4294-aebc-8f2cc50b6f4b

-- Category/ Module: Accounts Payable (Finance Management)
-- Root cause: GAP is having one Rejected rate slab (Exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Delete Rejected Rate Slab
select activeflag, startdate, enddate, rateapprovaldate, paymentamout, status , updatedby, updatedon 
	from gapagreementrate 
where gapagreementrateid = '2d1f5e17-aab3-4294-aebc-8f2cc50b6f4b'
	and activeflag  = 1 ;

update gapagreementrate
set activeflag = 0,
	updatedby = 'CDM-22333',
	updatedon = now()
where gapagreementrateid = '2d1f5e17-aab3-4294-aebc-8f2cc50b6f4b'
	and activeflag  = 1 ;

select ratestartdate, rateenddate, approvalstatustypekey, approvaldate, updatedby, updatedon
	from gapratesrevision 
where gaprateid = '2d1f5e17-aab3-4294-aebc-8f2cc50b6f4b'
	and activeflag = 1 ; 

update gapratesrevision
set activeflag = 0,
	updatedby = 'CDM-22333',
	updatedon = now()
where gaprateid = '2d1f5e17-aab3-4294-aebc-8f2cc50b6f4b'
	and activeflag = 1 ; 

select routingid, routingstatustypeid, remarks, insertedon, insertedby, activeflag
	from routing 
where objectid = '2d1f5e17-aab3-4294-aebc-8f2cc50b6f4b'
	and eventcode = 'GARR'
	and activeflag = 1 ;

update routing
set activeflag = 0,
	updatedby = 'CDM-22333',
	updatedon = now()
where objectid = '2d1f5e17-aab3-4294-aebc-8f2cc50b6f4b'
	and eventcode = 'GARR'
	and activeflag = 1 ;
