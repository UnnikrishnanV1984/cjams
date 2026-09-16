/*
   Issue Description: CDM-28888
   2. All information associated with Intake # I231010424471 and I231010447451 should come over to the CPS AR case
   
   email# meagann.ricker@maryland.gov
   
*/

update intakeservicerequest set actiontype = 'AR', intakeservicerequestclassid = 'b74ded78-12dc-4e6d-94db-7662d6eaf093',
intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690', activeflag =1,
updatedon= now(), updatedby='CDM-28888'
where intakeserviceid in ('dda82ea2-efa6-436f-b5ff-3ebc267e901c', '54032fbd-74db-44c4-a1b2-5d61a55122d9');

UPDATE IntakeServiceRequestDispositionCode 
SET activeflag =1, 
servicerequesttypeconfigiddispostionid = '4c6d4e10-5572-4cb0-8bd0-5d596e3e2588',
intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690',
updatedby = 'CDM-28888',
updatedon = now() 
WHERE intakeserviceid in ('dda82ea2-efa6-436f-b5ff-3ebc267e901c', '54032fbd-74db-44c4-a1b2-5d61a55122d9') and 
intakeservicerequestdispositioncodeid in ('0c84f88a-0d42-4168-b9d2-c6e28e628c05', 'af1bce7f-e4e6-4e98-b150-c1cb01bd1338');