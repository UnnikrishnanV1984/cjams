 -- CJAMS-58718 - Approved YTP stuck in approval box
/* Issue Description:3287517, 3228736:Approved YTP for LePaul Morceau is stuck in approval inbox.


-- Category/ Module: Approval Inbox

-- Root cause: user wants to delete approved record which is still showing in inbox
-- Fix Provided:  set activeflag to 0 for specific case number for the supervisor provided from the approval inbox.
-- Pull request# N/A
*/
update routing 
set activeflag = 0, updatedby = 'CJAMS-58718', updatedon = now()
where routingid = '78e22bcb-288b-4002-9719-1800ac8630d7' 
and activeflag = 1;


update routing 
set activeflag = 0, updatedby = 'CJAMS-58718', updatedon = now()
where routingid = '2a3ad823-55a2-44d7-827c-fa8a05e9c18d' 
and activeflag = 1; 