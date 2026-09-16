/*
 Issue Description: CDM-36267
 Category/ Module : Placement Validation
 Root cause: Two Pending Placement validtions from Chessie to CJAMS are migrated which are not needed.
 Fix: Soft delete the two Pending Placement validtion records
 Pull request# for code fix: N/A
 Reason why no related code fix: 
 Need to do data fix
 */


select * from tb_placement_validation where placement_validation_id in (440215, 441474);

UPDATE tb_placement_validation
SET delete_sw = 'Y',
update_user_id = 'CDM-36267',
update_ts = now()
where placement_validation_id in (440215, 441474);
