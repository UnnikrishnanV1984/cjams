/*
   Issue Description: CJAMS-68166
   Category/ Module: person & Contacts
   Root cause: User requested to data fix to remove Pamela Spangler from this case(3242307), as she was added to the wrong case accidentally. 
   Fix Provided: Data fix was done by removing Pamela Spangler from this case(3242307)
   Code Fix: Not Needed
*/


update actor 
set activeflag =0, updatedby ='CJAMS-68166', updatedon =now()
where actorid ='6f40869c-bfd1-4046-b98a-2aaf21afb7a7' and activeflag =1;

update intakeservicerequestactor 
set activeflag =0, updatedby ='CJAMS-68166', updatedon =now()
where intakeservicerequestactorid ='79675b34-9314-4e13-98c9-602a34b4e06f' and activeflag =1;

update personrole 
set activeflag =0, updatedby ='CJAMS-68166', updatedon =now()
where personroleid ='bfd7146d-4ed6-4433-8e67-f93e19f5e132' and activeflag =1;

update personroletype 
set activeflag =0, updatedby ='CJAMS-68166', updatedon =now()
where personroletypeid ='ff40f785-73ed-473e-8771-cb41585dc221' and activeflag =1;

update actorrelationship 
set activeflag =0, updatedby ='CJAMS-68166', updatedon =now()
where intakeservicerequestactorid ='79675b34-9314-4e13-98c9-602a34b4e06f' and activeflag =1;