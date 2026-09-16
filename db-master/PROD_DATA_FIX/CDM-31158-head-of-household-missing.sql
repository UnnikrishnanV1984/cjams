/*
   Issue Description: CDM-31158
   Category/ Module  :Person Tab 
   Root cause: House of headhold missing , wrong person linked with case 
   Pull request# for code fix: 
   Reason why no related code fix: 
    requested a data fix to resolve
*/

update intakeservicerequestactor set activeflag = 0, updatedby ='CDM-31158',updatedon =now() where personid = 'e0b5bf70-77aa-4696-8f1a-3a7c4afcbc77' and servicecaseid ='cea7d512-070b-4255-a098-bc586d0bb369' ;

update intakeservicerequestactor set isprimary = true,updatedby ='CDM-31158',updatedon =now() where intakeservicerequestactorid ='d2568241-d89a-45a2-af70-3cabed445edf';
