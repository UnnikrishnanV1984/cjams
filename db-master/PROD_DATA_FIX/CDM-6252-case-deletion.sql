--CDM-6252 -Case Deletion
-- Investigation cases: 'CW2189244','CW2189245'. Soft deleted the requested case as those are unwanted cases.
-- No program assigned and no any spefic person related to case.
--   Issue Description: CDM-6252 -Case Deletion
--    Category/ Module  :  Intake
--    Root cause: Very old case. Requested by user to delete this
--    Pull request# for code fix: NA
--    Reason why no related code fix: NA
--    Status of the code fix if already submitted and expected prod fix date: NA
update intakeservicerequest set activeflag=0, updatedby='CDM-6252',updatedon=now() where servicerequestnumber in ('CW2189244','CW2189245') and
intakeserviceid in ('4b27a0d3-3a53-482d-9313-d76016022e69','1d4f94d1-ec8b-4878-a66e-dfded1fcac24');