/*
   Issue Description: 'CJAMS-62906' Not able to close the provider 
   Category/ Module : Placement validation
   Root cause: For Provider (ID: 5069122), CJAMS have 2 migrated pending placement validations belonging to two diff placements from 2014 period, which is preventing the provider closure.
    For both placements, the entry and exit dates are the same, meaning no payment was involved. Therefore, these placement validations are not necessary.
   Provider ID: 5069122  (Angela Bechtel) - Local Department Home
    Case ID: 3242508
    Client ID: 3196564 (JEROME N  WHITE)
   Fix Provided: Did data fix to remove placement validation records

*/
Update cjams.tb_placement_validation 
set delete_sw = 'Y',
	comment_tx = 'This record was removed as per the user''s request.',
	update_ts = now(),
	update_user_id = 'CJAMS-62906'
where placement_validation_id in(670149,670186)
	and delete_sw  = 'N' ;