INSERT INTO roletype
(roletypeid, roletypecode, roletypename, shortname, activeflag, effectivedate, expirationdate, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('ba95ee48-7b8d-4644-8f52-aa3111b7d03e', 'APPEALCO', 'Appeal Coordinator', 'APPEALCO', 1, '2019-08-07 18:03:21.275', NULL, 'admin', 'admin', '2019-08-07 18:03:21.275', '2019-08-07 18:03:21.275', NULL)  ON CONFLICT DO NOTHING;

INSERT INTO "role"
(id, "name", description, created, modified, activeflag, insertedby, updatedby, insertedon, updatedon, roletypekey, old_id, openamrole)
VALUES(3500, 'APPEALCO', 'Appeal Coordinator,CW', NULL, NULL, 1, 'admin', NULL, '2019-08-07 12:36:51.000', NULL, 'CWAPPEALCO', NULL, '')  ON CONFLICT DO NOTHING;


INSERT INTO teammemberroletype
(sequencenumber, roletypekey, activeflag, description, teamtypekey, isroutable, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", isupervisor, old_id)
VALUES(190, 'CWAPPEALCO', 1, 'Appeal Coordinator', 'CW', true, 'S-1-5-21-152097760-152508613-1969071786-500', '2019-08-07 12:36:51.000', 'admin', '2019-08-07 12:36:51.000', '2019-08-07 12:36:51.000', NULL, NULL, false, NULL)  ON CONFLICT DO NOTHING;

/*CW APPEAL COORDINATOR Permission*/

INSERT INTO permissiongroup
(permissiongroupid, permissiongroupname, description, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('abec5182-3ab3-4833-a00c-566583de28f4', 'CW APPEAL COORDINATOR ', '', 1, 'admin', 'admin', '2019-08-07 12:39:54.000', '2019-08-07 13:23:10.000', NULL);

INSERT INTO pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('1137fd07-6e71-4d59-af31-062687d04cac', 'abec5182-3ab3-4833-a00c-566583de28f4', '08b6b4da-1b6a-4114-9c69-8aeba0d5909c', 1, 'admin', '2019-08-07 13:00:15.000', 'admin', '2019-08-07 13:00:15.000', true, NULL, NULL, NULL)  ON CONFLICT DO NOTHING;
INSERT INTO pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('336654a2-c8ad-4215-a973-9779506a3f20', 'abec5182-3ab3-4833-a00c-566583de28f4', 'dee2d99e-c234-4e04-a948-ee6752dd8e75', 1, 'admin', '2019-08-07 13:00:15.000', 'admin', '2019-08-07 13:00:15.000', true, NULL, NULL, NULL)  ON CONFLICT DO NOTHING;
INSERT INTO pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('5c453584-ebee-41a8-b888-1c2261e5bf14', 'abec5182-3ab3-4833-a00c-566583de28f4', 'e0fe4783-03a5-45ec-82e6-52afc27c9e2a', 1, 'admin', '2019-08-07 13:23:10.000', 'admin', '2019-08-07 13:23:10.000', true, NULL, NULL, NULL)  ON CONFLICT DO NOTHING;
INSERT INTO pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('35f880ae-0242-4805-a616-52c9371d5dc3', 'abec5182-3ab3-4833-a00c-566583de28f4', '2a14a02f-920d-4380-8c72-0d05dc3908a6', 1, 'admin', '2019-08-07 13:23:10.000', 'admin', '2019-08-07 13:23:10.000', true, NULL, NULL, NULL)  ON CONFLICT DO NOTHING;
INSERT INTO pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('c999ba5d-14d1-4cba-8a33-6a9cdfb6cd43', 'abec5182-3ab3-4833-a00c-566583de28f4', '546a0150-c856-43f5-978f-564580136dfd', 1, 'admin', '2019-08-07 13:23:10.000', 'admin', '2019-08-07 13:23:10.000', true, NULL, NULL, NULL)  ON CONFLICT DO NOTHING;

INSERT INTO role_resource
(id, roleid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, permissiontype, old_id)
VALUES('b4aad899-05dd-4a51-8fa5-f61feacb8906', 3500, 'abec5182-3ab3-4833-a00c-566583de28f4', 1, 'admin', '2019-08-07 14:58:46.000', 'admin0', '2019-08-07 14:58:46.000', true, true, true, 1, NULL)  ON CONFLICT DO NOTHING;


SELECT * FROM createnewuser3('johnandrews@cjams.com','John','Andrews','','John Andrews','CW','CWAPPEALCO','','999101_2','CW UNIT','Demo County','-','-','12345','9999999999','JohnAndrews','9615','CJAMS_CWAPPEALCO');
SELECT * FROM createnewuser3('paulaedwards@cjams.com','Paula ','Edwards','','Paula  Edwards','CW','CWAPPEALCO','','999101_2','CW UNIT','Demo County','-','-','12345','9999999999','Paula Edwards','9617','CJAMS_CWAPPEALCO');


delete from cjams.routingconfig where eventcode='APPL';

INSERT INTO cjams.routingconfig
(eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype)
VALUES('APPL', 'CWAPPEALCO', 1, NULL, '2018-11-02 16:10:14.517', NULL, '2018-11-02 16:10:14.517', '2018-11-02 16:10:14.517',
NULL, NULL, 'CWSP', NULL, NULL, NULL);

INSERT INTO cjams.routingconfig
(eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype)
VALUES('APPL', 'CWSP', 1, NULL, '2018-11-02 16:10:14.517', NULL, '2018-11-02 16:10:14.517', '2018-11-02 16:10:14.517',
NULL, NULL, 'CWAPPEALCO', NULL, NULL, NULL);