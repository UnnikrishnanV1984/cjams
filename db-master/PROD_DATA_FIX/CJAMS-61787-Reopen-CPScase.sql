/*
   Issue Description: CJAMS-61787
   Category/ Module  : Case Reopen
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed and changed status to screenout
*/

update intakeservicerequest set exitdate = null, intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690', 
updatedon= now(), updatedby='CJAMS-61787'
where intakeserviceid = '7ce687c6-0998-4182-9beb-f9250dfe2b51';

-- 2024-02-08 21:10:25.647
update caseassignment set enddate = null, updatedon= now(), updatedby='CJAMS-61787' where caseassignmentid = '994eaeb5-6ed9-4581-a24f-615e1cf57dc4';


UPDATE IntakeServiceRequestDispositionCode 
SET activeflag =0, 
updatedby = 'CJAMS-61787',
updatedon = now() 
WHERE 
intakeservicerequestdispositioncodeid = '04ab44aa-2f7e-48ce-8afa-3ffe43756b45' and activeflag = 1;

