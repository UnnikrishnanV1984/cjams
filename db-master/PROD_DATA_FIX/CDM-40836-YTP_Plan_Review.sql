/*
Issue Description: CDM-40836 YTP Plan Remove
-- Category/ Module: Approval Inbox
-- Root cause: Youth Transition Plan is already approved but it is still displaying in my approval inbox.
-- Fix Provided: Datafix has been promoted to change the approval flag.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update routing
set   activeflag = 0,
      updatedon = now(),
      updatedby = 'CDM-40836'
where routingid = '8dccd8ec-e293-4005-bdb6-da351fdc449d'
and activeflag = 1;