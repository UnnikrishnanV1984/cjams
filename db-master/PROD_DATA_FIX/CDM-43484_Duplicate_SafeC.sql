/*
    Issue Description: CDM-43484
    Category/ Module  :  Safe c Assessment
    Root cause: listed 2 Xs on the Milestone Report. Reviewing the case, found 2 Safe-C approved in the exact same time.
     The Dates can remain the same but the time must change to 11/26/2024 Time 10:24PM is the first one, the second one 11/26/2024 Time change to 11:00 PM.
    Pull request# NA
    Reason why no related code fix: 
    Status of the code fix if already submitted and expected prod fix date: 
*/
UPDATE assessment
SET submissiondata = 
    REPLACE(submissiondata::text, '"safetyassessmentapprovaldate": "2024-11-26T22:24",', '"safetyassessmentapprovaldate": "2024-11-26T23:00",')::json,
    updatedon = now()
WHERE assessmentid = '71905329-6f4a-40b5-bde4-daf0eb49cbc8';
