
/*
   Issue Description: CDM-19099
   Category/ Module  : Child Removal/Placement
   Root cause: user wants to end date removal and placement 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/
-- Case No: 3114392
update intakeservreqchildremoval 
set exitdate = '2021-09-30 00:00:00', updatedby = 'CDM-19099', updatedon = now() 
where intakeservreqchildremovalid = 'fb821bd9-3fc0-4b16-b3cb-d512cb562bb2';

update placement set enddatetime = '2021-09-30 00:00:00', updatedby = 'CDM-19099', updatedon = now() 
where placementid in ('56514683-2452-461f-8786-e3481aa9fc58');

UPDATE cjams.livingarrangement
SET livingenddate='2021-09-30 00:00:00', updatedon=now(), updatedby='CDM-19099' 
WHERE livingid='20176c11-cfe9-4c37-ac49-790e9e7d0f01';


