 -- CJAMS-85743 POSC won't leave dashboard in approval box
/* Issue Description:Case # 251030466958 POSC is already approved, but the request still displaying in the case pending approval.


-- Category/ Module: Approval Inbox

-- Root cause: user wants to delete approved record which is still showing in inbox
-- Fix Provided:  set activeflag to 0 for specific case number for the supervisor provided from the approval inbox.
-- Pull request# N/A
*/
update routing 
set activeflag = 0, updatedby = 'CJAMS-58743', updatedon = now()
where routingid = 'f24b3106-aaa7-43d6-835e-52bf58f63693' 
and activeflag = 1;