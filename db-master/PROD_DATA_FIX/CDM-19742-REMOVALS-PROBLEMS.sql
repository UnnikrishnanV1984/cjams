/*
   Issue Description: CDM-19742
   Category/ Module  : Approval screen
   Root cause: user asked to remove
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update intakeservreqchildremoval 
set servicecaseid = '7d7ab5aa-8885-4a7e-b1eb-c3f9075e564e', updatedby = 'CDM-19742', updatedon = now()
where intakeservreqchildremovalid = 'a1ef3628-4d2a-40d6-a26d-eb4ca2761448';

update intakeservreqchildremoval_history 
set servicecaseid = '7d7ab5aa-8885-4a7e-b1eb-c3f9075e564e', updatedby = 'CDM-19742', updatedon = now()
where intakeservreqchildremovalid = 'a1ef3628-4d2a-40d6-a26d-eb4ca2761448';

update placement 
set servicecaseid = '7d7ab5aa-8885-4a7e-b1eb-c3f9075e564e', updatedby = 'CDM-19742', updatedon = now()
where intakeservreqchildremovalid = 'a1ef3628-4d2a-40d6-a26d-eb4ca2761448';