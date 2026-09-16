/*
Issue: CJAMS-64580 Update overdue reasons on closed case
Category/Module: Response Timer
Root cause: Case has been closed and user requested to update the LLR information for the case 251023145173.
Fix provided:  Data fix has been done to update the LLR information for the case 251023145173
               Change the Contact with Alleged Victim Completed dropdown to alleged victim unavailable, 
               and Contact with Initial Contact Caregiver Attempted or Completed to Initial Contact Caregiver Unavailable / attempted face to face / 1-2 visits.
Data/Code fix ticket#: CJAMS-64580
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data entry error.
*/

update cpsresponsetimeractions
set cpsresponsetimerreason1 = 'VAVU', 
    cpsresponsetimerreason2 = 'VAFF', 
    cpsresponsetimerreason3 ='V12F',
    cpsresponsetimerreason9 = 'C12F',
    updatedby = 'CJAMS-64580',
    updatedon = now()
where cpsresponsetimeractionsid in ('a3086c4f-bc99-4e44-bec3-d9d239e30559')
and activeflag =1;