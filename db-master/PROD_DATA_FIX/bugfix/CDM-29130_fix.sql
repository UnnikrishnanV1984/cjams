/*
   Issue Description:CDM-29130
   2. All information associated with Intake # I231010421779 should come over to the CPS AR case - FAIL the CPS AR case status should be accepted/screen-in not closed/screen-out
   
   email# meagann.ricker@maryland.gov
   
*/

UPDATE IntakeServiceRequestDispositionCode 
SET activeflag =1, 
intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690',
servicerequesttypeconfigiddispostionid = '4c6d4e10-5572-4cb0-8bd0-5d596e3e2588',
updatedby = 'CDM-29130',
updatedon = now() 
WHERE 
intakeservicerequestdispositioncodeid = '2bf6c8d4-b113-40be-8386-6b8e57b49a12';

UPDATE cjams.routing
SET routingstatustypeid=2, activeflag=1, updatedon=now()
WHERE routingid='8fcee401-1664-41b8-858d-2ab9c9e7472a' and objectid='I231010421779';
