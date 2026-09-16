/*
 * CDM-34743 - Person not showing in case
 * Customer Email ID:ronda.lewis@maryland.gov
 * Customer Name:Ronda Lewis
 * Description - 221030013513:I am entering a CJAMS ticket for the persons involved in Paris Keene's services case #221030013513, 
 * it is only showing in the household Paris A Keene and Nyla Peak however, her daughter Neveah Peak (3/13/2023) when searched says 
 * she is a part of the case and unable to be added but she is not showing up in the household and/or others tab.  
 * This is the child that is being addressed in the case.
 * Verified in Prod, the child ( Nevaeh Skye Peak / CJAMS PID# : 201214040) is available in the intake # I231011327290 
 * but not on service case # 221030013513. 
 */


--SELECT * FROM getpersonsbyservicecase('2f69ce93-59b9-41f7-815a-e65e02fb2658', 1, 100)
--select isprimary , * from Intakeservicerequestactor where intakeserviceid  = '43861178-69da-4cd1-8173-a77e87325332' and personid ='1c213f36-a61d-43f8-91de-b23b2aa7c9b6'

-- Case ID 221030013513 
-- Update servicecaseid = '2f69ce93-59b9-41f7-815a-e65e02fb2658'    
select servicecaseid, intakenumber, intakeserviceid, * 
from actor where personid = '1c213f36-a61d-43f8-91de-b23b2aa7c9b6'
and intakenumber = 'I231011327290'
and activeflag = 1;
UPDATE cjams.actor
SET servicecaseid='2f69ce93-59b9-41f7-815a-e65e02fb2658'::uuid, updatedby = 'CDM-34743', updatedon = now() 
WHERE actorid='dde30030-6846-45fc-9661-1f0a9a0de42c'::uuid; 


select servicecaseid,  intakenumber, intakeserviceid, * 
from intakeservicerequestactor 
where personid = '1c213f36-a61d-43f8-91de-b23b2aa7c9b6'
and intakenumber = 'I231011327290'
and activeflag = 1;
UPDATE cjams.intakeservicerequestactor
SET servicecaseid='2f69ce93-59b9-41f7-815a-e65e02fb2658'::uuid, updatedby = 'CDM-34743', updatedon = now() 
WHERE intakeservicerequestactorid='0280f68f-9cf9-462c-bbe1-0dbd6067a175'::uuid; 
