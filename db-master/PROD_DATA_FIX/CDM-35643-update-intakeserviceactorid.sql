
/*
   Issue Description: CDM-35643
   Category/ Module  : Safe C 
   Root cause: intakeservicerequestactorid aren't matching for safe-C and assessments which is causing the safe-C to not populate properly
   Resolution: intakeservicerequestactorid aren't matching for safe-C and assessments. so had to update the intakeservicerequestactorid to properly populate safe-C
   Fix Privided: 
*/



update
   assessmentactor 
set
   intakeservicerequestactorid = 'dbc4c181-1e94-4526-9f9e-4622a3c37d27', updatedon = now(), updatedby = 'CDM-35643'
where
   assessmentid = 'af072b86-22fc-47dc-99d9-adc5a58e3c18' 
   and intakeservicerequestactorid = '3540716f-65b1-4084-8494-4dbeb73f4616' 
   and activeflag = 1;
