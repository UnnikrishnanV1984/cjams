/*
 Issue Description: CDM-36249
 Category/ Module : Routing
 Root cause: Case was routed to incorrect supervisor (to herself) and need to correct the routing.
 Fix: Update the routing record with the supervisor id, which user requested
 Pull request# for code fix: N/A
 Reason why no related code fix: 
 Need to do data fix
 */
-- Routing table update
-- tosecurityusersid (current) -- a0b41798-e864-415d-8647-1a44cb6c5bda (yolanda.byrd@maryland.gov)
-- tosecurityusersid (after change) -- 95b57433-f7c8-4735-86af-87f726510a59 (wanda.collins@maryland.gov)

select * from routing where routingid = '1a836493-722a-4cc7-bba2-c97247d3c59b';


UPDATE routing
	SET tosecurityusersid = '95b57433-f7c8-4735-86af-87f726510a59',
		updatedon = now(),
		updatedby = 'CDM-36249'
	WHERE routingid = '1a836493-722a-4cc7-bba2-c97247d3c59b';
