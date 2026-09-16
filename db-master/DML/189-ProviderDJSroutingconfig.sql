delete from routingconfig where eventcode='PTADJS';
INSERT INTO cjams.routingconfig
(routingconfigid, eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype, resourceid)
VALUES('fd186ce1-ddd4-4cfc-be80-eadeb8237ade', 'PTADJS', 'PVRDJSR', 1, 'simar', '2018-11-02 21:33:42.917', 'simar', '2018-11-02 21:33:42.917', '2018-11-02 21:33:42.917', NULL, NULL, 'PVRDJSRS', '', NULL, NULL, NULL);
INSERT INTO cjams.routingconfig
(routingconfigid, eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype, resourceid)
VALUES('fc385d51-3a0b-4cfa-a8bd-d574315640f7', 'PTADJS', 'PVRDJSPD', 1, 'simar', '2018-11-02 21:33:42.917', 'simar', '2018-11-02 21:33:42.917', '2018-11-02 21:33:42.917', NULL, NULL, 'PVRDJSR', '', NULL, NULL, NULL);
INSERT INTO cjams.routingconfig
(routingconfigid, eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype, resourceid)
VALUES('0138e27f-4649-4613-9d3f-ada4ec45921f', 'PTADJS', 'PVRDJSSD', 1, 'simar', '2018-11-02 21:33:42.917', 'simar', '2018-11-02 21:33:42.917', '2018-11-02 21:33:42.917', NULL, NULL, 'PVRDJSPD', '', NULL, NULL, NULL);
INSERT INTO cjams.routingconfig
(routingconfigid, eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype, resourceid)
VALUES('65a8edbd-c057-4cc3-95f1-08220ce5b511', 'PTADJS', 'PVRDJSRS', 1, 'simar', '2018-11-02 21:33:42.917', 'simar', '2018-11-02 21:33:42.917', '2018-11-02 21:33:42.917', NULL, NULL, 'PVRDJSQA', '', NULL, NULL, NULL);
INSERT INTO cjams.routingconfig
(routingconfigid, eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype, resourceid)
VALUES('7ed6adbb-95db-4037-ac9b-12398a735e95', 'PTADJS', 'PVRDJSQA', 1, 'admin', '2019-08-05 16:45:53.303', 'admin', '2019-08-05 16:45:53.303', '2019-08-05 16:45:53.303', NULL, NULL, 'PVRDJSR', '', NULL, NULL, NULL);
delete from teammemberroletype where sequencenumber in (1502,1503,1504,1505,1506);
	INSERT INTO cjams.teammemberroletype
(sequencenumber, roletypekey, activeflag, description, teamtypekey, isroutable, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", isupervisor, old_id)
VALUES(1502, 'PVRDJSSD', 1, 'DJS - Secretary or Designee', 'OLM', true, 'admin', '2019-04-29 16:01:03.971', 'admin', NULL, '2019-04-29 16:01:03.971', NULL, NULL, false, NULL);
	INSERT INTO cjams.teammemberroletype
(sequencenumber, roletypekey, activeflag, description, teamtypekey, isroutable, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", isupervisor, old_id)
VALUES(1503, 'PVRDJSPD ', 1, 'DJS - Program Director', 'OLM', true, 'admin', '2019-04-29 16:01:03.971', 'admin', NULL, '2019-04-29 16:01:03.971', NULL, NULL, false, NULL);
	INSERT INTO cjams.teammemberroletype
(sequencenumber, roletypekey, activeflag, description, teamtypekey, isroutable, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", isupervisor, old_id)
VALUES(1504, 'PVRDJSQA', 1, 'DJS Quality Assurance Specialist(QA)', 'OLM', true, 'admin', '2019-04-29 16:01:03.971', 'admin', NULL, '2019-04-29 16:01:03.971', NULL, NULL, false, NULL);
	INSERT INTO cjams.teammemberroletype
(sequencenumber, roletypekey, activeflag, description, teamtypekey, isroutable, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", isupervisor, old_id)
VALUES(1505, 'PVRDJSRS', 1, ' DJS Resource Specialist Supervisor (LA)', 'OLM', true, 'admin', '2019-04-29 16:01:03.971', 'admin', NULL, '2019-04-29 16:01:03.971', NULL, NULL, false, NULL);
	INSERT INTO cjams.teammemberroletype
(sequencenumber, roletypekey, activeflag, description, teamtypekey, isroutable, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", isupervisor, old_id)
VALUES(1506, 'PVRDJSR', 1, 'DJS Resource Specialist', 'OLM', true, 'admin', '2019-04-29 16:01:03.971', 'admin', NULL, '2019-04-29 16:01:03.971', NULL, NULL, false, NULL);

delete from pgresource where pgresourceid in ('00f6df89-09a8-4afb-9e1e-333e409df81f','896899d3-9512-4b42-8cb7-642d672dbefc','2b6d0920-023f-4a69-b45a-d0b3a837c0b1',
'64ca0c09-9ba9-4e35-aa98-5e9a42d0d231','f233b4b6-5156-44de-9ea3-ffd870daa5cb','63b39d55-e8f9-4c38-9596-4f059e908c1e');
 delete from resource  where id='63168f5a-ff32-4744-954b-8a747e5b9b7f';
 INSERT INTO cjams.resource
(id, parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES('63168f5a-ff32-4744-954b-8a747e5b9b7f', NULL, 'Incident_Reporting', 1, 1, NULL, '2019-08-14 15:33:33.801', NULL, '2019-08-14 15:33:33.801', NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('00f6df89-09a8-4afb-9e1e-333e409df81f', '5f5eda0c-f978-4c07-921e-fef945eb475f', '63168f5a-ff32-4744-954b-8a747e5b9b7f', 1, 'S-1-5-21-152097760-152508613-1969071786-500', '2019-07-09 05:39:47.000', 'S-1-5-21-152097760-152508613-1969071786-500', '2019-07-09 05:39:47.000', true, NULL, NULL, NULL);
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('896899d3-9512-4b42-8cb7-642d672dbefc', 'dd187b34-f57f-4f7a-9ec0-e23eb8588b04', '63168f5a-ff32-4744-954b-8a747e5b9b7f', 1, 'S-1-5-21-152097760-152508613-1969071786-500', '2019-07-09 05:39:47.000', 'S-1-5-21-152097760-152508613-1969071786-500', '2019-07-09 05:39:47.000', true, NULL, NULL, NULL);
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('2b6d0920-023f-4a69-b45a-d0b3a837c0b1', '9ea6d3ed-8b2b-4e4e-b715-5e2eae0d705a', '63168f5a-ff32-4744-954b-8a747e5b9b7f', 1, 'S-1-5-21-152097760-152508613-1969071786-500', '2019-07-09 05:39:47.000', 'S-1-5-21-152097760-152508613-1969071786-500', '2019-07-09 05:39:47.000', true, NULL, NULL, NULL);
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('64ca0c09-9ba9-4e35-aa98-5e9a42d0d231', '2ec826f1-d4e2-441c-8f6e-9fc679dfa20a', '63168f5a-ff32-4744-954b-8a747e5b9b7f', 1, 'S-1-5-21-152097760-152508613-1969071786-500', '2019-07-09 05:39:47.000', 'S-1-5-21-152097760-152508613-1969071786-500', '2019-07-09 05:39:47.000', true, NULL, NULL, NULL);
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('f233b4b6-5156-44de-9ea3-ffd870daa5cb', 'ebe5eaba-d3b9-4ad6-b89e-54af1f1f9575', '63168f5a-ff32-4744-954b-8a747e5b9b7f', 1, 'S-1-5-21-152097760-152508613-1969071786-500', '2019-07-09 05:39:47.000', 'S-1-5-21-152097760-152508613-1969071786-500', '2019-07-09 05:39:47.000', true, NULL, NULL, NULL);
INSERT INTO cjams.pgresource
(pgresourceid, permissiongroupid, resourceid, activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id)
VALUES('63b39d55-e8f9-4c38-9596-4f059e908c1e', 'd9ac5da2-3a63-4efd-bb13-ea4c9a9cf11b', '63168f5a-ff32-4744-954b-8a747e5b9b7f', 1, 'S-1-5-21-152097760-152508613-1969071786-500', '2019-07-09 05:39:47.000', 'S-1-5-21-152097760-152508613-1969071786-500', '2019-07-09 05:39:47.000', true, NULL, NULL, NULL);



