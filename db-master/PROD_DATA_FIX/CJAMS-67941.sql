/*
  Issue Description: 261023571551- Data fix needed to update the overdue reason
  Root cause: User requested to update overdue reasons as incorrect dropdown values are selected
  Fix provided : Data fix has been done to update the overdue reason as follows
              Contact with Alleged Victim Completed : Initial contact with family would place child's safety at risk
  Regression Impacts: N/A
  Is Code fix needed: No
  Reason why no related code fix: It's a user input error and data fix should resolve it. 
*/



update cpsresponsetimeractions 
set cpsresponsetimerreason1 = 'VISR',
    updatedby ='CJAMS-67941',
    updatedon =now()
where intakeserviceid = '6de855b0-9b70-46bc-90ad-748e5657791e' 
and cpsresponsetimeractiontype  = 'Save'
and activeflag = 1;