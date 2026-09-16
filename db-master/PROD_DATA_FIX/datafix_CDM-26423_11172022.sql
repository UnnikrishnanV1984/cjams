-- CDM-26423 - Subsidy rate will not approve
/*
-- Issue Description: 
   Subsidy rate stuck in review mode with the incorrect supervisor listed. 
   
-- Case ID: 3248919
-- Client ID: 3746767 (JASMINE HARRIS) - 997ad0a3-531e-49df-b0f1-db4b3fca1663
-- GAP ID: 1005868 - 10/15/2021 To 12/14/2035 - f359f3aa-e83f-4ad7-9bf9-2d519585f34c
-- Provider ID: 6003797	(Latisha  Harris)
-- Rate Slab: 10/15/2022 To 10/14/2023 - $887 - Review
-- gapagreementrateid: 22fc4201-6776-4401-9cfa-e046d2b1cd49

-- Category/ Module: Accounts Payable (Finance Management)
-- Root cause: Partial Transaction (Routing record is missing) 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Delete Rate Slab stuck in review
select activeflag, startdate, enddate, rateapprovaldate, paymentamout, status , updatedby, updatedon 
	from gapagreementrate 
where gapagreementrateid = '22fc4201-6776-4401-9cfa-e046d2b1cd49'
	and activeflag  = 1 ;

update gapagreementrate
set activeflag = 0,
	updatedby = 'CDM-26423',
	updatedon = now()
where gapagreementrateid = '22fc4201-6776-4401-9cfa-e046d2b1cd49'
	and activeflag  = 1 ;

select ratestartdate, rateenddate, approvalstatustypekey, approvaldate, updatedby, updatedon
	from gapratesrevision 
where gaprateid = '22fc4201-6776-4401-9cfa-e046d2b1cd49'
	and activeflag = 1 ; 

update gapratesrevision
set activeflag = 0,
	updatedby = 'CDM-26423',
	updatedon = now()
where gaprateid = '22fc4201-6776-4401-9cfa-e046d2b1cd49'
	and activeflag = 1 ; 

/*
select routingid, routingstatustypeid, remarks, insertedon, insertedby, activeflag
	from routing 
where objectid = '22fc4201-6776-4401-9cfa-e046d2b1cd49'
	and eventcode = 'GARR'
	and activeflag = 1 ;

update routing
set activeflag = 0,
	updatedby = 'CDM-26423',
	updatedon = now()
where objectid = '22fc4201-6776-4401-9cfa-e046d2b1cd49'
	and eventcode = 'GARR'
	and activeflag = 1 ;
*/
