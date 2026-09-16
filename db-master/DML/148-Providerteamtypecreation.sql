delete from teammemberassignment where teammemberid in (
select teammemberid from teammember where teamid='b25a2e36-046c-4a6b-80f3-ba1e1ce84934' 
);


delete from teammember where teamid='b25a2e36-046c-4a6b-80f3-ba1e1ce84934';
delete from team where teamid='b25a2e36-046c-4a6b-80f3-ba1e1ce84934';

INSERT INTO cjams.team
(teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid)
VALUES('b25a2e36-046c-4a6b-80f3-ba1e1ce84934', 1, 'Provider Portal', '999101_8', 'PVPROV', NULL, NULL, NULL, '24c59d52-50cc-4d0b-ae19-4b004b247048', 'admin', '2019-07-16 17:55:13.404', 'admin', '2019-07-16 17:55:13.404', '2019-07-16 17:55:13.404', NULL, NULL, NULL, NULL, NULL, NULL);

delete from rolemapping where roleid in ( select  id from "role" where roletypekey='PPROSA' );

delete from role where id='2455' and roletypekey = 'PPROSA';

INSERT INTO cjams."role"
(id, "name", description, created, modified, activeflag, insertedby, updatedby, insertedon, updatedon, roletypekey, old_id, openamrole)
VALUES(2455, 'Provider_Staff_Admin', 'Provider_Staff_Admin', NULL, NULL, 1, 'system', NULL, '2019-07-16 18:01:39.020', NULL, 'PPROSA', NULL, NULL);
