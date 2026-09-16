/*
   Issue Description: CDM-31741
   Category/ Module  :Person  
   Root cause: intakeservicerequestactor data inserted wrongly 
   Pull request# for code fix: 
   Reason why no related code fix: 
    requested a data fix to resolve
*/

--Here due to  glitch intakeservicerequestactor updated both  servicecaseid and intakeserviceid that makes user display duplicate 
--checked with other persons in different cases it is working as expected only 

update cjams.intakeservicerequestactor set activeflag =1, servicecaseid = null,  updatedby ='CDM-31741', updatedon = now()
where intakeservicerequestactorid ='d91a1579-e16a-4e35-b8a1-0fd6dfa6c09e';

update cjams.intakeservicerequestactor set  intakeserviceid = null,  updatedby ='CDM-31741', updatedon = now()
where intakeservicerequestactorid ='da97fa13-83a3-47a4-b9e3-0ce7d193b2df';