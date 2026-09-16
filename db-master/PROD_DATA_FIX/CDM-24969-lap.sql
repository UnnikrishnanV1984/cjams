/*
   Issue Description: CDM-24969
   Category/ Module  : Assessment
   Root cause: user requested to approve these records 
   Pull request# for code fix: 5930
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/



update cjams.assessment  set assessmentstatustypekey ='Accepted', updatedon  =now()

where submissionid ='62e403d4c840a4001b448d9c' and assessmentid ='5f5ee714-7c64-4f39-b17c-c12771b2da77';




update assessment set submissiondata = jsonb_set(submissiondata::jsonb, '{panel2740773786278622Columns2Whatworriesyou}', '"1"'), updatedby ='CDM-22722', updatedon =now()
where submissionid ='62e403d4c840a4001b448d9c' and assessmentid ='5f5ee714-7c64-4f39-b17c-c12771b2da77';


update cjams.assessment  set activeflag =0, updatedon  =now()

where submissionid ='62e17e18c5455c001bc22782' and assessmentid ='bddb5ded-665a-48c7-ba0d-44502f679cdd';