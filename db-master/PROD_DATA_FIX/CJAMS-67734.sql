/*
  Issue Description: CJAMS-67734- Data fix needed to update the overdue reason
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
    updatedby ='CJAMS-67734',
    updatedon =now()
where intakeserviceid = '7fb49aeb-e04c-4a1d-aac8-a7ae4f263d4c' 
and cpsresponsetimeractiontype  = 'Save'
and activeflag = 1;