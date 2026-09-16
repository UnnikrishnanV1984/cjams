/*
Issue:251023144425:This case was initially received as a serious physical injury; however, the child has died as a result of their injuries. The child, Miami Mitchell (204183352) has a DOD entered. The "Child Fatality" radio button in the SDM needs to be updated to "Yes" to reflect the child's death
Root Cause:The child was intially added to the case with physical injury. The child has died due to injuries. User requested to update the child fatality button from "no" to "yes".
Fix Provided (Data Fix Only):Updated the child fatality in sdm for the client Miami Mitchell (204183352) .
Data/Code fix ticket#:
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: The child was alive during the intake and case creation and data fix is needed to update it.
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/

update intakeservicerequestsdm
set ischildfatality = true,
   updatedby = 'CJAMS-63277',  updatedon =now()
where intakeserviceid='d1c0ae3b-0bee-4990-a842-6af83a752f34' and activeflag =1;