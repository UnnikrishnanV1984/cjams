-- CDM-24826 - placements in error
/*
-- Issue Description: 
   User request delete 2 Duplicate living arrangement (Placement)
   
-- Case ID: 2020028003435
-- Client ID: 200158051 (Genesis Goktas) - c4119a57-c806-440e-8668-5ffc2036250c

-- Placement ID: 1562942 - 2021-04-29 To Current - 562c52e9-a99d-48b7-91a6-fc1848aad8d7
-- Living Arrangement Type: Blank 	

-- Placement ID: 1562031 - 2021-03-23 To Current - e8492987-e465-4f26-a99a-41b6e9a7764d
-- Living Arrangement Type: Relative/fictive kin home - Rejected
  
-- Category/ Module: Living Arrangement (Case Management) 
-- Root cause: User error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select activeflag, alternateid, placementtypekey, startdatetime, enddatetime, updatedby, updatedon
	from placement 
where placementid in ( '562c52e9-a99d-48b7-91a6-fc1848aad8d7', 'e8492987-e465-4f26-a99a-41b6e9a7764d' )
	and activeflag = 1 ;

update placement 
set activeflag = 0,
	updatedby = 'CDM-24826',
	updatedon = now()
where placementid in ( '562c52e9-a99d-48b7-91a6-fc1848aad8d7', 'e8492987-e465-4f26-a99a-41b6e9a7764d' )
	and activeflag = 1 ;
	
select activeflag, entrydate, exitdate, updatedby, updatedon 
	from placementrevision 
where placementid in ( '562c52e9-a99d-48b7-91a6-fc1848aad8d7', 'e8492987-e465-4f26-a99a-41b6e9a7764d' )
	and activeflag  = 1 ;

update placementrevision 
set activeflag = 0,
	updatedby = 'CDM-24826',
	updatedon = now()
where placementid in ( '562c52e9-a99d-48b7-91a6-fc1848aad8d7', 'e8492987-e465-4f26-a99a-41b6e9a7764d' )
	and activeflag = 1 ;
	
select activeflag, livingid, livingstartdate, livingenddate, livingarrangementtypekey, updatedby, updatedon
	from livingarrangement  
where placementid in ( '562c52e9-a99d-48b7-91a6-fc1848aad8d7', 'e8492987-e465-4f26-a99a-41b6e9a7764d' )
	and activeflag = 1 ;

update livingarrangement 
set activeflag = 0,
	updatedby = 'CDM-24826',
	updatedon = now()
where placementid in ( '562c52e9-a99d-48b7-91a6-fc1848aad8d7', 'e8492987-e465-4f26-a99a-41b6e9a7764d' )
	and activeflag = 1 ;	
	
select activeflag, eventcode, routingstatustypeid, routeddescription, updatedby, updatedon 
	from routing 
where objectid in ( '562c52e9-a99d-48b7-91a6-fc1848aad8d7', 'e8492987-e465-4f26-a99a-41b6e9a7764d' )
	and eventcode = 'PLTR'
	and activeflag = 1 ;

update routing 
set activeflag = 0,
	updatedby = 'CDM-24826',
	updatedon = now()
where objectid in ( '562c52e9-a99d-48b7-91a6-fc1848aad8d7', 'e8492987-e465-4f26-a99a-41b6e9a7764d' )
	and eventcode = 'PLTR'
	and activeflag = 1 ;
