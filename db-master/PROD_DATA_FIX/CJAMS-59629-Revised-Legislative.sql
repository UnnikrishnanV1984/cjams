/*
   Issue Description: CJAMS-59629
   Category/ Module  : Overdue Reason Button
   Root cause: User Error, User requested to change the overdue reasons for Contact with Alleged Victim, other child and
   and Contact with Initial Contact Caregiver Attempted 
   Pull request# for code fix: 8879
   Reason why no related code fix: 
    requested a data fix to resolve
*/

--select cpsresponsetimerreason1 ,* from cpsresponsetimeractions c where cpsresponsetimeractionsid = '3be439e9-41ee-4a0c-bf48-8c43686eb719';
update cpsresponsetimeractions 
set cpsresponsetimerreason1 = 'VAVU', cpsresponsetimerreason2 = 'VFCM', updatedon = now(),
updatedby = 'CJAMS-59629' where cpsresponsetimeractionsid = '3be439e9-41ee-4a0c-bf48-8c43686eb719';

update cpsresponsetimeractions 
set cpsresponsetimerreason4 = 'OOCN', cpsresponsetimerreason5 = 'OFMN', updatedon = now(),
updatedby = 'CJAMS-59629' where cpsresponsetimeractionsid = '3be439e9-41ee-4a0c-bf48-8c43686eb719';

update cpsresponsetimeractions 
set cpsresponsetimerreason7 = 'CCCN', cpsresponsetimerreason8 = 'CFMN', updatedon = now(),
updatedby = 'CJAMS-59629' where cpsresponsetimeractionsid = '3be439e9-41ee-4a0c-bf48-8c43686eb719';