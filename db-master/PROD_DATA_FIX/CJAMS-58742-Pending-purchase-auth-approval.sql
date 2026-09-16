 -- CJAMS-58742- Pending purchase auth approval in approval box
/* Issue Description:Case # 241030344932 has been closed on 03/28/2025 in approval inbox.


-- Category/ Module: Approval Inbox

-- Root cause: user wants to delete approved record which is still showing in inbox
-- Fix Provided:  set activeflag to 0 for specific case number for the supervisor provided from the approval inbox.
-- Pull request# N/A
*/
update routing 
set activeflag = 0, updatedby = 'CJAMS-58742', updatedon = now()
where routingid = '347ce2b2-d1c0-4d69-9850-87ee5c9cad89' 
and activeflag = 1;
