update intakeservreqchildremoval set exitdate =  '2021-06-03 00:00:00', activeflag = 0 , updatedby = 'CDM-14578', updatedon =  now() where removalid = 252256;
update tb_client_eligibility i set delete_sw = 'Y', update_ts = now(), update_user_id = 'CDM-14578' where removal_id = 252256;
update personprogramarea set activeflag = 0, updatedby = 'CDM-14578', updatedon =  now() where personprogramid = 'e3d4239d-d734-4706-bc76-406957c27948';
