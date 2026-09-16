/*
Issue Description: CJAMS-69579
Root Cause: As court order remains active, the Health Medication screen attempts to retrieve associated HCDM data, which is unavailable for this specific order.
Fix Provided: Data fix has been provided by deactivating the court order in order to retrieve the hcdm data
Code Fix Needed: No
Regression Impacts: No
*/


update intakeservreqcourtorder
set activeflag =0, updatedby ='CJAMS-69579', updatedon =now()
where intakeservreqcourtorderid ='cfab7f69-fdd2-4d92-aeb6-1f25c955162d' and activeflag =1;