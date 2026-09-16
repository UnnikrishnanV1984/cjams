-- CDM-16407 - Placement needs to be voided (living arrangement)
/*
-- Issue Description: 
   User request delete the living arrangement (Placement)
   
-- Case ID: 3211604
-- Client ID: 3259110 (MATTHEW TALLEY) - f1d8ad90-8d43-4bd5-9d0a-dbe52046cd57
-- LA Placement ID: 1551649 - 2012-09-10 To Current - 9fe82587-ae4a-49de-bb4b-0c430f32d3a6
  
-- Category/ Module: Living Arrangement (Case Management) 
-- Root cause: User error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select activeflag, alternateid, placementtypekey, startdatetime, enddatetime, updatedby, updatedon
	from placement 
where placementid = '9fe82587-ae4a-49de-bb4b-0c430f32d3a6'
	and activeflag = 1 ;

update placement 
set activeflag = 0,
	enddatetime = startdatetime,
	updatedby = 'CDM-16407',
	updatedon = now()
where placementid = '9fe82587-ae4a-49de-bb4b-0c430f32d3a6'
	and activeflag = 1 ;
	
select activeflag, entrydate, exitdate, updatedby, updatedon 
	from placementrevision 
where placementid = '9fe82587-ae4a-49de-bb4b-0c430f32d3a6'
	and activeflag  = 1 ;

update placementrevision 
set activeflag = 0,
	exitdate = entrydate,
	updatedby = 'CDM-16407',
	updatedon = now()
where placementid = '9fe82587-ae4a-49de-bb4b-0c430f32d3a6'
	and activeflag = 1 ;
	
select activeflag, livingid, livingstartdate, livingenddate, livingarrangementtypekey, updatedby, updatedon
	from livingarrangement  
where placementid = '9fe82587-ae4a-49de-bb4b-0c430f32d3a6'
	and activeflag = 1 ;

update livingarrangement 
set activeflag = 0,
	livingenddate = livingstartdate,
	updatedby = 'CDM-16407',
	updatedon = now()
where placementid = '9fe82587-ae4a-49de-bb4b-0c430f32d3a6'
	and activeflag = 1 ;	
	
select activeflag, eventcode, routingstatustypeid, routeddescription, updatedby, updatedon 
	from routing 
where objectid = '9fe82587-ae4a-49de-bb4b-0c430f32d3a6'
	and eventcode = 'PLTR'
	and activeflag = 1 ;

update routing 
set activeflag = 0,
	updatedby = 'CDM-16407',
	updatedon = now()
where objectid = '9fe82587-ae4a-49de-bb4b-0c430f32d3a6'
	and eventcode = 'PLTR'
	and activeflag = 1 ;
