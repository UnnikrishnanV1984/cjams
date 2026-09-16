







/*
Ticket no:- CJAMS-67759
Issue: Will not allow screen out recommendation.
Root Cause: update the LRR reason value for CPS IR # 261023640408 as below:

Contact with Alleged Victim Completed : Case not assigned timely / Supervisor delays

Contact with Initial Contact Caregiver Attempted or Completed : Case not assigned timely / Supervisor delays
Fix Provided: Data fix has been done to update the overdue reason.
Data/Code fix ticket#: CJAMS-67759
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
*/

update cpsresponsetimeractions 
set cpsresponsetimerreason1 = 'VCNT',
    cpsresponsetimerreason2 = 'VSDT',
    cpsresponsetimerreason7 = 'CCNT',
    cpsresponsetimerreason8 = 'CSDT',
    updatedby ='CJAMS-67759',
    updatedon =now()
where intakeserviceid = 'f192bdc5-d734-4c7b-955d-b0fb87c610a6' 
and cpsresponsetimeractiontype  = 'Save'
and activeflag = 1;