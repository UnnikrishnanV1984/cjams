-- CDM-29373 - Service Case
/*
-- Issue Description: 
-- I231010515570:I have screened this case in but it wot allow me to assign it and it wont generate a service case.
   
-- Category/ Module: Placement (Case Management) 
*/

--select intakeserviceid, servicecaseid from intakeservicerequest where intakenumber = 'I231010515570'
--select * from servicecase where intakeserviceid = 'b6ff1fc7-fcea-4b10-a8bf-bfe34d229e53';
--select * from createservicecase('b6ff1fc7-fcea-4b10-a8bf-bfe34d229e53', null, 1,'', 'intake');
-- caseid
select * from createservicecase('b6ff1fc7-fcea-4b10-a8bf-bfe34d229e53', null, 1,'a1038f73-ee59-409c-b61c-f37a14551bb5', 'intake');
