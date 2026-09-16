/*
   Issue Description: CDM-32860
   Category/ Module  :  Person/Childremoval
   Root cause: servicecaseid number is missing in case connect
   Fix Provided: Did data fix to update servicecase id 
   Clone Ticket: CDM-32881	

*/

update cjams.intakeservicerequestactor set servicecaseid ='c718edf2-348f-4eb4-8954-61a519cac7c9', updatedby ='CDM-32860', updatedon = now()
where intakeservicerequestactorid in ('922ebf93-512a-4ae3-ae39-ba1b7679bf0e','c74ea26a-95d7-4ac5-a18f-efb7b9c80ed5','d2d26c5f-2015-430f-90aa-5099b235c2fb');