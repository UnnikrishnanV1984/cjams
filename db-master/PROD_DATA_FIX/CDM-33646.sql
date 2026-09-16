/*
 * CDM-33646 - CJAMS Intake I231010927751 (Urgent)
 * Focus Area:Decision
 * The intake has been screened In and not generating the service case
 * Generate the service case and connect that service case to Intake # I231010927751
 * Assigned worker, Ms. Lametia Hutchinson-Dia
 * 
 * */

 
-- email = jessica.roundtree@maryland.gov, -- securityusersid = fc251376-8745-4381-a750-6a617c748678 
select * from createservicecase('877bc943-7572-431b-a2d7-9537d64ecf70', null, 1,'fc251376-8745-4381-a750-6a617c748678', 'intake');

UPDATE cjams.servicecase
SET statustypekey='Open' 
WHERE servicecaseid in (
select distinct servicecaseid from intakeservicerequest where intakenumber  = 'I231010927751' 
);