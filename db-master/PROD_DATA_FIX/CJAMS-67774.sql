/*
  Issue Description: CJAMS-67774- Data fix needed to update the overdue reason
  Root cause: User requested to update overdue reasons as incorrect dropdown values are selected
  Fix provided : Data fix has been done to update the overdue reason as follows
                 Contact with Alleged Victim Completed : Case not assigned timely / Supervisor delays
  Regression Impacts: N/A
  Is Code fix needed: No
  Reason why no related code fix: It's a user input error and data fix should resolve it. 
*/



update cpsresponsetimeractions 
set cpsresponsetimerreason1 = 'VCNT',
    cpsresponsetimerreason2 = 'VSDT',
    updatedby ='CJAMS-67774',
    updatedon =now()
where intakeserviceid = 'd433dc6a-1dcd-4613-9014-8380183cc8dc' 
and cpsresponsetimeractiontype  = 'Save'
and activeflag = 1;
