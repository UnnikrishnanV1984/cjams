/*
  Issue Description: CJAMS-61947- Data fix needed to update the overdue reason
  Root cause: Service case is not being populated for the intake (I251013268387) .
  Fix provided : Data fix has been done to update the overdue reason as follows
                 For CPS-IR : 251023096435 case, Over due reason first question 'Contact with Alleged Victim Completed' to be updated as below.
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
    updatedby ='CJAMS-61947',
    updatedon =now()
where intakeserviceid = '9a75a903-3ac8-4907-bdd4-ca189bab4ed3'
and cpsresponsetimeractionsid = '4dff8336-5d46-4665-87db-5fc7a095421b'
and activeflag = 1;