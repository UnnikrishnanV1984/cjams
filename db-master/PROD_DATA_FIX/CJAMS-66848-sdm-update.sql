/*
Root Cause: User requested to update the Near-Death/Serious Physical Injury to Yes.
Fix Provided (Data Fix Only): Data fix is done by updating the Near-Death/Serious Physical Injury to Yes.
Data/Code fix ticket#: CJAMS-66848
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: this was a one time data correction specific  to a single referral.
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/

 
update intakeservicerequestsdm
set isseriousphysicalinjury = true, updatedby='CJAMS-66848', updatedon =now()
where intakeservicerequestsdmid ='e3f63217-9d8f-4cc0-8ed1-03b9cd917747' and intakeserviceid='0769a9d8-9b81-4229-a8bf-dbff795fc54f';