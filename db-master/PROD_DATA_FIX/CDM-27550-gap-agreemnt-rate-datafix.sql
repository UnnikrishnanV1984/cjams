-- CDM-27550 - Rate approval
/*
-- Issue Description: 
   Subsidy rate stuck in review mode-
   
-- Case ID: 3050904
-- Category/ Module: Accounts Payable (Finance Management)
-- Root cause: 
-- Pull request# 6568
-- Reason why no related code fix
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/




update gapagreementrate
set activeflag = 0,
	updatedby = 'CDM-27550',
	updatedon = now()
where gapagreementrateid = 'b7ea9674-da6e-490d-93bf-43484fdf9c7d'
	and activeflag  = 1 ;

 

update gapratesrevision
set activeflag = 0,
	updatedby = 'CDM-27550',
	updatedon = now()
where gaprateid = 'b7ea9674-da6e-490d-93bf-43484fdf9c7d'
	and activeflag = 1 ; 




update routing
set activeflag = 0,
	updatedby = 'CDM-27550',
	updatedon = now()
where objectid = 'b7ea9674-da6e-490d-93bf-43484fdf9c7d'
	and eventcode = 'GARR'
	and activeflag = 1 ;
