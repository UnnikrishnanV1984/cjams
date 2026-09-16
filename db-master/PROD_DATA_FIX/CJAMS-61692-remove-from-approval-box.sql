/*
--	Issue Description: 
	User requested to delete the Adoption Agreement Rate Review for case # 3206429 
-- Adoption Case ID: 3206429
-- Rates
-- Category/ Module: Adoption Subsidy (Case Management) 
-- Root cause: User Request 
-- Fix Provided: Datafix has been promoted to delete the Adoption Agreement Rate Review for case # 3206429 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

--select activeflag,servicerequestnumber,* from routing where objectid = 'b0c9a717-56fc-42c2-886d-1f1e4335e09c' and activeflag=1;
update routing 
set activeflag = 0,
	updatedby = 'CJAMS-61692',
	updatedon = now()
where routingid = 'd417f54c-73e6-49ee-a282-90b06f75d7df'
	and eventcode = 'AARR'
	and activeflag = 1;