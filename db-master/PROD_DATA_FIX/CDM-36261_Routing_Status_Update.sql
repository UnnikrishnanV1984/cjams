/*
 Issue Description: CDM-36261
 Category/ Module : Case Decision/Routing
 Root cause: Routing record was not updated to approved status during case closure and it is sitting with 'Review' status after case closure.
 Fix: Update the routing record to Approved status
 Pull request# for code fix: N/A
 Reason why no related code fix: 
 Need to do data fix
 */
-- Routing table update
-- routingstatustypeid (current) -- 15
-- routingstatustypeid (after change) -- 16

select * from routing where routingid = 'c3f3fcb2-e1b0-474c-9bd8-4667426cdbed';


UPDATE routing
	SET routingstatustypeid = 16,
		updatedon = now(),
		updatedby = 'CDM-36261'
	WHERE routingid = 'c3f3fcb2-e1b0-474c-9bd8-4667426cdbed';