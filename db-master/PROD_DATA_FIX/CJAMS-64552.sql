-- CJAMS-64552: Remove Placement validations for the Client # 1717709
/*
-- Issue Description: Remove Placement validations for the Client # 1717709
-- Client ID: 1717709
-- Root cause: User error.
-- Fix Provided: Datafix has been promoted to remove all Placement validations for the Client # 1717709 
-- Pull request# CJAMS-64552
-- Reason why no related code fix: This scenario isn't reproducible on stage3, its user error and user 
    requested to remove all validations. 
	
    Client # 1717709
    placement_id: 335350
*/

update tb_placement_validation
set delete_sw = 'Y',
    update_ts = now(),
    update_user_id = 'CJAMS-64552'
where placement_id = 335350
    and coalesce(validation_status_cd,'') <> '1750'
    and delete_sw = 'N';
