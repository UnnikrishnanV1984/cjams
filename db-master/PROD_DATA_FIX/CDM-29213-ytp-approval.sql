/*
   Issue Description: CDM-29213
   Category/ Module  : YTP case plan is approved but is still showing in my Approval Inbox. Appears to be stuck.
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update
   routing
set
   activeflag = 0,
   updatedby = 'CDM-29213',
   updatedon = now()
where
   routingid = 'e104767e-43b2-46e1-a2d1-a7e64d3330ae';