/*
   Issue Description: CDM-28873
   Category/ Module  : Opening case
   Root cause: .
   Pull request# for code fix: It's a data fix   
*/


update intakeservicerequestdispositioncode 
set activeflag = 0 ,
     updatedby ='CDM-28873',
     updatedon = now()
where intakeservicerequestdispositioncodeid = '9d4003e2-d536-4d4a-8d06-5022d72986da';

update intakeservicerequest 
set intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690',
     updatedby ='CDM-28873',
     updatedon = now()  
where intakeserviceid = 'adb03980-7837-4cc0-9faa-fab051a2eca3';