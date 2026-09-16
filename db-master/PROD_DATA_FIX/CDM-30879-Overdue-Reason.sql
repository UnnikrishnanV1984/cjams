/*
   Issue Description: CDM-30879
   Category/ Module  : Overdue Reason Button
   Root cause: User requested to change the overdue reasons when contact are updated 
   Pull request# for code fix: 8879
   Reason why no related code fix: 
    requested a data fix to resolve
*/
update cpsresponsetimeractions 
set cpsresponsetimerreason1 = 'VAVU', cpsresponsetimerreason2 = 'VAFF', cpsresponsetimerreason3 = 'V12F', updatedon = now(),
updatedby = 'CDM-30879' where cpsresponsetimeractionsid = '0d343ca9-8542-47cf-bf52-9cdc2c1e3363';

update cpsresponsetimeractions 
set cpsresponsetimerreason1 = 'VDER', updatedon = now(),
updatedby = 'CDM-30879'
where cpsresponsetimeractionsid = 'a63cdb66-33b7-4cbb-a4f5-54c5448c1627';

update cpsresponsetimeractions 
set cpsresponsetimerreason1 = 'VAVU', cpsresponsetimerreason2 = 'VFCM', updatedon = now(),
updatedby = 'CDM-30879'
where cpsresponsetimeractionsid = 'd7c4852e-eb11-4255-901f-7dbc9d783e4c';

update cpsresponsetimeractions 
set cpsresponsetimerreason1 = 'VAVU', cpsresponsetimerreason2 = 'VAFF', cpsresponsetimerreason3 = 'V34F', updatedon = now(),
updatedby = 'CDM-30879'
where cpsresponsetimeractionsid = '06d93c09-c74c-4725-8cef-ec70e948dc56';