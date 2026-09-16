-- CDM-25821 - Outstanding GAP payment ticket
/*
-- Issue Description: 
   Subsidy rate stuck in review mode with the incorrect supervisor listed. 
   
-- Case ID: 3206682
-- Client ID: 4476198 (JOHN F DORSEY) - 714495b5-d9b3-4071-bac2-c07e74ef5740
-- GAP ID: 1006104 - 2022-07-20 To 2038-02-18 - 14dc4f08-c6cc-4cea-b87e-dd71b631f4eb 
-- Provider ID: 6006686	(Barbara Jean Dorsey)
-- Rate ID: 95e323ba-6b8d-47ce-a0df-6bd13d7de550 - 2022-07-20 To 2022-10-31 - $887.00

-- Category/ Module: Accounts Payable (Finance Management)
-- Root cause: TBD
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Delete GAP Subsidy rate stuck in review mode
select activeflag, startdate, enddate, rateapprovaldate, paymentamout, status , updatedby, updatedon 
	from gapagreementrate 
where gapagreementrateid = '95e323ba-6b8d-47ce-a0df-6bd13d7de550'
	and activeflag  = 1 ;

update gapagreementrate
set activeflag = 0,
	updatedby = 'CDM-25821',
	updatedon = now()
where gapagreementrateid = '95e323ba-6b8d-47ce-a0df-6bd13d7de550'
	and activeflag  = 1 ;

select ratestartdate, rateenddate, approvalstatustypekey, approvaldate, updatedby, updatedon
	from gapratesrevision 
where gaprateid = '95e323ba-6b8d-47ce-a0df-6bd13d7de550'
	and activeflag = 1 ; 

update gapratesrevision
set activeflag = 0,
	updatedby = 'CDM-25821',
	updatedon = now()
where gaprateid = '95e323ba-6b8d-47ce-a0df-6bd13d7de550'
	and activeflag = 1 ; 

select routingid, routingstatustypeid, remarks, insertedon, insertedby, activeflag
	from routing 
where objectid = '95e323ba-6b8d-47ce-a0df-6bd13d7de550'
	and eventcode = 'GARR'
	and activeflag = 1 ;

update routing
set activeflag = 0,
	updatedby = 'CDM-25821',
	updatedon = now()
where objectid = '95e323ba-6b8d-47ce-a0df-6bd13d7de550'
	and eventcode = 'GARR'
	and activeflag = 1 ;
