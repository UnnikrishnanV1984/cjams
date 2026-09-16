/*
Root Cause:user error,  user incorrectly select the Child Fatality as no instead of yes and requested to update.
Fix Provided (Data Fix Only): Data fix is done by updating the child fatality from No to Yes
Data/Code fix ticket#: CJAMS-67042
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: this was a one time data correction specific  to a single referral.
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/

update intakeservicerequestsdm 
set ischildfatality =true, updatedby ='CJAMS-67042', updatedon =now()
where intakeservicerequestsdmid ='62abf2b6-7382-4cde-9423-d9476278d210' and intakeserviceid ='951d399f-edaa-4d55-9a0e-660238edbe26';