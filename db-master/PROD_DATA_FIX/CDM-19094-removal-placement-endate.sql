
/*
   Issue Description: CDM-19094
   Category/ Module  : Child Removal/Placement
   Root cause: user wants to end date removal and placement 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/

-- Case Number : 3223892

update intakeservreqchildremoval 
set exitdate = '2021-09-30 00:00:00', updatedby = 'CDM-19094', updatedon = now() 
where intakeservreqchildremovalid = '7251ca5d-ae94-4c5c-9329-6d0d3722ec71';

update placement set enddatetime = '2021-09-30 00:00:00', updatedby = 'CDM-19094', updatedon = now() 
where placementid in ('081ad3c9-baed-4673-b856-b0de9291f74f');

UPDATE cjams.livingarrangement
SET livingenddate='2021-09-30 00:00:00', updatedon=now(), updatedby='CDM-19094' 
WHERE livingid='13e82542-fab2-4fba-97e1-2995421b397e';
