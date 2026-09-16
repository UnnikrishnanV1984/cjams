/*
  Issue Description: CDM-35838 Safe C assessment
   Category/ Module  :  user management
   Root cause: 231021286948:Unable to close case because system does not recognize approved safe C an time response
   Fix Provided: Data fix for updating intakeservicerequestactorid in assessement actor to enable safe-c checklist for case closure
*/
-- email:'maureen.azonobi@maryland.govv'


update assessmentactor 
set 
intakeservicerequestactorid='6f1591f0-3ce1-47da-afed-ed34272f6458',
updatedon = now(), 
updatedby = 'CDM-35838'
where 
intakeservicerequestactorid='2d21239e-0b86-4694-afa2-5ae8e6ab8916'
and activeflag=1;

update assessmentactor 
set 
intakeservicerequestactorid='6275edfe-d22b-4e05-8c13-0d8f8fb50605',
updatedon = now(), 
updatedby = 'CDM-35838'
where 
intakeservicerequestactorid='f63a4629-46d1-4b94-851e-518c95dcccf9'
and activeflag=1;

update assessmentactor 
set 
intakeservicerequestactorid='edea92b4-0019-46e0-8a16-0373784b7e39',
updatedon = now(), 
updatedby = 'CDM-35838'
where 
intakeservicerequestactorid='f716f0bf-8484-472d-8576-ec4d46ceda39'
and activeflag=1;
