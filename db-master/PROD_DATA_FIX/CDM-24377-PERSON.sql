
/*
   Issue Description: CDM-24377
   Category/ Module  :  Person
   Root cause: missing HOH person when it was converting to OOH
   Pull request# for code fix: 
   Reason why no related code fix: checked the proc changes everything is good seems to be it's a glitch
*/

update cjams.intakeservicerequestactor set servicecaseid ='d8eecf72-980f-4cfb-984e-c9a3a7d0cbc9', intakenumber ='I221010290480', 

updatedby ='CDM-24377', updatedon = now()

 where intakeservicerequestactorid ='cbe1654a-e9ec-4012-9ff7-ebf0ea1f17e5';