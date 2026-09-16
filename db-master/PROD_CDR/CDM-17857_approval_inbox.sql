/*
   Issue Description: CDM-17857
   Category/ Module : approval inbox
   Root cause: user wants to remove pending approvals
   Pull request# for code fix: 
   Explanantion: user wants to remove pending approvals from the case pending screen
*/

update routing set activeflag = 0, updatedon = now(), updatedby = 'CDM-17857'
where routingid in ('12c88e03-9b2f-4ec4-bc28-35db2b377796','25fb49ff-5a30-4181-a2bc-ad3f398f9f65');
