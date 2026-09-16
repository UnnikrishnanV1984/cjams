/*
   Issue Description: CDM-29230 - AR Summary malfunction 
   
   Verified in Prod, the AR Summary status is blank and the CPS AR case has been completed/closed. 
   Need to investigate why user can completed/closed the CPS AR case without completed the AR Summary.
   
   Category/ Module  :  closing Service Case
   Root cause: user requeseted to update Removal Info
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

select caseclosuresummaryid,* from caseclosuresummary where intakeserviceid = '29a19a4a-63f2-44f6-ad3d-baa76a17cfa9';

select intakeservicerequestactorid,* from caseclosureparticipant where caseclosuresummaryid = 'df5f9503-6961-4f11-944b-14c16d6f4744';

update caseclosureparticipant 
set activeflag=1, updatedon=now(), updatedby='CDM-29230'
where caseclosuresummaryid ='df5f9503-6961-4f11-944b-14c16d6f4744';
		