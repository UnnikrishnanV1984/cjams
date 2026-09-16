/*
   Issue Description: CDM-14805
   Category/ Module  :  Removing the end date in person program, child removal, permanency plan and placement
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


-- 2021-06-30 10:00:00
update intakeservreqchildremoval set exitdate = null, updatedon = now(), updatedby = 'CDM-14805' where removalid = '164481';

-- 2021-06-30 00:00:00
update placement set enddatetime = null, endtime = null, updatedon = now(), updatedby = 'CDM-14805' where placementid = '62a94b2b-e58f-4f51-a988-24c2efc649d3' and activeflag = 1;
update placementrevision set exitdate = null, exittime = null, updatedon = now(), updatedby = 'CDM-14805' where placementid = 'f0338494-28ed-438b-a185-031fa1fd3edd' and activeflag = 1;
-- 2021-06-30 00:00:00
update permanencyplan p set enddate = null, updatedon = now(), updatedby = 'CDM-14805' where permanencyplanid  = 'a852793c-bcbd-4ad2-b921-834b33e31a59';

-- 2021-06-30 00:00:00
update personprogramarea set enddate = null, updatedon = now(), updatedby = 'CDM-14805' where personprogramid = 'c87c674c-6dbd-4ce5-bd9c-9c3f8c28c6fe';
