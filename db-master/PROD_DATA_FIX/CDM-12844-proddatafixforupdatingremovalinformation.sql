
-- 2019-07-18 00:00:00 2019-07-18 09:00:00
update intakeservreqchildremoval set removaldate = '2019-08-12 00:00:00', removaltime = '2019-08-12 09:00:00',updatedon = now(),updatedby = 'CDM-12844' where removalid = '196816';

update placement set activeflag = 0, updatedon = now(), updatedby = 'CDM-12844' where placementid = '05ed9bd2-48a0-49a4-b508-92e11b1cb90a';
update livingarrangement set activeflag = 0, updatedon = now(), updatedby = 'CDM-12844' where placementid = '05ed9bd2-48a0-49a4-b508-92e11b1cb90a';

-- 2019-07-18 00:00:00
update placement set startdatetime = '2019-08-12 00:00:00' , updatedon = now(), updatedby = 'CDM-12844' where placementid = '38e56ff7-fcfc-4607-a1f6-34da98faac4c';
update placementrevision set entrydate = '2019-08-12 00:00:00' , updatedon = now(), updatedby = 'CDM-12844' where placementid = '38e56ff7-fcfc-4607-a1f6-34da98faac4c';

-- 2019-07-18 00:00:00
update personprogramarea set startdate = '2019-08-12 00:00:00' , updatedon = now(), updatedby = 'CDM-12844' where personprogramid = '082dcd1e-4ed4-4e08-a778-13e2c2e4c656';