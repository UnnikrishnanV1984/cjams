/*
Issue:CPS-IR case 251022986216 was closed on 03/20/2025 with a decision to recommend for transfer. However, no service case was connected before closure. The user has now requested to link this closed IR case to service case 3255849.
Root Cause:The case was closed before a service case was connected, which caused the service section to remain empty. This wasn’t a defect but a process gap that now requires SSA approval to correct.
Fix Provided (Data Fix Only):Data fix was done by updating the intakeservicerequest table to link the closed CPS-IR case to the correct service case.
Data/Code fix ticket#: CJAMS-58808
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: The system behaved as designed. This was a manual oversight where the service connection was missed before closure. No recurring logic issue or application defect was identified.
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/


select * from cjams.createservicecase('3fd25ca2-5d4f-471f-a0a0-4db01c71b79a','cc1e2c54-dcac-42ab-b426-59abb3953d40',0,'7d13a2ae-7956-400f-9ff0-143123ce7b2c',null,null);
