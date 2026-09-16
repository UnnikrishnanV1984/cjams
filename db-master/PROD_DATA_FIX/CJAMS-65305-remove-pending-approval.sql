/*
Issue:Need data fix to remove the Service Plan Review record from the worker Pending Approval dashboard.
Root Cause: requested to remove the Service Plan Review record
Fix Provided (Data Fix Only):Data fix was done by removing service Plan Review record from the worker Pending Approval dashboard.
Data/Code fix ticket#: CJAMS-65305
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/

update routing
set activeflag=0, updatedby='CJAMS-65305', updatedon=now()
where objectid='73533df6-8cf7-45f1-a0a3-36702d65f96b' and routingid='cc1ea621-bc16-4dc1-ab1f-9dd4327a8dd9' and activeflag=1;