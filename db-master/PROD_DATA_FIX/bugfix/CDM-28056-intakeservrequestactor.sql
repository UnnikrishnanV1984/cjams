/*
   Issue Description: CDM-28056
   Category/ Module  :Person Module
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update cjams.intakeservicerequestactor 
set isprimary = true, updatedby = 'CDM-28056', updatedon = now()
where intakeservicerequestactorid = 'bf860760-4abf-4766-8530-d05b6696340a' and personid = '75c375d1-a6bf-4526-95d1-86b234df1841';

update cjams.intakeservicerequestactor 
set isprimary = false, updatedby = 'CDM-28056' , updatedon = now()
where intakeservicerequestactorid = '2e355aa0-107f-4764-9b68-c9628b1da757' and personid = '75c375d1-a6bf-4526-95d1-86b234df1841';

update cjams.intakeservicerequestactor 
set activeflag = 0, updatedby = 'CDM-28056', updatedon = now()
where intakeservicerequestactorid = 'f6520a24-d2cc-41a5-8c5c-e3ec3e40765b' and personid = 'd111aad4-0db3-46ef-9112-e84be3f30f32';

update cjams.actor 
set activeflag = 0, updatedby = 'CDM-28056' , updatedon = now()
where actorid = 'ee797573-a960-4e16-8406-0e86e362895b' and personid = 'd111aad4-0db3-46ef-9112-e84be3f30f32';