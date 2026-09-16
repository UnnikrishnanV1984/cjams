-- CDM-22793 - AR SUMMARY 
--Case number: 221020202571 --


update intakeservicerequest set exitdate = null, intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690', updatedon= now(), updatedby='CDM-22793'
where intakeserviceid = 'fcd3532b-300a-4e40-91b5-aa9380456856';

UPDATE IntakeServiceRequestDispositionCode 
SET activeflag =0, 
updatedby = 'CDM-22793',
updatedon = now() 
WHERE 
intakeservicerequestdispositioncodeid = '18183d0b-2a4e-4b5a-a11a-159afeeff907';

update caseassignment set enddate = null, updatedon= NOW(), updatedby='CDM-22793' where caseassignmentid = 'ce4abffb-4a4a-4a9c-8815-d718109894ec';
