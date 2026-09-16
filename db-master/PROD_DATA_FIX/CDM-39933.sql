/*
Issue Description: CDM-39933 Clear YTP
-- Category/ Module: Living Arrangement (Case Management)
-- Root cause: Youth Transition Plan is already approved but it is still displaying in my approval inbox.
-- Fix Provided: Datafix has been promoted to change the approval flag.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update routing
set   activeflag = 0,
      updatedon = now(),
      updatedby = 'CDM-39933'
where routingid = '6b5ae965-340b-476f-827a-0af570dbc1e9'
and 
activeflag = 1;