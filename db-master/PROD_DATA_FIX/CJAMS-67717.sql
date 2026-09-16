/*
  Issue Description: CJAMS-67717- Data fix needed to update the overdue reason
  Root cause: User requested to update overdue reasons as incorrect dropdown values are selected
  Fix provided : Data fix has been done to update the overdue reason as follows
                 Contact with Alleged Victim Completed : Alleged victim unavailable / Insufficient information reported - attempts were made to obtain / 1-2 Attempts
  Regression Impacts: N/A
  Is Code fix needed: No
  Reason why no related code fix: It's a user input error and data fix should resolve it. 
*/



update cpsresponsetimeractions 
set cpsresponsetimerreason1 = 'VAVU',
    cpsresponsetimerreason2 = 'VIIR',
    cpsresponsetimerreason3 = 'V12R',
    updatedby ='CJAMS-67717',
    updatedon =now()
where intakeserviceid = 'd5712e5e-acfd-4b8f-9704-88cf400e0120' 
and cpsresponsetimeractiontype  = 'Save'
and activeflag = 1;