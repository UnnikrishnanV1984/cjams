/*
    Issue Description: CDM-43447
    Category/ Module  :  Safe c Assessment
    Root cause: listed 2 Xs on the Milestone Report. Reviewing the case, found 2 Safe-C approved in the exact same time.
    Pull request# NA
    Reason why no related code fix: 
    Status of the code fix if already submitted and expected prod fix date: 
*/
UPDATE assessment
SET submissiondata = 
    REPLACE(submissiondata::text, '"safetyassessmentapprovaldate": "2024-12-17T17:22",', '"safetyassessmentapprovaldate": "2024-12-17T18:00",')::json,
    --updatedby = 'CDM-43447',
    updatedon = now()
WHERE assessmentid = '030585e3-b0c8-4231-a7d2-c3766c917922';
