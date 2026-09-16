Update cjams.tb_placement_validation 
set delete_sw = 'Y',
    comment_tx = 'This record was removed as per the user''s request as the vendor received all the payments.',
    update_ts = now(),
    update_user_id = 'CDM-13754'
where placement_validation_id in ( 1960164, 1960163, 1960162, 1960160, 1960159)
    and delete_sw = 'N';