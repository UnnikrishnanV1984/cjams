update placement set enddatetime = '2020-10-09 00:00:00', updatedon = now(), updatedby = 'CDM-9774' where placementid = '17e74f20-9fd9-4ea4-97c1-ec28551b71f6';

update intakeservreqchildremoval set exitdate = '2020-10-09 00:00:00', returndate = '2020-10-09 00:00:00', returntime = '2020-10-09 00:00:00', removalexitreason = 'OTHER', updatedon = now(), updatedby = 'CDM-9774' where intakeservreqchildremovalid = '667fa587-1130-4801-8be5-d1d40a61812e';

update tb_placement_validation set placement_exit_dt = '2020-10-09', update_ts = now(), update_user_id = 'CDM-9774' where placement_id = '1557227';


update tb_placement_validation set delete_sw = 'Y', update_ts = now(), update_user_id = 'CDM-9774' where placement_validation_id in ('1946308', '1946307', '1948583');
