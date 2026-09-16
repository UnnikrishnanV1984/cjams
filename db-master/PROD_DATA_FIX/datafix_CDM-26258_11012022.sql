-- CDM-26258 - Rate stuck in review status
/*
-- Issue Description: 
	The subsidy rate still stuck under review status 
	the subsidy rate approval request is not available in supervisor pending approval inbox
   
-- Case ID: 3050154
-- Client ID: 1317784 (DESTINY E HILL) - 2dd6d515-b233-4550-9b74-f97be378d80f
-- GAP ID: 1514 - 2011-01-27 To 2023-04-07 - fdf7f4b5-d01d-4edb-b6f3-94d55776d102
-- Provider ID: 5030137	(Vickie Merrbaugh)
-- GAP Rate ID: 2022-10-01 To 2023-04-07  - $835.00 - b60473cd-fd63-415a-879f-bcededfc150a
-- gapagreementid: 30e79413-7bb9-409f-80e4-494d317761f6

-- Category/ Module: Accounts Payable (Finance Management)
-- Root cause: Partial Transaction (Routing record is missing) 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Delete the Partial Transaction Rate Slab (Routing record is missing)
select activeflag, startdate, enddate, rateapprovaldate, paymentamout, status , updatedby, updatedon 
	from gapagreementrate 
where gapagreementrateid = 'b60473cd-fd63-415a-879f-bcededfc150a'
	and activeflag  = 1 ;

update gapagreementrate
set activeflag = 0,
	updatedby = 'CDM-26258',
	updatedon = now()
where gapagreementrateid = 'b60473cd-fd63-415a-879f-bcededfc150a'
	and activeflag  = 1 ;

select ratestartdate, rateenddate, approvalstatustypekey, approvaldate, updatedby, updatedon
	from gapratesrevision 
where gaprateid = 'b60473cd-fd63-415a-879f-bcededfc150a'
	and activeflag = 1 ; 

update gapratesrevision
set activeflag = 0,
	updatedby = 'CDM-26258',
	updatedon = now()
where gaprateid = 'b60473cd-fd63-415a-879f-bcededfc150a'
	and activeflag = 1 ; 

/*
-- No Routing Record
select routingid, routingstatustypeid, remarks, insertedon, insertedby, activeflag
	from routing 
where objectid = 'b60473cd-fd63-415a-879f-bcededfc150a'
	and eventcode = 'GARR'
	and activeflag = 1 ;

update routing
set activeflag = 0,
	updatedby = 'CDM-26258',
	updatedon = now()
where objectid = 'b60473cd-fd63-415a-879f-bcededfc150a'
	and eventcode = 'GARR'
	and activeflag = 1 ;
*/