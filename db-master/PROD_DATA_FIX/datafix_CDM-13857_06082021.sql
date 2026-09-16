-- CDM-13857 - Delete living arrangement
/*
-- Issue Description: 
   User request delete the living arrangement dated 4/20/21 to biological parent
   This should have not been entered as a placement
   
-- Case ID: 3298492 - brittany.brendel@maryland.gov
-- Client ID: 4194991 (CALISTA ROSE	LITTLE) - 02fa5eb2-2164-4969-8e55-b4826357c388
-- LA Placement ID: 1562627- 2021-04-20 To Current - bcadaba8-efc4-4548-aa4b-7f70c895d97d

-- Category/ Module: Living Arrangement (Case Management) 
-- Root cause: User error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select activeflag, alternateid, placementtypekey, startdatetime, enddatetime, updatedby, updatedon
	from placement 
where placementid = 'bcadaba8-efc4-4548-aa4b-7f70c895d97d'
	and activeflag = 1 ;

update placement 
set activeflag = 0,
	enddatetime = startdatetime,
	updatedby = 'CDM-13857',
	updatedon = now()
where placementid = 'bcadaba8-efc4-4548-aa4b-7f70c895d97d'
	and activeflag = 1 ;
	
select activeflag, livingid, livingstartdate, livingenddate, livingarrangementtypekey, updatedby, updatedon
	from livingarrangement  
where placementid = 'bcadaba8-efc4-4548-aa4b-7f70c895d97d'
	and activeflag = 1 ;

update livingarrangement 
set activeflag = 0,
	livingenddate = livingstartdate,
	updatedby = 'CDM-13857',
	updatedon = now()
where placementid = 'bcadaba8-efc4-4548-aa4b-7f70c895d97d'
	and activeflag = 1 ;
	
select activeflag, eventcode, routingstatustypeid, routeddescription, updatedby, updatedon 
	from routing 
where objectid = 'bcadaba8-efc4-4548-aa4b-7f70c895d97d'
	and eventcode = 'PLTR'
	and activeflag = 1 ;

update routing 
set activeflag = 0,
	updatedby = 'CDM-13857',
	updatedon = now()
where objectid = 'bcadaba8-efc4-4548-aa4b-7f70c895d97d'
	and eventcode = 'PLTR'
	and activeflag = 1 ;
