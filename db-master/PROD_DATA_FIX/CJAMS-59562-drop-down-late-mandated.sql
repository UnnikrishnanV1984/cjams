/*
   Issue Description: CJAMS-59562
   Category/ Module  : Overdue Reason Button
   Root cause: User Error, User requested to change the overdue reasons for Contact with Alleged Victim, other child and
   and Contact with Initial Contact Caregiver Attempted 
   Pull request# for code fix: 8879
   Reason why no related code fix: 
    requested a data fix to resolve
*/
update cpsresponsetimeractions 
set cpsresponsetimerreason1 = 'VAVU', cpsresponsetimerreason2 = 'VFCM', updatedon = now(),
updatedby = 'CJAMS-59562' where cpsresponsetimeractionsid = '371db474-34bf-4f36-8f4e-251d92db2f4c';

update cpsresponsetimeractions 
set cpsresponsetimerreason4 = 'OOCN', cpsresponsetimerreason5 = 'OFMN', updatedon = now(),
updatedby = 'CJAMS-59562' where cpsresponsetimeractionsid = '371db474-34bf-4f36-8f4e-251d92db2f4c';

update cpsresponsetimeractions 
set cpsresponsetimerreason7 = 'CCCN', cpsresponsetimerreason8 = 'CFMN', updatedon = now(),
updatedby = 'CJAMS-59562' where cpsresponsetimeractionsid = '371db474-34bf-4f36-8f4e-251d92db2f4c';

--select * from cpsresponsetimeractions c where cpsresponsetimeractionsid = '371db474-34bf-4f36-8f4e-251d92db2f4c';