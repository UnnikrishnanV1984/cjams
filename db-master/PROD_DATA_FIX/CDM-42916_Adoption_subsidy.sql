-- CDM-42916 - Subsidy payment
/*
--	Issue Description: 
	User requested to delete the  last approved subsidy rate record   
-- Adoption Case ID: 202101105305
-- provider ID: 8075395	
-- Rates
-- Delete - d6b25cf3-1a7d-4fa6-8405-6a8841a28615

-- Category/ Module: Adoption Subsidy (Case Management) 
-- Root cause: User error 
-- Fix Provided: Datafix has been promoted to delete the  last approved record Adoption subsidy rate slab.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To delete the  last approved subsidy rate record
--adoptionagreement Rate ID: - d6b25cf3-1a7d-4fa6-8405-6a8841a28615
/*
select provider_id, startdate, enddate, paymentamout, updatedby, updatedon, activeflag
	from adoptioncaserevision
where adoptionagreementrateid = 'd6b25cf3-1a7d-4fa6-8405-6a8841a28615'
	and activeflag = 1 ;
*/

update adoptioncaserevision
set activeflag = 0,
	updatedby = 'CDM-42916',
	updatedon = now()
where adoptionagreementrateid = 'd6b25cf3-1a7d-4fa6-8405-6a8841a28615' 
	and activeflag = 1 ;

/*
select provider_id, startdate, enddate, paymentamout, updatedby, updatedon, activeflag
	from adoptioncaseagreementrate
where adoptionagreementrateid = 'd6b25cf3-1a7d-4fa6-8405-6a8841a28615'
	and activeflag = 1;
*/

update adoptioncaseagreementrate
set activeflag = 0,
	updatedby = 'CDM-42916',
	updatedon = now()
where adoptionagreementrateid = 'd6b25cf3-1a7d-4fa6-8405-6a8841a28615'
	and activeflag = 1;

/*
select routingid, eventcode, routingstatustypeid, activeflag, updatedby, updatedon
	from routing
where objectid = 'd6b25cf3-1a7d-4fa6-8405-6a8841a28615'
	and eventcode = 'AARR' -- Adoption Agreement Rate Review
	and activeflag = 1 ;
*/

update routing
set activeflag = 0,
	updatedby = 'CDM-42916',
	updatedon = now()
where objectid = 'd6b25cf3-1a7d-4fa6-8405-6a8841a28615'
	and eventcode = 'AARR' -- Adoption Agreement Rate Review
	and activeflag = 1 ;

