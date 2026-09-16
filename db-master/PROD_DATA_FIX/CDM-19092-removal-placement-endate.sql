
/*
   Issue Description: CDM-19092
   Category/ Module  : Child Removal/Placement
   Root cause: user wants to end date removal and placement 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/

-- Case Number : 3230720  CDM-19092

update intakeservreqchildremoval 
set exitdate = '2021-09-30 00:00:00', updatedby = 'CDM-19092', updatedon = now() 
where intakeservreqchildremovalid = 'c66ce949-ec6d-4eff-8169-a67c5398d05b';

update placement set enddatetime = '2021-09-30 00:00:00', updatedby = 'CDM-19092', updatedon = now() 
where placementid in ('23ea6462-ad9b-4df8-a478-2f7e2b0e87bc');

UPDATE cjams.livingarrangement
SET livingenddate='2021-09-30 00:00:00', updatedon=now(), updatedby='CDM-19092' 
WHERE livingid='437151fc-f2a4-4ea7-b1e9-b73d6f6221a8';