-- CDM-27448 - Subsidy needs to be approve
/*
-- Issue Description: 
   Subsidy rate stuck in review mode with the incorrect supervisor listed. 
   
-- Case ID: 3110207
-- Client ID: 3282159 (KIARA LOCKETT) - a00e3ff7-9815-4b45-b9fe-e34c47c7180d
-- GAP ID: 3753 - 2015-11-06 To 2025-07-28 - 5cf09f11-c166-4b2b-b653-5f621870b726
-- Provider ID: 5064084	(Ada Giddins)
-- gapagreementid: 0da448c1-a15d-48e2-8371-5f1d4a93ceb5
-- gapagreementrateid: 4d306595-81a3-47da-88b7-ed74bce73b97
-- GAP Rate: 11/06/2022 TO 11/05/2023 -$835 - Review 

-- Category/ Module: Accounts Payable (Finance Management)
-- Root cause: Partial Transaction (Routing record is missing) 
-- Fix Provided: Datafix has been promoted remove the Subsidy rate stuck in Review mode.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Delete Rate Slab stuck in review
select activeflag, startdate, enddate, rateapprovaldate, paymentamout, status , updatedby, updatedon 
	from gapagreementrate 
where gapagreementrateid = '4d306595-81a3-47da-88b7-ed74bce73b97'
	and activeflag  = 1 ;

update gapagreementrate
set activeflag = 0,
	updatedby = 'CDM-27448',
	updatedon = now()
where gapagreementrateid = '4d306595-81a3-47da-88b7-ed74bce73b97'
	and activeflag  = 1 ;

select ratestartdate, rateenddate, approvalstatustypekey, approvaldate, updatedby, updatedon
	from gapratesrevision 
where gaprateid = '4d306595-81a3-47da-88b7-ed74bce73b97'
	and activeflag = 1 ; 

update gapratesrevision
set activeflag = 0,
	updatedby = 'CDM-27448',
	updatedon = now()
where gaprateid = '4d306595-81a3-47da-88b7-ed74bce73b97'
	and activeflag = 1 ; 

/*
select routingid, routingstatustypeid, remarks, insertedon, insertedby, activeflag
	from routing 
where objectid = '4d306595-81a3-47da-88b7-ed74bce73b97'
	and eventcode = 'GARR'
	and activeflag = 1 ;

update routing
set activeflag = 0,
	updatedby = 'CDM-27448',
	updatedon = now()
where objectid = '4d306595-81a3-47da-88b7-ed74bce73b97'
	and eventcode = 'GARR'
	and activeflag = 1 ;
*/
