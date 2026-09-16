-- CDM-26692 - Payment issue
/*
-- Issue Description: 
   Subsidy rate stuck in review mode with the incorrect supervisor listed. 
   
-- Case ID: 3308045
-- Client ID: 4495597 (JEWELZ ROHRBAUGH) - d3c58c14-1ba5-4c50-8b69-32b210175e37
-- GAP ID: 1005867 - 2021-09-29 to 2041-07-02 - 90e8655c-ec17-461e-8f93-2f81e51d1325
-- Provider ID: 6001863 (TWANETTE L CULVER)
-- Rate Slab: 09/29/2022 To 09/28/2023 - $650.00 - Review
-- gapagreementrateid: aa1f4846-727e-430a-b06a-6e221a5dd62b

-- Category/ Module: Accounts Payable (Finance Management)
-- Root cause: Partial Transaction (Routing record is missing) 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Delete Rate Slab stuck in review
select activeflag, startdate, enddate, rateapprovaldate, paymentamout, status , updatedby, updatedon 
	from gapagreementrate 
where gapagreementrateid = 'aa1f4846-727e-430a-b06a-6e221a5dd62b'
	and activeflag  = 1 ;

update gapagreementrate
set activeflag = 0,
	updatedby = 'CDM-26692',
	updatedon = now()
where gapagreementrateid = 'aa1f4846-727e-430a-b06a-6e221a5dd62b'
	and activeflag  = 1 ;

select ratestartdate, rateenddate, approvalstatustypekey, approvaldate, updatedby, updatedon
	from gapratesrevision 
where gaprateid = 'aa1f4846-727e-430a-b06a-6e221a5dd62b'
	and activeflag = 1 ; 

update gapratesrevision
set activeflag = 0,
	updatedby = 'CDM-26692',
	updatedon = now()
where gaprateid = 'aa1f4846-727e-430a-b06a-6e221a5dd62b'
	and activeflag = 1 ; 

/*
select routingid, routingstatustypeid, remarks, insertedon, insertedby, activeflag
	from routing 
where objectid = 'aa1f4846-727e-430a-b06a-6e221a5dd62b'
	and eventcode = 'GARR'
	and activeflag = 1 ;

update routing
set activeflag = 0,
	updatedby = 'CDM-26692',
	updatedon = now()
where objectid = 'aa1f4846-727e-430a-b06a-6e221a5dd62b'
	and eventcode = 'GARR'
	and activeflag = 1 ;
*/
