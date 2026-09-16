-- CDM-24424 - Placement entered twice
/*
-- Issue Description: 
   User request delete the Rejected Duplicate living arrangement (Placement)
   
-- Case ID: 221030016715
-- Client ID: 200879153 (Aaliyah M Robinson) - 04ce1df2-f73f-405b-a4e4-da1155a699da
-- Placemet ID: 1573957	LA	2022-08-05 09:00:00 - Rejected - a38a1095-85b7-4386-9b26-7ffdebf7b893
-- Type: Relative/fictive kin home
  
-- Category/ Module: Living Arrangement (Case Management) 
-- Root cause: User error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select activeflag, alternateid, placementtypekey, startdatetime, enddatetime, updatedby, updatedon
	from placement 
where placementid = 'a38a1095-85b7-4386-9b26-7ffdebf7b893'
	and activeflag = 1 ;

update placement 
set activeflag = 0,
	updatedby = 'CDM-24424',
	updatedon = now()
where placementid = 'a38a1095-85b7-4386-9b26-7ffdebf7b893'
	and activeflag = 1 ;
	
select activeflag, entrydate, exitdate, updatedby, updatedon 
	from placementrevision 
where placementid = 'a38a1095-85b7-4386-9b26-7ffdebf7b893'
	and activeflag  = 1 ;

update placementrevision 
set activeflag = 0,
	updatedby = 'CDM-24424',
	updatedon = now()
where placementid = 'a38a1095-85b7-4386-9b26-7ffdebf7b893'
	and activeflag = 1 ;
	
select activeflag, livingid, livingstartdate, livingenddate, livingarrangementtypekey, updatedby, updatedon
	from livingarrangement  
where placementid = 'a38a1095-85b7-4386-9b26-7ffdebf7b893'
	and activeflag = 1 ;

update livingarrangement 
set activeflag = 0,
	updatedby = 'CDM-24424',
	updatedon = now()
where placementid = 'a38a1095-85b7-4386-9b26-7ffdebf7b893'
	and activeflag = 1 ;	
	
select activeflag, eventcode, routingstatustypeid, routeddescription, updatedby, updatedon 
	from routing 
where objectid = 'a38a1095-85b7-4386-9b26-7ffdebf7b893'
	and eventcode = 'PLTR'
	and activeflag = 1 ;

update routing 
set activeflag = 0,
	updatedby = 'CDM-24424',
	updatedon = now()
where objectid = 'a38a1095-85b7-4386-9b26-7ffdebf7b893'
	and eventcode = 'PLTR'
	and activeflag = 1 ;

