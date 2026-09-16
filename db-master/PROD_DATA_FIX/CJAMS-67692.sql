/*
  Issue Description: CJAMS-67692- Data fix needed to update the overdue reason
  Root cause: User requested to update overdue reasons as incorrect dropdown values are selected
  Fix provided : Data fix has been done to update the overdue reason as follows
                 Contact with Alleged Victim Completed : Child out of the jurisdiction / ROA pending - Family is out of State
                 Contact with Other Children Attempted or Completed : Child out of the jurisdiction / ROA pending - Family is out of State
                 Contact with Initial Contact Caregiver Attempted or Completed : Initial Contact Caregiver out of the jurisdiction / ROA pending - Family is out of State
  Regression Impacts: N/A
  Is Code fix needed: No
  Reason why no related code fix: It's a user input error and data fix should resolve it. 
*/



update cpsresponsetimeractions 
set cpsresponsetimerreason1 = 'VCOJ',
    cpsresponsetimerreason2 = 'VROJ',
    cpsresponsetimerreason4 = 'OCOJ',
    cpsresponsetimerreason5 = 'ORIJ',
    cpsresponsetimerreason7 = 'CCOJ',
    cpsresponsetimerreason8 = 'CROJ',
    updatedby ='CJAMS-67692',
    updatedon =now()
where intakeserviceid = '32e22ddd-b394-4cd5-8280-348bd3082567' 
and cpsresponsetimeractiontype  = 'Save'
and activeflag = 1;