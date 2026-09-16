/*
  Issue Description: CJAMS-67758- Data fix needed to update the overdue reason
  Root cause: User requested to update overdue reasons as incorrect dropdown values are selected
  Fix provided : Data fix has been done to update the overdue reason as follows
                 Contact with Alleged Victim Completed : Case not assigned timely / Supervisor delays
                 Contact with Initial Contact Caregiver Attempted or Completed : Case not assigned timely / Supervisor delays
  Regression Impacts: N/A
  Is Code fix needed: No
  Reason why no related code fix: It's a user input error and data fix should resolve it. 
*/



update cpsresponsetimeractions 
set cpsresponsetimerreason1 = 'VCNT',
    cpsresponsetimerreason2 = 'VSDT',
    cpsresponsetimerreason7 = 'CCNT',
    cpsresponsetimerreason8 = 'CSDT',
    updatedby ='CJAMS-67758',
    updatedon =now()
where intakeserviceid = '7f8361d1-4945-4339-8853-e11d1c316ce1' 
and cpsresponsetimeractiontype  = 'Save'
and activeflag = 1;