 -- CDM-35507 - Approved YTP stuck in approval box
/* Issue Description:3124374:Approved YTP for Jameel Judd is stuck in approval inbox.

-- Case ID: 3124374

-- Category/ Module: Approval Inbox

-- Root cause: user wants to delete approved record which is still showing in inbox
-- Fix Provided:  set activeflag to 0 for specific case number for the supervisor provided from the approval inbox.
-- Pull request# N/A
*/

update routing 
set activeflag = 0, updatedby = 'CDM-35507', updatedon = now()
where routingid = 'caa8d3ef-3ed5-4404-b975-f971a3c50b5c';