/*
  Issue Description: CJAMS-67735- Data fix needed to update the overdue reason
  Root cause: User requested to update overdue reasons as incorrect dropdown values are selected
  Fix provided : Data fix has been done to update the overdue reason as follows
                 Contact with Alleged Victim Completed : Alleged victim unavailable / Attempted Face to Face / 3-4 Attempts
  Regression Impacts: N/A
  Is Code fix needed: No
  Reason why no related code fix: It's a user input error and data fix should resolve it. 
*/



update cpsresponsetimeractions 
set cpsresponsetimerreason1 = 'VAVU',
    cpsresponsetimerreason2 = 'VAFF',
    cpsresponsetimerreason3 = 'V34F',
    updatedby ='CJAMS-67735',
    updatedon =now()
where intakeserviceid = '8db67433-5e79-4bcb-94f1-3b423c5b3288' 
and cpsresponsetimeractiontype  = 'Save'
and activeflag = 1;