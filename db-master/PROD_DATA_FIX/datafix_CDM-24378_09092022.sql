-- CDM-24378 - Placement
/*
-- Issue Description: 
   User request to reverse the GAP Application (Application tab) approval and work on the case from teh start.
   
-- Case ID: 3293500
-- Client ID: 4243684 (ZYIAH L DILLARD) - 63e5472a-63d2-4a2e-a860-828f59c58ec7
-- GAP ID: 1006113 - Null To 05/29/2036 - 637a6a5c-a626-4985-b7bf-0dffed554480
-- gapagreementid: d85950a8-5269-44b8-b7f3-87f1be438c01
-- gapapplicationid: 8c1ddf94-e6c5-451f-8f7f-0fadff0f02d5
-- No GAP Rates

-- Category/ Module: GAP (Case Management) 
-- Root cause: User Error
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A 
*/

select alternateid, gapid, guardianonename, guardianoneid, guardianoneproviderid, primaryrelationshipkey,
	guardiantwoname, guardiantwoid, guardiantwoproviderid, secondaryrelationshipkey, 
	isapprovedkinshipplacement, isapprovedresourceparent, updatedby, updatedon
from guardianship 
where gapid = '637a6a5c-a626-4985-b7bf-0dffed554480'
	and activeflag = 1 ;

update guardianship 
set activeflag = 0,
	updatedby = 'CDM-24378',
	updatedon = now() 
where gapid = '637a6a5c-a626-4985-b7bf-0dffed554480'
	and activeflag = 1 ;
	
select gapid, activeflag, updatedby, updatedon 
	from gapapplication 
where gapapplicationid = '8c1ddf94-e6c5-451f-8f7f-0fadff0f02d5'
	and activeflag = 1 ;
	
update gapapplication	
set activeflag = 0,
	updatedby = 'CDM-24378',
	updatedon = now() 
where gapapplicationid = '8c1ddf94-e6c5-451f-8f7f-0fadff0f02d5'
	and activeflag = 1 ;
	
select routingid, routingstatustypeid, remarks, activeflag, updatedby, updatedon 
	from routing 
where objectid = '8c1ddf94-e6c5-451f-8f7f-0fadff0f02d5'
	and eventcode = 'GAAP'
	and activeflag = 1 ;

update routing 
set activeflag = 0,
	updatedby = 'CDM-24378',
	updatedon = now() 
where objectid = '8c1ddf94-e6c5-451f-8f7f-0fadff0f02d5'
	and eventcode = 'GAAP'
	and activeflag = 1 ;
	
select gapagreementid, activeflag, updatedby, updatedon 
	from gapagreement 
where gapagreementid = 'd85950a8-5269-44b8-b7f3-87f1be438c01' 
	and activeflag = 1 ;

update gapagreement
set activeflag = 0,
	updatedby = 'CDM-24378',
	updatedon = now() 
where gapagreementid = 'd85950a8-5269-44b8-b7f3-87f1be438c01' 
	and activeflag = 1 ;

select gapagreementrevisionid, activeflag, updatedby, updatedon  
	from gapagreementrevision 
where gapagreementid = 'd85950a8-5269-44b8-b7f3-87f1be438c01'
	and activeflag = 1 ;

update gapagreementrevision
set activeflag = 0,
	updatedby = 'CDM-24378',
	updatedon = now() 
where gapagreementid = 'd85950a8-5269-44b8-b7f3-87f1be438c01'
	and activeflag = 1 ;
	
select * 
	from routing 
where objectid = 'd85950a8-5269-44b8-b7f3-87f1be438c01'
	and eventcode = 'GAAR'
	and activeflag = 1 ;

update routing	
set activeflag = 0,
	updatedby = 'CDM-24378',
	updatedon = now()
where objectid = 'd85950a8-5269-44b8-b7f3-87f1be438c01'
	and eventcode = 'GAAR'
	and activeflag = 1 ;
