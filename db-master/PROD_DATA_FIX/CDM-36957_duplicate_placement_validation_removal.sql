/*
   Issue Description: CDM-36957
   Category/ Module  : Duplicate Maintanence payment 
   Root cause: same placement validation record created thru application as well as manual insert for CDM-36517
   Pull request# for code fix: NA
   Reason why no related code fix: Requested a data fix to resolve
*/

update tb_placement_validation
	set delete_sw = 'Y',
		update_user_id = 'CDM-36957',
		update_ts = now(),
		comment_tx = 'This record was removed as per the user request # S2024033056739.'
	where placement_validation_id = 2112276
		and validation_status_cd is null
		and delete_sw = 'N' ;
