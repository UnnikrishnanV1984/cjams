/*
-- CDM-22447 - Approving ans Closing AR Case.
*/

update intakeservicerequest 
set exitdate = null, intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690', updatedon= now(), updatedby='CDM-22447'
where intakeserviceid = 'd259ec0b-5803-4044-a36d-e626f6ca17ee';

UPDATE IntakeServiceRequestDispositionCode 
SET activeflag =0, updatedby = 'CDM-22447', updatedon = now() 
WHERE intakeservicerequestdispositioncodeid = 'a561cfff-fd3e-4450-8145-175722dbd6ec';

update caseassignment set enddate = null, updatedon= NOW(), updatedby='CDM-22447' 
where caseassignmentid = 'f0132e39-f6dd-474a-b680-662b4e944053';