/*
   Issue Description: CJAMS-68113
   Category/ Module  : person
   Root cause: User requested to data fix to remove CJAMS PID-204960478 from case -261023789192 from Persons tab
   Fix Provided: Data fix was done by removing CJAMS PID-204960478 from case -261023789192 from Persons tab
    Code Fix: Not Needed
*/



update actor
set activeflag =0, updatedby ='CJAMS-68113', updatedon =now()
where personid ='782ff452-6f1c-42c5-b025-ba3027971a24' and actorid ='39fdd70d-50ce-4a45-a781-5c5ed20e7b3f' and activeflag =1;

update intakeservicerequestactor 
set activeflag =0, updatedby ='CJAMS-68113', updatedon =now()
where intakeservicerequestactorid ='54d2365b-227d-42ce-ab33-f3ce94c6e44c' and activeflag =1;

update personrole 
set activeflag =0, updatedby ='CJAMS-68113', updatedon =now()
where personroleid ='dee18f58-b8f9-414c-be85-9d0652f33183' and activeflag =1;

update personroletype 
set activeflag =0, updatedby ='CJAMS-68113', updatedon =now()
where personroletypeid ='a2a89448-6a4e-4b70-b938-2e59f358043a' and personroleid ='dee18f58-b8f9-414c-be85-9d0652f33183' and activeflag =1;

update actorrelationship 
set activeflag =0, updatedby ='CJAMS-68113', updatedon =now()
where intakeservicerequestactorid ='54d2365b-227d-42ce-ab33-f3ce94c6e44c' and intakeserviceid ='ac691a31-c5fa-4a4a-a305-3bf0ee0d8e5f' and activeflag =1;

update personprogramarea 
set activeflag =0, updatedby ='CJAMS-68113', updatedon =now()
where personprogramid ='dd31a8ef-c1c1-4a1c-b37e-c9f19b51f417' and objectid ='ac691a31-c5fa-4a4a-a305-3bf0ee0d8e5f' and activeflag =1;