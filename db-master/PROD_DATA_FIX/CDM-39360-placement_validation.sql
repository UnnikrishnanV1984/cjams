/*
   Issue Description: 'CDM-39360'
   Category/ Module : Placement validation
   Root cause: PLacement got updated on 07/14/2022 to get end dated on 1/31/2022
   Fix Provided: Did data fix to remove placement validation records

*/
UPDATE cjams.tb_placement_validation
SET update_user_id='CDM-39360', delete_sw='Y', update_ts=now()
WHERE placement_validation_id in (2002178, 2005732) and placement_id=317978;

