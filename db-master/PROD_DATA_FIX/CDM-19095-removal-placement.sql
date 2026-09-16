
/*
   Issue Description: CDM-19095, CDM-19092
   Category/ Module  : Child Removal/Placement
   Root cause: user wants to end date removal and placement 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/

-- Case Number : 3238990

update intakeservreqchildremoval 
set exitdate = '2021-09-30 00:00:00', updatedby = 'CDM-19095', updatedon = now() 
where intakeservreqchildremovalid = '361063b2-533a-4c06-ae45-f35c03020767';

update placement set enddatetime = '2021-09-30 00:00:00', updatedby = 'CDM-19095', updatedon = now() 
where placementid in ('d1956cd2-e2a6-4fba-ba05-232b76e27f97');

UPDATE cjams.livingarrangement
SET livingenddate='2021-09-30 00:00:00', updatedon=now(), updatedby='CDM-19095' 
WHERE livingid='bb9e00e9-4b1c-48bb-a953-f047ad767f1c';
