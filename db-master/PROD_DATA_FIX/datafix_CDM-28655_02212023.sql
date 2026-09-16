/*
   Issue Description: CDM-28655
   2. All information associated with Intake # I231010421779 should come over to the CPS AR case - FAIL the CPS AR case status should be accepted/screen-in not closed/screen-out
   
   email# meagann.ricker@maryland.gov
   
*/

update intakeservicerequest set exitdate = null, actiontype = 'AR', intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690', updatedon= now(), updatedby='CDM-28655'
where intakeserviceid = '15052245-1bb3-46ab-9f2e-a446eda0e0ec';

UPDATE IntakeServiceRequestDispositionCode 
SET activeflag =1, 
servicerequesttypeconfigiddispostionid = '94377120-38d7-461a-932f-457c3ef723ca',
updatedby = 'CDM-28655',
updatedon = now() 
WHERE 
intakeservicerequestdispositioncodeid = '2bf6c8d4-b113-40be-8386-6b8e57b49a12';