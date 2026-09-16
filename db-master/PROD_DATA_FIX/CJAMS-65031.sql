/*
  Issue Description: CJAMS-65031- Data fix needed to update the overdue reason
  Root cause: overdue response timer is indicating the response was not approved but seems user has not saved th  reason for AV, issue is not replicable hence proceeding with the datafix .
  Fix provided : Data fix has been done to update the overdue reason as follows
                  Over due reason first question 'Contact with Alleged Victim Completed' to be updated as below.
                 Alleged victim Unavailable
                 Attempted Face to Face
                 1-2 Attempts
  Regression Impacts: N/A
  Is Code fix needed: No
  Reason why no related code fix: It's a user input error and data fix should resolve it. 
*/
update cpsresponsetimeractions 
set cpsresponsetimerreason1 = 'VAVU',
    cpsresponsetimerreason2 = 'VAFF',
    cpsresponsetimerreason3 = 'V12F',
    updatedby ='CJAMS-65031',
    updatedon =now()
where intakeserviceid = '80281702-8f76-461e-80bf-008d70a36b72'
and cpsresponsetimeractiontype  = 'Save'
and activeflag = 1;
