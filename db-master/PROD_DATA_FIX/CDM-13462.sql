UPDATE caseassignment 
SET enddate = null,
updatedby = 'CDM-13462',
updatedon = now() 
WHERE objectid = '08462566-3ed4-4c63-b221-d9782981f4f1' AND toworkeridno = '24104a9a-8967-4680-a6bc-c375a0abfb30';

UPDATE intakeservicerequest 
SET exitdate = null, intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690',
updatedby = 'CDM-13462',
updatedon = now()
WHERE intakeserviceid = '08462566-3ed4-4c63-b221-d9782981f4f1';

UPDATE routing 
SET activeflag = 0
WHERE objectid = 'bbab7876-0211-4ad5-9c41-64a910a7df8a';

UPDATE intakeservicerequestdispositioncode 
SET reviewcomments = 'Reverting on user request',
updatedby = 'CDM-13462',
updatedon = now()
WHERE intakeservicerequestdispositioncodeid = 'bbab7876-0211-4ad5-9c41-64a910a7df8a';

update cjams.personprogramarea set enddate =null, updatedby ='CDM-13462', updatedon =now() where objectid ='08462566-3ed4-4c63-b221-d9782981f4f1';
