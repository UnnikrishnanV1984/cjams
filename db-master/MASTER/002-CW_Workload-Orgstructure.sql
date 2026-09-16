INSERT INTO teamtype
(sequencenumber, teamtypekey, activeflag, description, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", old_id)
VALUES((coalesce((select  MAX(sequencenumber) from teamtype),0) +1), 'ORG', 1, 'Orgranization', 'admin', '2011-09-25 14:25:00.000', 'admin', '2011-09-25 14:25:00.000', '2011-09-25 14:25:00.000', NULL, NULL, NULL)
on conflict ON constraint pk_teamtype do nothing;
INSERT INTO teamtype
(sequencenumber, teamtypekey, activeflag, description, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", old_id)
VALUES((coalesce((select  MAX(sequencenumber) from teamtype),0) +1), 'LDSS', 1, 'LDSS', 'admin', '2011-09-25 14:25:00.000', 'admin', '2011-09-25 14:25:00.000', '2011-09-25 14:25:00.000', NULL, NULL, NULL)
on conflict ON constraint pk_teamtype do nothing;

INSERT INTO team
(teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid)
VALUES('1ef09545-3626-4ed7-b0a8-0e9937f425c7', 1, 'DHS', 'ORG1', 'ORG', NULL, NULL, NULL, NULL, 'admin', '2019-04-15 11:33:38.000', 'admin', '2019-04-15 11:33:38.000', '2019-04-01 11:32:52.260', NULL, NULL, 0, NULL, NULL, NULL)on conflict ON constraint pk_team do nothing;
INSERT INTO team
(teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid)
VALUES('40ea66f3-d71e-4dfc-83f6-a7498f7635c4', 1, 'Garet', '10003', 'LDSS', '', '00:00:00', '05:00:00', '1ef09545-3626-4ed7-b0a8-0e9937f425c7', '', '2019-04-16 12:57:22.000', 'admin', '2019-04-16 13:46:02.000', '2019-04-01 12:55:53.372', '2019-04-16 13:20:11.687', NULL, 0, NULL, NULL, NULL)on conflict ON constraint pk_team do nothing;

INSERT INTO team
(teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid)
VALUES('e435ea4b-113b-4ebe-b756-b377f0c6ff4c', 1, 'Allegany', '10001', 'LDSS', NULL, NULL, NULL, '1ef09545-3626-4ed7-b0a8-0e9937f425c7', 'admin', '2019-04-15 11:34:51.000', 'admin', '2019-04-15 11:34:51.000', '2019-04-01 11:32:52.260', NULL, NULL, 0, NULL, NULL, NULL) on conflict ON constraint pk_team do nothing;
INSERT INTO team
(teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid)
VALUES('1c201b9a-4ae0-4e20-afe2-bd1c616c144e', 1, 'Baltimore City', '10002', 'LDSS', NULL, NULL, NULL, '1ef09545-3626-4ed7-b0a8-0e9937f425c7', 'admin', '2019-04-15 11:37:11.000', 'admin', '2019-04-15 11:37:11.000', '2019-04-01 11:36:27.227', NULL, NULL, 0, NULL, NULL, NULL)on conflict ON constraint pk_team do nothing;
INSERT INTO team
(teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid)
VALUES('70d5f68f-57df-46ab-93aa-8928c7c61426', 1, 'Intake & CPS administration', '20001', 'CW', '', NULL, NULL, '40ea66f3-d71e-4dfc-83f6-a7498f7635c4', '', '2019-04-15 11:43:20.000', 'admin', '2019-04-16 13:18:59.000', '2019-03-31 18:30:00.000', '2019-05-11 12:56:53.380', NULL, 0, NULL, NULL, NULL)on conflict ON constraint pk_team do nothing;
INSERT INTO team
(teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid)
VALUES('509c14ae-5d4e-4165-8829-6d531a0b0693', 1, 'Intake & CPS administration', '20201', 'CW', NULL, '00:00:00', '05:00:00', 'e435ea4b-113b-4ebe-b756-b377f0c6ff4c', 'admin', '2019-04-16 13:48:29.000', 'admin', '2019-04-16 13:48:29.000', '2019-04-15 13:46:17.175', NULL, NULL, 0, NULL, NULL, NULL)on conflict ON constraint pk_team do nothing;
INSERT INTO team
(teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid)
VALUES('998470af-f361-45ff-95e4-1224ceb85724', 1, 'Demo County', '11001', 'LDSS', NULL, '00:00:00', '05:00:00', '1ef09545-3626-4ed7-b0a8-0e9937f425c7', 'admin', '2019-04-16 13:51:35.000', 'admin', '2019-04-16 13:51:35.000', '2019-04-16 13:46:17.175', NULL, NULL, 0, NULL, NULL, NULL)on conflict ON constraint pk_team do nothing;
INSERT INTO team
(teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid)
VALUES('d29f3704-a2fc-4e80-917d-90f66d186f5f', 1, 'Intake & CPS administration', '29999', 'CW', NULL, '00:00:00', '19:00:00', '998470af-f361-45ff-95e4-1224ceb85724', 'admin', '2019-04-16 13:55:40.000', 'admin', '2019-04-16 13:55:40.000', '2019-04-09 13:54:45.464', NULL, NULL, 0, NULL, NULL, NULL)on conflict ON constraint pk_team do nothing;
INSERT INTO team
(teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid)
VALUES('8e394c87-8e4d-4245-bc95-ca85b760b2d6', 1, 'Out of Home Care Administration', '30000', 'CW', NULL, NULL, NULL, '998470af-f361-45ff-95e4-1224ceb85724', 'admin', '2019-04-17 07:37:54.000', 'admin', '2019-04-17 07:37:54.000', '2019-04-07 07:31:22.808', NULL, NULL, 0, NULL, NULL, NULL)on conflict ON constraint pk_team do nothing;
INSERT INTO team
(teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid)
VALUES('edcde83e-e19c-46c3-8041-5a3a9b4461fe', 1, 'Out of Home Care Unit', '30001', 'CW', NULL, NULL, NULL, '998470af-f361-45ff-95e4-1224ceb85724', 'admin', '2019-04-17 07:38:47.000', 'admin', '2019-04-17 07:38:47.000', '2019-04-09 07:31:22.808', NULL, NULL, 0, NULL, NULL, NULL)on conflict ON constraint pk_team do nothing;
INSERT INTO team
(teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid)
VALUES('666b17fa-1d0e-4905-ac38-1c4a5b7cfb28', 1, 'CPS Unit', '30002', 'CW', NULL, NULL, NULL, '998470af-f361-45ff-95e4-1224ceb85724', 'admin', '2019-04-17 07:39:25.000', 'admin', '2019-04-17 07:39:25.000', '2019-04-09 07:31:22.808', NULL, NULL, 0, NULL, NULL, NULL)on conflict ON constraint pk_team do nothing;
INSERT INTO team
(teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid)
VALUES('403c57db-7e5d-4554-8655-f1dee0c66a0a', 1, 'In-Homes Services Unit', '30003', 'CW', NULL, NULL, NULL, '998470af-f361-45ff-95e4-1224ceb85724', 'admin', '2019-04-17 07:40:09.000', 'admin', '2019-04-17 07:40:09.000', '2019-04-02 07:31:22.808', NULL, NULL, 0, NULL, NULL, NULL)on conflict ON constraint pk_team do nothing;
INSERT INTO team
(teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid)
VALUES('92f1a8df-3e93-406b-bc41-ea69484842ac', 1, 'Fostercare Services', '30004', 'CW', NULL, '00:00:00', '22:00:00', '998470af-f361-45ff-95e4-1224ceb85724', 'admin', '2019-04-17 07:52:56.000', 'admin', '2019-04-17 07:52:56.000', '2019-04-02 07:55:45.487', NULL, NULL, 0, NULL, NULL, NULL)on conflict ON constraint pk_team do nothing;
