/*
  Issue Description: CJAMS-64952- Data fix needed to update the overdue reason
  Root cause: overdue response timer is indicating the response was not approved but seems user has not saved th  reason for AV, issue is not replicable hence proceeding with the datafix .
  Fix provided : Data fix has been done to update the overdue reason as follows
                  Over due reason first question 'Contact with Alleged Victim Completed' to be updated as below.
                 Alleged victim Unavailable
                 Attempted Face to Face
                 3-4 Attempts
  Regression Impacts: N/A
  Is Code fix needed: No
  Reason why no related code fix: It's a user input error and data fix should resolve it. 
*/



update cpsresponsetimeractions 
set cpsresponsetimerreason1 = 'VAVU',
    cpsresponsetimerreason2 = 'VAFF',
    cpsresponsetimerreason3 = 'V34F',
    updatedby ='CJAMS-64952',
    updatedon =now()
where intakeserviceid = '6659f3b1-6f6e-4d86-8ac4-647e169ebc24'
and cpsresponsetimeractiontype  = 'Save'
and activeflag = 1;
