/*
   Issue Description: CDM-15571
   Category/ Module  : Child removal
   Root cause: User wants to update the exit date of child removal
   Pull request# for code fix: 
   Explanantion: User wants to update the exit date of child removal
*/

update intakeservreqchildremoval 
set exitdate = '2021-06-21 00:00:00', 
    updatedby = 'CDM-15571', 
    updatedon = now() 
where intakeservreqchildremovalid = '0deb944a-8b93-4f2b-9703-164cf224cf14';

update placement 
set enddatetime = '2021-06-21 00:00:00', 
    updatedby = 'CDM-15571', 
    updatedon = now()
where placementid = 'b4e2d5d2-9a93-40a9-bbda-68b3c5ffac12';

