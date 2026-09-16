/*
 Issue Description:CDM-18023
 Category/ Module: user remove
 Root cause: user couldnt delete two records
 Pull request# N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/
update intakeservicerequestactor set activeflag=0,updatedby='CDM-18023',updatedon=now() where intakeservicerequestactorid='5cba4c02-ea42-41f68816-762dd54211a6';
update intakeservicerequestactor set activeflag=0,updatedby='CDM-18023',updatedon=now() where intakeservicerequestactorid='fd6db20c-7e11-4c1ebe26-61ef817e05ce';