-- CDM-14286
-- 2021-04-13 00:00:00
update personprogramarea set enddate = null, updatedon = now() where personprogramid  = 'a3e3a073-79ca-4d73-97fc-74187b249a81';

-- 2021-04-13 16:00:00, 2017-04-25 11:00:00
update intakeservreqchildremoval set exitdate = null,removaltime = null, updatedby ='CDM-14286', updatedon = now() where removalid = '184831';
