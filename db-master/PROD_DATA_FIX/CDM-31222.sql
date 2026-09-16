/*
   Issue Description: CDM-31222
   Category/ Module  : assessment
   Root cause:user want to update caseworker name 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    . Need to do data fix
*/ 

UPDATE cjams.assessment
SET submissiondata = jsonb_set(submissiondata, '{caseworkername}','"Linda Lateef"'),updatedon=now(),
 updatedby ='926d2285-73bb-42d3-b45c-bb8a6d502f70'
where assessmentid ='2f2144a0-efb0-4bdf-b20f-ae54bff2a470';
