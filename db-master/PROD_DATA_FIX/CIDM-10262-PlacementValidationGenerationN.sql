/*
Issue Description: creating a placement validation records as the data fix for ticket CDM-43504 was deployed in production after the finance batch runs
Category/Module: Bug
Root cause: due to data glitch casused to missed placement validations.
Fix provided: DB queriescreating placement validations in sp_placement_validation_datafix Function
Data/Code fix ticket#: CIDM-10262
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Bug
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query 

*/


select cjams.sp_placement_validation_datafix('2025-03-05'::date,'2025-03-05'::date,'financeDFX');