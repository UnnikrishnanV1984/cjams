/*
   Issue Description: CJAMS-68303
   Category/ Module: investigation finding > checklist
   Root Cause: User Wants to do case closure but mfira is not satified and not able to proceed further
   Fix Provided: Data fix has been provided by making the mfira child satisfied as safe-c and user is now able to proceed further
   Pull request for code fix: 
   Reason why no related code fix: 
*/


update assessmentactor
set intakeservicerequestactorid ='6014ac46-8d7b-4415-b5bc-99e62a1fbe80', updatedby ='CJAMS-68303', updatedon =now()
where assessmentid ='b6ad14dd-295e-4085-9e5a-e8f2f0ec23c9' and assessmentactorid ='11fae5b2-2781-427a-9b54-c73919bae9ff' 
and intakeservicerequestactorid ='ec5b0a73-2383-48ec-8a1f-1057d26c4a8d' and activeflag =1;