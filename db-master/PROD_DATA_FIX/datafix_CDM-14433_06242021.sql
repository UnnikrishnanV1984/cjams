-- CDM-14433 - Duplicate living arrangement
/*
-- Issue Description: 
   User request delete the Duplicate living arrangement (Placement)
   
-- Case ID: 211030008629 - kristine.wheland@maryland.gov
-- Client ID: 200771349	(Reign A Clemons) - b00d24e2-ccd5-4022-b6e1-df2226b5f956
-- LA Placement ID: 1564031 - 2021-06-10 To Current - 4523e32e-8d0f-4542-a8d8-919e4d1cda8a
  

-- Category/ Module: Living Arrangement (Case Management) 
-- Root cause: User error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select activeflag, alternateid, placementtypekey, startdatetime, enddatetime, updatedby, updatedon
	from placement 
where placementid = '4523e32e-8d0f-4542-a8d8-919e4d1cda8a'
	and activeflag = 1 ;

update placement 
set activeflag = 0,
	enddatetime = startdatetime,
	updatedby = 'CDM-14433',
	updatedon = now()
where placementid = '4523e32e-8d0f-4542-a8d8-919e4d1cda8a'
	and activeflag = 1 ;
	
select activeflag, entrydate, exitdate, updatedby, updatedon 
	from placementrevision 
where placementid = '4523e32e-8d0f-4542-a8d8-919e4d1cda8a'
	and activeflag  = 1 ;

update placementrevision 
set activeflag = 0,
	exitdate = entrydate,
	updatedby = 'CDM-14433',
	updatedon = now()
where placementid = '4523e32e-8d0f-4542-a8d8-919e4d1cda8a'
	and activeflag = 1 ;
	
select activeflag, livingid, livingstartdate, livingenddate, livingarrangementtypekey, updatedby, updatedon
	from livingarrangement  
where placementid = '4523e32e-8d0f-4542-a8d8-919e4d1cda8a'
	and activeflag = 1 ;

update livingarrangement 
set activeflag = 0,
	livingenddate = livingstartdate,
	updatedby = 'CDM-14433',
	updatedon = now()
where placementid = '4523e32e-8d0f-4542-a8d8-919e4d1cda8a'
	and activeflag = 1 ;	
	
select activeflag, eventcode, routingstatustypeid, routeddescription, updatedby, updatedon 
	from routing 
where objectid = '4523e32e-8d0f-4542-a8d8-919e4d1cda8a'
	and eventcode = 'PLTR'
	and activeflag = 1 ;

update routing 
set activeflag = 0,
	updatedby = 'CDM-14433',
	updatedon = now()
where objectid = '4523e32e-8d0f-4542-a8d8-919e4d1cda8a'
	and eventcode = 'PLTR'
	and activeflag = 1 ;


