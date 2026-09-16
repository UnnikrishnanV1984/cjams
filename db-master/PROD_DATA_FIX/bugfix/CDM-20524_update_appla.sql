
/*
File Name: CDM-20524
-- Issue Description: 
1. For the existing approved appla, please do a data fix to update the names as below,

Case worker - Samantha Sievering

Supervisor - Ann-Louise Hardesty 

2. For new appla, pPlease check why 'Susan Loysen' is set to supervisor name even though the appla is approved by different supervisor.
-- Category/ Module: Case Management
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


update assessment 
set submissiondata = replace(submissiondata::text, '"caseworkername": "Ann-Louise Hardesty", "supervisorname": "Susan Loysen"' , '"caseworkername": "Samantha Sievering", "supervisorname": "Ann-Louise Hardesty"')::json
where assessmentid='237b1678-9481-47f3-824e-3f9952b78203';
