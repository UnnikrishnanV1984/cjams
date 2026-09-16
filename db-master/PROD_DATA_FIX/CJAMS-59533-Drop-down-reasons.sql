/*
   Issue Description: CJAMS-59533
   Category/ Module  : Overdue Reason Button
   Root cause: User Error, User requested to change the overdue reasons for Contact with Alleged Victim 
   and Contact with Initial Contact Caregiver Attempted 
   Pull request# for code fix: 8879
   Reason why no related code fix: 
    requested a data fix to resolve
*/
update cpsresponsetimeractions 
set cpsresponsetimerreason1 = 'VAVU', cpsresponsetimerreason2 = 'VAFF', cpsresponsetimerreason3 = 'V12F', updatedon = now(),
updatedby = 'CJAMS-59533' where cpsresponsetimeractionsid = 'f5ba8c9a-5b63-467d-9109-4a0165e772e5';

update cpsresponsetimeractions 
set cpsresponsetimerreason7 = 'CCCN', cpsresponsetimerreason8 = 'CFFN', cpsresponsetimerreason9 = 'C12F', updatedon = now(),
updatedby = 'CJAMS-59533' where cpsresponsetimeractionsid = 'f5ba8c9a-5b63-467d-9109-4a0165e772e5';