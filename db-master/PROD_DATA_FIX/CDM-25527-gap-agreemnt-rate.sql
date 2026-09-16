-- CDM-23600 - Rate approval
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
	updatedby = 'CDM-25527',
	updatedon = now()
where gapagreementrateid = '85735e11-b36a-4fce-a223-3d33bf902f62'
	and activeflag  = 1 ;

 

update gapratesrevision
set activeflag = 0,
	updatedby = 'CDM-25527',
	updatedon = now()
where gaprateid = '85735e11-b36a-4fce-a223-3d33bf902f62'
	and activeflag = 1 ; 




update routing
set activeflag = 0,
	updatedby = 'CDM-25527',
	updatedon = now()
where objectid = '85735e11-b36a-4fce-a223-3d33bf902f62'
	and eventcode = 'GARR'
	and activeflag = 1 ;
