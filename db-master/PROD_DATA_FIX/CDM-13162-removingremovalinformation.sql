update intakeservreqchildremoval set activeflag = 0, updatedby = 'CDM-13162', updatedon = now() where removalid = 250422 and activeflag = 1;

update tb_client_eligibility set delete_sw = 'Y', update_ts = now(),update_user_id = 'CDM-13162' where removal_id = 250422;

