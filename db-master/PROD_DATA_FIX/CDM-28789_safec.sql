/*
   Issue Description: CDM-28789
   Category/ Module  : Safe-c
   Root cause:221030032600:SAFE C was approved but by a Marsha Towson, it should be my supervisor Tina Fazenbaker--approved date is 2/1/2023
   Pull request# for code fix: It's a data fix
   Reason why no related code fix:  
   
*/

update assessment set updatedby ='68ded231-16ad-4c93-a496-273eb0a62c02', updatedon= now(), 
 submissiondata = (replace (submissiondata::text,'"safetyassessmentapprovaldate": "2023-02-15T14:49"','"safetyassessmentapprovaldate": "2023-02-01T14:49"') 
)::json
where assessmentid ='2a0d3799-9a92-41a1-aacd-3d6b2d8d3f84';

 