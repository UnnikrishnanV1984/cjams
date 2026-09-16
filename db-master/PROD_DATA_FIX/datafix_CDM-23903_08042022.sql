-- CDM-23903 - Supervisor cannot approve subsidy
/*
-- Issue Description: 
   Subsidy rate stuck in review mode with the incorrect supervisor listed. 
   
-- Case ID: 3125464
-- Client ID: 3010973 (TALIYA CANDY) - 974211a4-3ec3-430e-9f66-6f53315340ca
-- GAP ID: 3346 - 2014-05-07 To 2028-04-12 - c412e16d-8ced-49a6-9177-5c993dcb36e2
-- Provider ID: 5069619	(Sharta Matthews)
-- Rate ID: d79c697f-2268-46a2-b592-8d8617884a57 -2022-05-06 To 2023-05-05 - $950

-- Category/ Module: Accounts Payable (Finance Management)
-- Root cause: Partial Transaction (Routing record is missing) 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Delete Rejected Rate Slab
select activeflag, startdate, enddate, rateapprovaldate, paymentamout, status , updatedby, updatedon 
	from gapagreementrate 
where gapagreementrateid = 'd79c697f-2268-46a2-b592-8d8617884a57'
	and activeflag  = 1 ;

update gapagreementrate
set activeflag = 0,
	updatedby = 'CDM-23903',
	updatedon = now()
where gapagreementrateid = 'd79c697f-2268-46a2-b592-8d8617884a57'
	and activeflag  = 1 ;

select ratestartdate, rateenddate, approvalstatustypekey, approvaldate, updatedby, updatedon
	from gapratesrevision 
where gaprateid = 'd79c697f-2268-46a2-b592-8d8617884a57'
	and activeflag = 1 ; 

update gapratesrevision
set activeflag = 0,
	updatedby = 'CDM-22333',
	updatedon = now()
where gaprateid = 'd79c697f-2268-46a2-b592-8d8617884a57'
	and activeflag = 1 ; 

/*
select routingid, routingstatustypeid, remarks, insertedon, insertedby, activeflag
	from routing 
where objectid = 'd79c697f-2268-46a2-b592-8d8617884a57'
	and eventcode = 'GARR'
	and activeflag = 1 ;

update routing
set activeflag = 0,
	updatedby = 'CDM-22333',
	updatedon = now()
where objectid = 'd79c697f-2268-46a2-b592-8d8617884a57'
	and eventcode = 'GARR'
	and activeflag = 1 ;
*/