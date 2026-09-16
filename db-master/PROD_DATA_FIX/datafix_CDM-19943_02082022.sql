-- CDM-19943 - Placement needs to be voided
/*
-- Issue Description: 
   User request delete the living arrangement (Placement)
   
-- Case ID: 3246407
-- Client ID: 200301094 (Amour-dior	Psalm O'Dell) - 4bf6236a-874a-474e-823d-f0b07a6f2ab4
-- LA Placement ID: 1569454 - 2021-01-29 To Current - b1daa18e-ba20-4b03-a1c2-5a978510d189
-- Type: Runaway (RNW)
  
-- Category/ Module: Living Arrangement (Case Management) 
-- Root cause: User error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select activeflag, alternateid, placementtypekey, startdatetime, enddatetime, updatedby, updatedon
	from placement 
where placementid = 'b1daa18e-ba20-4b03-a1c2-5a978510d189'
	and activeflag = 1 ;

update placement 
set activeflag = 0,
	enddatetime = startdatetime,
	updatedby = 'CDM-19943',
	updatedon = now()
where placementid = 'b1daa18e-ba20-4b03-a1c2-5a978510d189'
	and activeflag = 1 ;
	
select activeflag, entrydate, exitdate, updatedby, updatedon 
	from placementrevision 
where placementid = 'b1daa18e-ba20-4b03-a1c2-5a978510d189'
	and activeflag  = 1 ;

update placementrevision 
set activeflag = 0,
	exitdate = entrydate,
	updatedby = 'CDM-19943',
	updatedon = now()
where placementid = 'b1daa18e-ba20-4b03-a1c2-5a978510d189'
	and activeflag = 1 ;
	
select activeflag, livingid, livingstartdate, livingenddate, livingarrangementtypekey, updatedby, updatedon
	from livingarrangement  
where placementid = 'b1daa18e-ba20-4b03-a1c2-5a978510d189'
	and activeflag = 1 ;

update livingarrangement 
set activeflag = 0,
	livingenddate = livingstartdate,
	updatedby = 'CDM-19943',
	updatedon = now()
where placementid = 'b1daa18e-ba20-4b03-a1c2-5a978510d189'
	and activeflag = 1 ;	
	
select activeflag, eventcode, routingstatustypeid, routeddescription, updatedby, updatedon 
	from routing 
where objectid = 'b1daa18e-ba20-4b03-a1c2-5a978510d189'
	and eventcode = 'PLTR'
	and activeflag = 1 ;

update routing 
set activeflag = 0,
	updatedby = 'CDM-19943',
	updatedon = now()
where objectid = 'b1daa18e-ba20-4b03-a1c2-5a978510d189'
	and eventcode = 'PLTR'
	and activeflag = 1 ;

