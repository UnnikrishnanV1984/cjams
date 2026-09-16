 /*
  Issue Description: CDM-17277
   Category/ Module  :  Updating end date 
   Root cause: user asked to update it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update intakeservreqchildremoval set exitdate = '2021-04-01 13:30:00', updatedby = 'CDM-17277', updatedon = now() where removalid  in ('197205','197206');

-- 2021-04-06 13:49:52
update personprogramarea set enddate = '2021-04-01 13:49:52', updatedby = 'CDM-17277', updatedon = now() where personprogramid  in ('2ed3bcb7-9414-4dab-97d3-be3ea44d8f10','b78c6278-aaba-4f32-b63a-e26041dd59f4');

update placement set enddatetime = '2021-04-01 13:30:00', updatedby = 'CDM-17277', updatedon = now() where placementid in ('70b88c01-7882-4217-9f69-fb946e1525df','b63cc465-b9de-46fd-bd9f-0a5e56780135');