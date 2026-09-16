/*
  Issue Description: CJAMS-66244- Data fix needed to update the overdue reason
  Root cause: overdue response timer is indicating the response was not approved but seems user has not saved th  reason for AV, issue is not replicable hence proceeding with the datafix .
  Fix provided : Data fix has been done to update the overdue reason as follows
                  Contact with Alleged Victim Completed : Alleged victim unavailable / Insufficient information reported - attempts were made to obtain / 3-4 Attempts
                  Contact with Other Children Attempted or Completed : Other children Unavailable / Insufficient information reported - attempts were made to obtain / 3-4 Attempts
                  Contact with Initial Contact Caregiver Attempted or Completed : Initial Contact Caregiver Unavailable / Insufficient information reported - attempts were made to obtain / 3-4 Attempts
  Regression Impacts: N/A
  Is Code fix needed: No
  Reason why no related code fix: It's a user input error and data fix should resolve it. 
*/
update cpsresponsetimeractions 
set cpsresponsetimerreason1 = 'VAVU',
    cpsresponsetimerreason2 = 'VIIR',
    cpsresponsetimerreason3 = 'V34R',
    cpsresponsetimerreason4 = 'OOCN',
    cpsresponsetimerreason5 = 'OIIN',
    cpsresponsetimerreason6 = 'O34N',
    cpsresponsetimerreason7 = 'CCCN',
    cpsresponsetimerreason8 = 'CIIN',
    cpsresponsetimerreason9 = 'C34N',
    updatedby ='CJAMS-66244',
    updatedon =now()
where intakeserviceid = '9e5dbe5f-0cc9-4757-baaa-0e0bb71e36f9'
and cpsresponsetimeractiontype  = 'Save'
and activeflag = 1;