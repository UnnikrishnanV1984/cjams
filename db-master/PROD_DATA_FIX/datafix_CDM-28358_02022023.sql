-- CDM-28358 - Updated placement dates
/*
-- Issue Description: 
	211030011977:I am attempting to update the youth's placement dates to reflect 12/29/2022 instead of 12/23/2022.
     An error pops up indicating overlapping placements. The time line does not overlap with a placement but with a 
     living arrangement which should not impact the placement. With out being able to update this I am not able to 
     validate the placement and they are not able to be paid the correct amount.


-- Category/ Module: Placement
-- Root cause: Placement Date issue
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select * from placement where servicecaseid = 'a150726f-1734-4e6a-950c-1acd799fa8af' and placementid = 'e95de663-068f-4c5a-a8b6-8f93e2dda603';

update placement set enddatetime = '2022-12-29 00:00:00', updatedby = 'CDM-28358',
updatedon = now() where servicecaseid = 'a150726f-1734-4e6a-950c-1acd799fa8af' and placementid = 'e95de663-068f-4c5a-a8b6-8f93e2dda603';

select * from placementrevision where placementrevisionid = 'b8040449-99b0-4560-acea-4b639d4dc345';

update placementrevision set exitdate = '2022-12-29 00:00:00', updatedby = 'CDM-28358',
updatedon = now() where placementrevisionid = 'b8040449-99b0-4560-acea-4b639d4dc345';

select * from tb_placement_validation where placement_id = 1571603;

update tb_placement_validation set placement_exit_dt = '2022-12-29', update_user_id = 'CDM-28358',
update_ts = now()  where placement_id = 1571603;