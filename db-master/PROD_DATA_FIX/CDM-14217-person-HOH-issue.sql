update intakeservicerequestactor
set
isheadofhousehold = true,
updatedon = now(),
updatedby = 'CDM-14217'
where intakeservicerequestactorid in ('3be2ce85-9180-4d9f-8f45-a81f12dd83dc', 'ad04ff33-7afe-49fe-be6b-5d19cb571e30');