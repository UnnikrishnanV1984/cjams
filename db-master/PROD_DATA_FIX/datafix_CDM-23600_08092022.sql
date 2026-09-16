-- CDM-23600 - Rate approval
/*
-- Issue Description: 
   Subsidy rate stuck in review mode with the incorrect supervisor listed. 
   
-- Case ID: 3089726
-- Client ID: 1554836 (MADISON MAKAYLAH WATSON) - d2e3140a-20a5-4e5e-b4f8-b022b620635b
-- GAP ID: 829 - 2009-07-17 To 2025-06-21 - 9ec8ef29-adff-4f1b-ae9b-f2d8a06c4273
-- Provider ID: 5024860	(Deborah Watson)
-- Rate ID: 2021-07-31 To 2022-06-30 - ad4dce15-d67a-41ea-8fdc-03183c71731a

-- Category/ Module: Accounts Payable (Finance Management)
-- Root cause: Partial Transaction (Routing record is missing) 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Delete Partial Transaction (Routing record is missing) Rate Slab
select activeflag, startdate, enddate, rateapprovaldate, paymentamout, status , updatedby, updatedon 
	from gapagreementrate 
where gapagreementrateid = 'ad4dce15-d67a-41ea-8fdc-03183c71731a'
	and activeflag  = 1 ;

update gapagreementrate
set activeflag = 0,
	updatedby = 'CDM-23600',
	updatedon = now()
where gapagreementrateid = 'ad4dce15-d67a-41ea-8fdc-03183c71731a'
	and activeflag  = 1 ;

select ratestartdate, rateenddate, approvalstatustypekey, approvaldate, updatedby, updatedon
	from gapratesrevision 
where gaprateid = 'ad4dce15-d67a-41ea-8fdc-03183c71731a'
	and activeflag = 1 ; 

update gapratesrevision
set activeflag = 0,
	updatedby = 'CDM-23600',
	updatedon = now()
where gaprateid = 'ad4dce15-d67a-41ea-8fdc-03183c71731a'
	and activeflag = 1 ; 

/*
select routingid, routingstatustypeid, remarks, insertedon, insertedby, activeflag
	from routing 
where objectid = 'ad4dce15-d67a-41ea-8fdc-03183c71731a'
	and eventcode = 'GARR'
	and activeflag = 1 ;

update routing
set activeflag = 0,
	updatedby = 'CDM-23600',
	updatedon = now()
where objectid = 'ad4dce15-d67a-41ea-8fdc-03183c71731a'
	and eventcode = 'GARR'
	and activeflag = 1 ;
*/