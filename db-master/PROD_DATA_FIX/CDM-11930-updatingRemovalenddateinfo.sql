-- 2021-01-21 00:00:00
update intakeservreqchildremoval i set exitdate = '2020-08-03 10:00:00',
removalexitreason = 'OTHER', updatedby = 'CDM-11930',updatedon = now() 
where intakeservreqchildremovalid = 'c9b01a3d-cffc-4b15-8413-81d1e9e0092c';

-- CDM-11930
update personprogramarea set enddate = '2020-08-03 10:00:00',updatedon = now() where personprogramid = '51753cb3-d519-424c-9525-387184e76544';