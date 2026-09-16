



delete from cjams.team where teamname ='Qualified Individual' and activeflag=1;

delete from cjams.team where teamname ='FTDM/QI Supervisor' and activeflag=1;

delete from cjams.team where teamname ='Facilitator/Qualified Supervisor' and activeflag=1;

delete from cjams.team where teamname ='FTDM Facilitator' and activeflag=1;



-- For Baltimore City

INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid) 
VALUES('207456bb-1236-4fa0-9512-9748e6d3645b'::uuid, 1, 'Qualified Individual', '1429_FTDM_1', 'CW', 'Qualified Individual', NULL, NULL, '7665ca54-5374-4174-be07-a687b811a82c'::uuid, 'CIDM-5888', now(), 'CIDM-5888', now(), now(), NULL, NULL, NULL, NULL, NULL, '7665ca54-5374-4174-be07-a687b811a82c', NULL)ON CONFLICT DO NOTHING; 

INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid) 
VALUES('4d140e88-e2a5-4e36-b6ea-9a03470200fc'::uuid, 1, 'FTDM/QI Supervisor', '1429_FTDM_2', 'CW', 'FTDM/QI Supervisor', NULL, NULL, '7665ca54-5374-4174-be07-a687b811a82c'::uuid, 'CIDM-5888', now(), 'CIDM-5888', now(), now(), NULL, NULL, NULL, NULL, NULL, '7665ca54-5374-4174-be07-a687b811a82c',  NULL)ON CONFLICT DO NOTHING;


--- for Baltimore County


INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid) 

VALUES('f5f8cab4-5c26-4033-a119-785f0d20e58d'::uuid, 1, 'Qualified Individual', '1430_FTDM_1', 'CW', 'Qualified Individual', NULL, NULL, '1b7ae41e-e77a-4a1e-a0a3-cda5292cde0b'::uuid, 'CIDM-5888', now(), 'CIDM-5888', now(), now(), NULL, NULL, NULL, NULL, NULL, '1b7ae41e-e77a-4a1e-a0a3-cda5292cde0b',  NULL)ON CONFLICT DO NOTHING;


INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid) 

VALUES('e859c2f6-2ac5-414e-97f2-dbd2d0423f45'::uuid, 1, 'FTDM/QI Supervisor', '1430_FTDM_2', 'CW', 'FTDM/QI Supervisor', NULL, NULL, '1b7ae41e-e77a-4a1e-a0a3-cda5292cde0b'::uuid, 'CIDM-5888', now(), 'CIDM-5888', now(), now(), NULL, NULL, NULL, NULL, NULL, '1b7ae41e-e77a-4a1e-a0a3-cda5292cde0b',  NULL)ON CONFLICT DO NOTHING;


-- for Calvert

INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid) 
VALUES('199bebb5-e121-4b60-892d-e7f0eac38942'::uuid, 1, 'Qualified Individual', '1431_FTDM_1', 'CW', 'Qualified Individual', NULL, NULL, 'b0ca6422-8241-4d86-bfef-51c7225de2fc'::uuid, 'CIDM-5888', now(), 'CIDM-5888', now(), now(), NULL, NULL, NULL, NULL, NULL, 'b0ca6422-8241-4d86-bfef-51c7225de2fc',  NULL)ON CONFLICT DO NOTHING;


INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid) 
VALUES('bae29c71-b6f8-467e-9976-99b8d8ab39b8'::uuid, 1, 'FTDM/QI Supervisor', '1431_FTDM_2', 'CW', 'FTDM/QI Supervisor', NULL, NULL, 'b0ca6422-8241-4d86-bfef-51c7225de2fc'::uuid, 'CIDM-5888', now(), 'CIDM-5888', now(), now(), NULL, NULL, NULL, NULL, NULL, 'b0ca6422-8241-4d86-bfef-51c7225de2fc',  NULL)ON CONFLICT DO NOTHING;

-- For Caroline

INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid) 
VALUES('e7415029-e4e7-49af-93dd-c18de102b829'::uuid, 1, 'Qualified Individual', '1432_FTDM_1', 'CW', 'Qualified Individual', NULL, NULL, '9f60d4f1-4004-474f-a432-a19da7b1efe0'::uuid, 'CIDM-5888', now(), 'CIDM-5888', now(), now(), NULL, NULL, NULL, NULL, NULL, '9f60d4f1-4004-474f-a432-a19da7b1efe0',  NULL)ON CONFLICT DO NOTHING;

INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid) 
VALUES('da5c56bb-7e3c-41c7-ab49-752b765166d7'::uuid, 1, 'FTDM/QI Supervisor', '1432_FTDM_2', 'CW', 'FTDM/QI Supervisor', NULL, NULL, '9f60d4f1-4004-474f-a432-a19da7b1efe0'::uuid, 'CIDM-5888', now(), 'CIDM-5888', now(), now(), NULL, NULL, NULL, NULL, NULL, '9f60d4f1-4004-474f-a432-a19da7b1efe0',  NULL)ON CONFLICT DO NOTHING;

-- For Carroll



INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid) 
VALUES('08f6dff0-3e54-4d69-baa8-01a98d463d58'::uuid, 1, 'Qualified Individual', '1433_FTDM_1', 'CW', 'Qualified Individual', NULL, NULL, 'c3fa7975-4ee2-4c4f-90b7-e485e2da63a1'::uuid, 'CIDM-5888', now(), 'CIDM-5888', now(), now(), NULL, NULL, NULL, NULL, NULL, 'c3fa7975-4ee2-4c4f-90b7-e485e2da63a1',  NULL)ON CONFLICT DO NOTHING;


INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid) 
VALUES('26362935-f427-47da-822c-cf7840f53118'::uuid, 1, 'FTDM/QI Supervisor', '1433_FTDM_2', 'CW', 'FTDM/QI Supervisor', NULL, NULL, 'c3fa7975-4ee2-4c4f-90b7-e485e2da63a1'::uuid, 'CIDM-5888', now(), 'CIDM-5888', now(), now(), NULL, NULL, NULL, NULL, NULL, 'c3fa7975-4ee2-4c4f-90b7-e485e2da63a1',  NULL)ON CONFLICT DO NOTHING;

-- For Cecil


INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid)
VALUES('ac5c02d7-fa33-4bff-be89-2a86622ed5df'::uuid, 1, 'Qualified Individual', '1434_FTDM_1', 'CW', 'Qualified Individual', NULL, NULL, '817e0751-1fa8-4c31-8233-8fffd6426235'::uuid, 'CIDM-5888', now(), 'CIDM-5888', now(), now(), NULL, NULL, NULL, NULL, NULL, '817e0751-1fa8-4c31-8233-8fffd6426235',  NULL)ON CONFLICT DO NOTHING;

INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid)
VALUES('2ebb582f-7cff-480b-8b66-2ae3c3168422'::uuid, 1, 'FTDM/QI Supervisor', '1434_FTDM_2', 'CW', 'FTDM/QI Supervisor', NULL, NULL, '817e0751-1fa8-4c31-8233-8fffd6426235'::uuid, 'CIDM-5888', now(), 'CIDM-5888', now(), now(), NULL, NULL, NULL, NULL, NULL, '817e0751-1fa8-4c31-8233-8fffd6426235',  NULL)ON CONFLICT DO NOTHING;

--For Charles

INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid) 
VALUES('f3d44243-40a4-49f5-89b3-0820a04f2a28'::uuid, 1, 'Qualified Individual', '1435_FTDM_1', 'CW', 'Qualified Individual', NULL, NULL, '58bac299-69ce-4cd2-8e9c-2773524050db'::uuid, 'CIDM-5888', now(), 'CIDM-5888', now(), now(), NULL, NULL, NULL, NULL, NULL, '58bac299-69ce-4cd2-8e9c-2773524050db',  NULL)ON CONFLICT DO NOTHING;

INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid) 
VALUES('6e742097-7f6d-4232-9025-7bd65fd4497e'::uuid, 1, 'FTDM/QI Supervisor', '1435_FTDM_2', 'CW', 'FTDM/QI Supervisor', NULL, NULL, '58bac299-69ce-4cd2-8e9c-2773524050db'::uuid, 'CIDM-5888', now(), 'CIDM-5888', now(), now(), NULL, NULL, NULL, NULL, NULL, '58bac299-69ce-4cd2-8e9c-2773524050db',  NULL)ON CONFLICT DO NOTHING;

--For Dorchester

INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid) 
VALUES('2eadf34e-7d9c-42dd-af07-5afaa348a427'::uuid, 1, 'Qualified Individual', '1436_FTDM_1', 'CW', 'Qualified Individual', NULL, NULL, '971e5c71-6f29-4918-a1f2-f880fe5702b1'::uuid, 'CIDM-5888', now(), 'CIDM-5888', now(), now(), NULL, NULL, NULL, NULL, NULL, '971e5c71-6f29-4918-a1f2-f880fe5702b1',  NULL)ON CONFLICT DO NOTHING;

INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid) 
VALUES('e1bd4300-f336-44bd-b009-4328989ad1e9'::uuid, 1, 'FTDM/QI Supervisor', '1436_FTDM_2', 'CW', 'FTDM/QI Supervisor', NULL, NULL, '971e5c71-6f29-4918-a1f2-f880fe5702b1'::uuid, 'CIDM-5888', now(), 'CIDM-5888', now(), now(), NULL, NULL, NULL, NULL, NULL, '971e5c71-6f29-4918-a1f2-f880fe5702b1',  NULL)ON CONFLICT DO NOTHING;

--For Harford

INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid) 
VALUES('e1b713b4-77b2-46c4-b974-0860c856aae2'::uuid, 1, 'Qualified Individual', '1439_FTDM_1', 'CW', 'Qualified Individual', NULL, NULL, '34457960-811a-4d35-a416-b8941d6974cc'::uuid, 'CIDM-5888', now(), 'CIDM-5888', now(), now(), NULL, NULL, NULL, NULL, NULL, '34457960-811a-4d35-a416-b8941d6974cc',  NULL)ON CONFLICT DO NOTHING;

INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid) 
VALUES('0e2b5b5c-459f-4c45-b085-9ce47ce6ca89'::uuid, 1, 'FTDM/QI Supervisor', '1439_FTDM_2', 'CW', 'FTDM/QI Supervisor', NULL, NULL, '34457960-811a-4d35-a416-b8941d6974cc'::uuid, 'CIDM-5888', now(), 'CIDM-5888', now(), now(), NULL, NULL, NULL, NULL, NULL, '34457960-811a-4d35-a416-b8941d6974cc',  NULL)ON CONFLICT DO NOTHING;

--For Howard

INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid) 
VALUES('2255b890-e875-44f9-b73f-0e0dddf104dd'::uuid, 1, 'Qualified Individual', '1440_FTDM_1', 'CW', 'Qualified Individual', NULL, NULL, 'bbce9638-24f9-4336-993c-007f6755c980'::uuid, 'CIDM-5888', now(), 'CIDM-5888', now(), now(), NULL, NULL, NULL, NULL, NULL, 'bbce9638-24f9-4336-993c-007f6755c980',  NULL)ON CONFLICT DO NOTHING;

INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid) 
VALUES('e9045472-28dd-42c5-a6db-e7988d2f8b12'::uuid, 1, 'FTDM/QI Supervisor', '1440_FTDM_2', 'CW', 'FTDM/QI Supervisor', NULL, NULL, 'bbce9638-24f9-4336-993c-007f6755c980'::uuid, 'CIDM-5888', now(), 'CIDM-5888', now(), now(), NULL, NULL, NULL, NULL, NULL, 'bbce9638-24f9-4336-993c-007f6755c980',  NULL)ON CONFLICT DO NOTHING;

--For Kent 

INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid) 
VALUES('cae4caf4-3f65-41b5-99f6-cc154d37031b'::uuid, 1, 'Qualified Individual', '1441_FTDM_1', 'CW', 'Qualified Individual', NULL, NULL, '01511461-8e8f-4c60-85f7-7e8faa3a3266'::uuid, 'CIDM-5888', now(), 'CIDM-5888', now(), now(), NULL, NULL, NULL, NULL, NULL, '01511461-8e8f-4c60-85f7-7e8faa3a3266',  NULL)ON CONFLICT DO NOTHING;

INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid) 
VALUES('08cb1027-9b2f-40b9-ba81-43fab3c108c7'::uuid, 1, 'FTDM/QI Supervisor', '1441_FTDM_2', 'CW', 'FTDM/QI Supervisor', NULL, NULL, '01511461-8e8f-4c60-85f7-7e8faa3a3266'::uuid, 'CIDM-5888', now(), 'CIDM-5888', now(), now(), NULL, NULL, NULL, NULL, NULL, '01511461-8e8f-4c60-85f7-7e8faa3a3266',  NULL)ON CONFLICT DO NOTHING;

-- For Montgomery


INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid) 
VALUES('65360076-84c5-4488-9317-8a9a5114c9d6'::uuid, 1, 'Qualified Individual', '1442_FTDM_1', 'CW', 'Qualified Individual', NULL, NULL, 'f6ab02d5-c386-4659-8810-687fc191a967'::uuid, 'CIDM-5888', now(), 'CIDM-5888', now(), now(), NULL, NULL, NULL, NULL, NULL, 'f6ab02d5-c386-4659-8810-687fc191a967',  NULL)ON CONFLICT DO NOTHING;

INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid) 
VALUES('4bfff51b-55e0-4e78-8678-41eb0d20fc4b'::uuid, 1, 'FTDM/QI Supervisor', '1442_FTDM_2', 'CW', 'FTDM/QI Supervisor', NULL, NULL, 'f6ab02d5-c386-4659-8810-687fc191a967'::uuid, 'CIDM-5888', now(), 'CIDM-5888', now(), now(), NULL, NULL, NULL, NULL, NULL, 'f6ab02d5-c386-4659-8810-687fc191a967',  NULL)ON CONFLICT DO NOTHING;

--For Prince George's


INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid) 
VALUES('e0207eec-10a0-4320-848b-585fb9fcda1b'::uuid, 1, 'Qualified Individual', '1443_FTDM_1', 'CW', 'Qualified Individual', NULL, NULL, 'c81be790-a79d-40ac-a38d-abd4dd5a81f6'::uuid, 'CIDM-5888', now(), 'CIDM-5888', now(), now(), NULL, NULL, NULL, NULL, NULL, 'c81be790-a79d-40ac-a38d-abd4dd5a81f6',  NULL)ON CONFLICT DO NOTHING;

INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid) 
VALUES('e0207eec-10a0-4320-848b-585fb9fcda1b'::uuid, 1, 'FTDM/QI Supervisor', '1443_FTDM_2', 'CW', 'FTDM/QI Supervisor', NULL, NULL, 'c81be790-a79d-40ac-a38d-abd4dd5a81f6'::uuid, 'CIDM-5888', now(), 'CIDM-5888', now(), now(), NULL, NULL, NULL, NULL, NULL, 'c81be790-a79d-40ac-a38d-abd4dd5a81f6',  NULL)ON CONFLICT DO NOTHING;

--For Queen Anne's

INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid) 
VALUES('55e982c5-2f98-47d2-bdc7-868484398477'::uuid, 1, 'Qualified Individual', '1444_FTDM_1', 'CW', 'Qualified Individual', NULL, NULL, 'b26afb64-6b7f-462e-8074-cfdc9cce04c4'::uuid, 'CIDM-5888',  now(), 'CIDM-5888',  now(),  now(), NULL, NULL, NULL, NULL, NULL, 'b26afb64-6b7f-462e-8074-cfdc9cce04c4',  NULL)ON CONFLICT DO NOTHING;

INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid) 
VALUES('01299cdd-4e36-499b-afae-c9225d467a47'::uuid, 1, 'FTDM/QI Supervisor', '1444_FTDM_2', 'CW', 'FTDM/QI Supervisor', NULL, NULL, 'b26afb64-6b7f-462e-8074-cfdc9cce04c4'::uuid, 'CIDM-5888',  now(), 'CIDM-5888',  now(),  now(), NULL, NULL, NULL, NULL, NULL, 'b26afb64-6b7f-462e-8074-cfdc9cce04c4',  NULL)ON CONFLICT DO NOTHING;

--For Somerset

INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid) 
VALUES('8f13c6b9-4c9c-4eb8-bf0c-d3b50f33973b'::uuid, 1, 'Qualified Individual', '1445_FTDM_1', 'CW', 'Qualified Individual', NULL, NULL, '1e886503-ef0a-450c-8607-566c45fa75e4'::uuid, 'CIDM-5888', now(), 'CIDM-5888', now(), now(), NULL, NULL, NULL, NULL, NULL, '1e886503-ef0a-450c-8607-566c45fa75e4',  NULL)ON CONFLICT DO NOTHING;

INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid) 
VALUES('74724cba-920f-4874-9db6-fb39f92edd06'::uuid, 1, 'FTDM/QI Supervisor', '1445_FTDM_2', 'CW', 'FTDM/QI Supervisor', NULL, NULL, '1e886503-ef0a-450c-8607-566c45fa75e4'::uuid, 'CIDM-5888', now(), 'CIDM-5888', now(), now(), NULL, NULL, NULL, NULL, NULL, '1e886503-ef0a-450c-8607-566c45fa75e4',  NULL)ON CONFLICT DO NOTHING;

--For St. Mary's

INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid) 
VALUES('e51dac3d-0f67-4a0f-862a-1f281bde4031'::uuid, 1, 'Qualified Individual', '1446_FTDM_1', 'CW', 'Qualified Individual', NULL, NULL, 'fa2affa3-0783-49f0-b3f8-e3fbcf59bfc0'::uuid, 'CIDM-5888', now(), 'CIDM-5888', now(), now(), NULL, NULL, NULL, NULL, NULL, 'fa2affa3-0783-49f0-b3f8-e3fbcf59bfc0',  NULL)ON CONFLICT DO NOTHING;

INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid) 
VALUES('493d3813-8092-4cce-8627-e06b7cc8ee5a'::uuid, 1, 'FTDM/QI Supervisor', '1446_FTDM_2', 'CW', 'FTDM/QI Supervisor', NULL, NULL, 'fa2affa3-0783-49f0-b3f8-e3fbcf59bfc0'::uuid, 'CIDM-5888', now(), 'CIDM-5888', now(), now(), NULL, NULL, NULL, NULL, NULL, 'fa2affa3-0783-49f0-b3f8-e3fbcf59bfc0',  NULL)ON CONFLICT DO NOTHING;

--For Talbot

INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid) 
VALUES('68f6c383-f850-4758-99a1-f3260c82368b'::uuid, 1, 'Qualified Individual', '1447_FTDM_1', 'CW', 'Qualified Individual', NULL, NULL, 'cd1940bd-e41d-4d9f-8f73-936fdf05a2cf'::uuid, 'CIDM-5888',  now(), 'CIDM-5888',  now(),  now(), NULL, NULL, NULL, NULL, NULL, 'cd1940bd-e41d-4d9f-8f73-936fdf05a2cf',  NULL)ON CONFLICT DO NOTHING;

INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid) 
VALUES('d107939a-e100-4800-bbad-d20aeb037254'::uuid, 1, 'FTDM/QI Supervisor', '1447_FTDM_2', 'CW', 'FTDM/QI Supervisor', NULL, NULL, 'cd1940bd-e41d-4d9f-8f73-936fdf05a2cf'::uuid, 'CIDM-5888',  now(), 'CIDM-5888',  now(),  now(), NULL, NULL, NULL, NULL, NULL, 'cd1940bd-e41d-4d9f-8f73-936fdf05a2cf',  NULL)ON CONFLICT DO NOTHING;

---For Wicomico

INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid) 
VALUES('97eb52c6-1a5c-4976-ae7b-6b37e232af36'::uuid, 1, 'Qualified Individual', '1449_FTDM_1', 'CW', 'Qualified Individual', NULL, NULL, '19d487dd-8865-4ac4-b43f-9782b110a478'::uuid, 'CIDM-5888',  now(), 'CIDM-5888',  now(),  now(), NULL, NULL, NULL, NULL, NULL, '19d487dd-8865-4ac4-b43f-9782b110a478',  NULL)ON CONFLICT DO NOTHING;

INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid) 
VALUES('7a9a9e1b-0d83-4df5-8f42-5ff21c9f8ed9'::uuid, 1, 'FTDM/QI Supervisor', '1449_FTDM_2', 'CW', 'FTDM/QI Supervisor', NULL, NULL, '19d487dd-8865-4ac4-b43f-9782b110a478'::uuid, 'CIDM-5888',  now(), 'CIDM-5888',  now(),  now(), NULL, NULL, NULL, NULL, NULL, '19d487dd-8865-4ac4-b43f-9782b110a478',  NULL)ON CONFLICT DO NOTHING;

--For Worcester

INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid) 
VALUES('c1cc4bfb-f52e-4662-86f3-01d158733206'::uuid, 1, 'Qualified Individual', '1450_FTDM_1', 'CW', 'Qualified Individual', NULL, NULL, '2c8afb14-eff1-49da-b1ee-926f6a9f0314'::uuid, 'CIDM-5888', now(), 'CIDM-5888', now(), now(), NULL, NULL, NULL, NULL, NULL, '2c8afb14-eff1-49da-b1ee-926f6a9f0314',  NULL)ON CONFLICT DO NOTHING;

INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid) 
VALUES('0ebe6001-5feb-4bbd-8e7b-bda126881660'::uuid, 1, 'FTDM/QI Supervisor', '1450_FTDM_2', 'CW', 'FTDM/QI Supervisor', NULL, NULL, '2c8afb14-eff1-49da-b1ee-926f6a9f0314'::uuid, 'CIDM-5888', now(), 'CIDM-5888', now(), now(), NULL, NULL, NULL, NULL, NULL, '2c8afb14-eff1-49da-b1ee-926f6a9f0314',  NULL)ON CONFLICT DO NOTHING;

-- For Allegany

INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid) 
VALUES('36b9f218-18b5-46ee-8622-fdbcb5bf8c43'::uuid, 1, 'Qualified Individual', '1427_FTDM_1', 'CW', 'Qualified Individual', NULL, NULL, '3254e9ef-08da-4cd7-8aa1-083896ed9bec'::uuid, 'CIDM-5888', now(), 'CIDM-5888', now(), now(), NULL, NULL, NULL, NULL, NULL, '3254e9ef-08da-4cd7-8aa1-083896ed9bec',  NULL)ON CONFLICT DO NOTHING;

INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid) 
VALUES('6048be27-091a-410d-a33e-d9e0797ffb7a'::uuid, 1, 'FTDM/QI Supervisor', '1427_FTDM_2', 'CW', 'FTDM/QI Supervisor', NULL, NULL, '3254e9ef-08da-4cd7-8aa1-083896ed9bec'::uuid, 'CIDM-5888', now(), 'CIDM-5888', now(), now(), NULL, NULL, NULL, NULL, NULL, '3254e9ef-08da-4cd7-8aa1-083896ed9bec',  NULL)ON CONFLICT DO NOTHING;

--For Frederick

INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid) 
VALUES('29f60e39-da51-47a5-9aa3-82f3dc910ebe'::uuid, 1, 'Qualified Individual', '1437_FTDM_1', 'CW', 'Qualified Individual', NULL, NULL, 'd0a6f218-4dee-45c3-b842-be7446a5ef41'::uuid, 'CIDM-5888', now(), 'CIDM-5888', now(), now(), NULL, NULL, NULL, NULL, NULL, 'd0a6f218-4dee-45c3-b842-be7446a5ef41',  NULL)ON CONFLICT DO NOTHING;

INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid) 
VALUES('eae6733a-b2d1-42a7-81f2-a0097e1c990b'::uuid, 1, 'FTDM/QI Supervisor', '1437_FTDM_2', 'CW', 'FTDM/QI Supervisor', NULL, NULL, 'd0a6f218-4dee-45c3-b842-be7446a5ef41'::uuid, 'CIDM-5888', now(), 'CIDM-5888', now(), now(), NULL, NULL, NULL, NULL, NULL, 'd0a6f218-4dee-45c3-b842-be7446a5ef41',  NULL)ON CONFLICT DO NOTHING;

-- For Garrett

INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid) 
VALUES('9bb611e2-6d7e-4e73-8c28-821957d18c1b'::uuid, 1, 'Qualified Individual', '1438_FTDM_1', 'CW', 'Qualified Individual', NULL, NULL, 'ec6a5d23-4bc8-451a-9ea6-9253448aeb8a'::uuid, 'CIDM-5888', now(), 'CIDM-5888', now(), now(), NULL, NULL, NULL, NULL, NULL, 'ec6a5d23-4bc8-451a-9ea6-9253448aeb8a',  NULL)ON CONFLICT DO NOTHING;

INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid) 
VALUES('1cc543a7-da8f-485d-8638-9cb092f29372'::uuid, 1, 'FTDM/QI Supervisor', '1438_FTDM_2', 'CW', 'FTDM/QI Supervisor', NULL, NULL, 'ec6a5d23-4bc8-451a-9ea6-9253448aeb8a'::uuid, 'CIDM-5888', now(), 'CIDM-5888', now(), now(), NULL, NULL, NULL, NULL, NULL, 'ec6a5d23-4bc8-451a-9ea6-9253448aeb8a',  NULL)ON CONFLICT DO NOTHING;



-- For Anne Arundel

INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid) 
VALUES('0a2c12eb-19d8-4c7d-9995-6cc3c6d89c47'::uuid, 1, 'Qualified Individual', '1428_FTDM_1', 'CW', 'Qualified Individual', NULL, NULL, 'f5214cb2-953e-41a9-a4ad-71341501e2ad'::uuid, 'CIDM-5888', now(), 'CIDM-5888', now(), now(), NULL, NULL, 0, NULL, NULL, 'f5214cb2-953e-41a9-a4ad-71341501e2ad',  NULL)ON CONFLICT DO NOTHING;

INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid) 
VALUES('f4fc9eab-533d-45ba-9d8c-47a2671c14aa'::uuid, 1, 'FTDM/QI Supervisor', '1428_FTDM_2', 'CW', 'FTDM/QI Supervisor', NULL, NULL, 'f5214cb2-953e-41a9-a4ad-71341501e2ad'::uuid, 'CIDM-5888', now(), 'CIDM-5888', now(), now(), NULL, NULL, 0, NULL, NULL, 'f5214cb2-953e-41a9-a4ad-71341501e2ad',  NULL)ON CONFLICT DO NOTHING;


-- For Washington County

INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid) 
VALUES('f4c5e00f-2145-4877-92a4-7e6fd548446d'::uuid, 1, 'Qualified Individual', '1448_FTDM_1', 'CW', 'Qualified Individual', NULL, NULL, 'e2c90cd0-a905-4cca-ad60-396ac2cfc41e'::uuid, 'CIDM-5888', '2020-10-09 19:18:33.502', 'CIDM-5888', now(), now(), NULL, NULL, 0, NULL, NULL, 'e2c90cd0-a905-4cca-ad60-396ac2cfc41e',  NULL)ON CONFLICT DO NOTHING;

INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid) 
VALUES('b2a759d1-08cf-4494-8875-8c0edd269a01'::uuid, 1, 'FTDM/QI Supervisor', '1448_FTDM_2', 'CW', 'FTDM/QI Supervisor', NULL, NULL, 'e2c90cd0-a905-4cca-ad60-396ac2cfc41e'::uuid, 'CIDM-5888', '2020-10-09 19:18:33.502', 'CIDM-5888', now(), now(), NULL, NULL, 0, NULL, NULL, 'e2c90cd0-a905-4cca-ad60-396ac2cfc41e',  NULL)ON CONFLICT DO NOTHING;


=============================================================================================================================================


delete from cjams.team where teamname ='FTDM Facilitator' and activeflag=1;


-- For Baltimore City

INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid) 
VALUES('f3e416c9-46db-457a-a3ac-528c65ccb5aa'::uuid, 1, 'FTDM Facilitator', '1429_FTDM', 'CW', 'FTDM Facilitator', NULL, NULL, '7665ca54-5374-4174-be07-a687b811a82c'::uuid, 'CIDM-5888', now(), 'CIDM-5888', now(), now(), NULL, NULL, NULL, NULL, NULL, '7665ca54-5374-4174-be07-a687b811a82c',  NULL)ON CONFLICT DO NOTHING;




--- for Baltimore County

INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid) 

VALUES('fecdd522-fae2-4be4-8e03-c12f7fb3a6c3'::uuid, 1, 'FTDM Facilitator', '1430_FTDM', 'CW', 'FTDM Facilitator', NULL, NULL, '1b7ae41e-e77a-4a1e-a0a3-cda5292cde0b'::uuid, 'CIDM-5888', now(), 'CIDM-5888', now(), now(), NULL, NULL, NULL, NULL, NULL, '1b7ae41e-e77a-4a1e-a0a3-cda5292cde0b',  NULL)ON CONFLICT DO NOTHING;

-- for Calvert

INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid) 
VALUES('490af779-1df3-495b-b762-f3fc692d99aa'::uuid, 1, 'FTDM Facilitator', '1431_FTDM', 'CW', 'FTDM Facilitator', NULL, NULL, 'b0ca6422-8241-4d86-bfef-51c7225de2fc'::uuid, 'CIDM-5888', now(), 'CIDM-5888', now(), now(), NULL, NULL, NULL, NULL, NULL, 'b0ca6422-8241-4d86-bfef-51c7225de2fc',  NULL)ON CONFLICT DO NOTHING;

-- For Caroline

INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid) 
VALUES('247d56b1-ca7a-433c-b38f-6e7aebbced64'::uuid, 1, 'FTDM Facilitator', '1432_FTDM', 'CW', 'FTDM Facilitator County', NULL, NULL, '9f60d4f1-4004-474f-a432-a19da7b1efe0'::uuid, 'CIDM-5888', now(), 'CIDM-5888', now(), now(), NULL, NULL, NULL, NULL, NULL, '9f60d4f1-4004-474f-a432-a19da7b1efe0',  NULL)ON CONFLICT DO NOTHING;

-- For Carroll

INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid) 
VALUES('885e528a-6574-4659-83ca-35b3411898ae'::uuid, 1, 'FTDM Facilitator', '1433_FTDM', 'CW', 'FTDM Facilitator', NULL, NULL, 'c3fa7975-4ee2-4c4f-90b7-e485e2da63a1'::uuid, 'CIDM-5888', now(), 'CIDM-5888', now(), now(), NULL, NULL, NULL, NULL, NULL, 'c3fa7975-4ee2-4c4f-90b7-e485e2da63a1',  NULL)ON CONFLICT DO NOTHING;

-- For Cecil

INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid)
VALUES('59823d05-9a60-4763-8756-1fc96cf0178e'::uuid, 1, 'FTDM Facilitator', '1434_FTDM', 'CW', 'FTDM Facilitator', NULL, NULL, '817e0751-1fa8-4c31-8233-8fffd6426235'::uuid, 'CIDM-5888', now(), 'CIDM-5888', now(), now(), NULL, NULL, NULL, NULL, NULL, '817e0751-1fa8-4c31-8233-8fffd6426235',  NULL)ON CONFLICT DO NOTHING;

--For Central Office

INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid) 
VALUES('522bfd6a-096c-49e5-8a6d-90f8c41a8f65'::uuid, 1, 'FTDM Facilitator', '1451_FTDM', 'CW', 'FTDM Facilitator', NULL, NULL, '3254e9ef-08da-4cd7-8aa1-083896ed9abc'::uuid, 'CIDM-5888', now(), 'CIDM-5888', now(), now(), NULL, NULL, NULL, NULL, NULL, '3254e9ef-08da-4cd7-8aa1-083896ed9abc',  NULL)ON CONFLICT DO NOTHING;

--For Charles

INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid) 
VALUES('a1fae222-736a-4c92-adb0-24d430443b5c'::uuid, 1, 'FTDM Facilitator', '1435_FTDM', 'CW', 'FTDM Facilitator', NULL, NULL, '58bac299-69ce-4cd2-8e9c-2773524050db'::uuid, 'CIDM-5888', now(), 'CIDM-5888', now(), now(), NULL, NULL, NULL, NULL, NULL, '58bac299-69ce-4cd2-8e9c-2773524050db',  NULL)ON CONFLICT DO NOTHING;

--For Dorchester

INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid) 
VALUES('cd22ad29-f37a-4e41-b32d-6c0e1a2ca63a'::uuid, 1, 'FTDM Facilitator', '1436_FTDM', 'CW', 'FTDM Facilitator', NULL, NULL, '971e5c71-6f29-4918-a1f2-f880fe5702b1'::uuid, 'CIDM-5888', now(), 'CIDM-5888', now(), now(), NULL, NULL, NULL, NULL, NULL, '971e5c71-6f29-4918-a1f2-f880fe5702b1',  NULL)ON CONFLICT DO NOTHING;

--For Harford

INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid) 
VALUES('3672b3f4-b8a9-4e0c-b665-f7a6ca0d0de5'::uuid, 1, 'FTDM Facilitator', '1439_FTDM', 'CW', 'FTDM Facilitator', NULL, NULL, '34457960-811a-4d35-a416-b8941d6974cc'::uuid, 'CIDM-5888', now(), 'CIDM-5888', now(), now(), NULL, NULL, NULL, NULL, NULL, '34457960-811a-4d35-a416-b8941d6974cc',  NULL)ON CONFLICT DO NOTHING;

--For Howard

INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid) 
VALUES('90e78e08-5922-454a-9091-fb5caafe32a4'::uuid, 1, 'FTDM Facilitator', '1440_FTDM', 'CW', 'FTDM Facilitator', NULL, NULL, 'bbce9638-24f9-4336-993c-007f6755c980'::uuid, 'CIDM-5888', now(), 'CIDM-5888', now(), now(), NULL, NULL, NULL, NULL, NULL, 'bbce9638-24f9-4336-993c-007f6755c980',  NULL)ON CONFLICT DO NOTHING;

--For Kent 

INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid) 
VALUES('e7d0a9b1-7aad-49f2-9e4b-6bb40c563a5c'::uuid, 1, 'FTDM Facilitator', '1441_FTDM', 'CW', 'FTDM Facilitator', NULL, NULL, '01511461-8e8f-4c60-85f7-7e8faa3a3266'::uuid, 'CIDM-5888', now(), 'CIDM-5888', now(), now(), NULL, NULL, NULL, NULL, NULL, '01511461-8e8f-4c60-85f7-7e8faa3a3266',  NULL)ON CONFLICT DO NOTHING;

-- For Montgomery

INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid) 
VALUES('ce97d87e-3dbc-4c6a-900c-5c28e6831e20'::uuid, 1, 'FTDM Facilitator', '1442_FTDM', 'CW', 'FTDM Facilitator', NULL, NULL, 'f6ab02d5-c386-4659-8810-687fc191a967'::uuid, 'CIDM-5888', now(), 'CIDM-5888', now(), now(), NULL, NULL, NULL, NULL, NULL, 'f6ab02d5-c386-4659-8810-687fc191a967',  NULL)ON CONFLICT DO NOTHING;

--For Prince George's

INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid) 
VALUES('e0207eec-10a0-4320-848b-585fb9fcda1b'::uuid, 1, 'FTDM Facilitator', '1443_FTDM', 'CW', 'FTDM Facilitator', NULL, NULL, 'c81be790-a79d-40ac-a38d-abd4dd5a81f6'::uuid, 'CIDM-5888', now(), 'CIDM-5888', now(), now(), NULL, NULL, NULL, NULL, NULL, 'c81be790-a79d-40ac-a38d-abd4dd5a81f6',  NULL)ON CONFLICT DO NOTHING;

--For Queen Anne's

INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid) 
VALUES('e55d6061-05a0-40a6-8dcc-24a216ada902'::uuid, 1, 'FTDM Facilitator', '1444_FTDM', 'CW', 'FTDM Facilitator', NULL, NULL, 'b26afb64-6b7f-462e-8074-cfdc9cce04c4'::uuid, 'CIDM-5888',  now(), 'CIDM-5888',  now(),  now(), NULL, NULL, NULL, NULL, NULL, 'b26afb64-6b7f-462e-8074-cfdc9cce04c4',  NULL)ON CONFLICT DO NOTHING;

--For Somerset

INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid) 
VALUES('9ce42709-1686-42be-bc39-76f5728a93c3'::uuid, 1, 'FTDM Facilitator', '1445_FTDM', 'CW', 'FTDM Facilitator County', NULL, NULL, '1e886503-ef0a-450c-8607-566c45fa75e4'::uuid, 'CIDM-5888', now(), 'CIDM-5888', now(), now(), NULL, NULL, NULL, NULL, NULL, '1e886503-ef0a-450c-8607-566c45fa75e4',  NULL)ON CONFLICT DO NOTHING;

--For St. Mary's

INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid) 
VALUES('6f2bd23f-556f-4ff2-83b4-c84159e93a9e'::uuid, 1, 'FTDM Facilitator', '1446_FTDM', 'CW', 'FTDM Facilitator', NULL, NULL, 'fa2affa3-0783-49f0-b3f8-e3fbcf59bfc0'::uuid, 'CIDM-5888', now(), 'CIDM-5888', now(), now(), NULL, NULL, NULL, NULL, NULL, 'fa2affa3-0783-49f0-b3f8-e3fbcf59bfc0',  NULL)ON CONFLICT DO NOTHING;

--For Talbot

INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid) 
VALUES('3c7f6bef-c60f-4527-8bce-8987a0008fa5'::uuid, 1, 'FTDM Facilitator', '1447_FTDM', 'CW', 'FTDM Facilitator', NULL, NULL, 'cd1940bd-e41d-4d9f-8f73-936fdf05a2cf'::uuid, 'CIDM-5888',  now(), 'CIDM-5888',  now(),  now(), NULL, NULL, NULL, NULL, NULL, 'cd1940bd-e41d-4d9f-8f73-936fdf05a2cf',  NULL)ON CONFLICT DO NOTHING;

---For Wicomico

INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid) 
VALUES('fb1b6c00-9a2a-4f82-b98e-0d9c3622f545'::uuid, 1, 'FTDM Facilitator', '1449_FTDM', 'CW', 'FTDM Facilitator', NULL, NULL, '19d487dd-8865-4ac4-b43f-9782b110a478'::uuid, 'CIDM-5888',  now(), 'CIDM-5888',  now(),  now(), NULL, NULL, NULL, NULL, NULL, '19d487dd-8865-4ac4-b43f-9782b110a478',  NULL)ON CONFLICT DO NOTHING;

--For Worcester

INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid) 
VALUES('52332b0d-e8a1-4126-95fd-2637c620f941'::uuid, 1, 'FTDM Facilitator', '1450_FTDM', 'CW', 'FTDM Facilitator', NULL, NULL, '2c8afb14-eff1-49da-b1ee-926f6a9f0314'::uuid, 'CIDM-5888', now(), 'CIDM-5888', now(), now(), NULL, NULL, NULL, NULL, NULL, '2c8afb14-eff1-49da-b1ee-926f6a9f0314',  NULL)ON CONFLICT DO NOTHING;

-- For Allegany

INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid) 
VALUES('7bc59e7c-4501-491e-b6f8-5f55a6d1a688'::uuid, 1, 'FTDM Facilitator', '1427_FTDM', 'CW', 'FTDM Facilitator', NULL, NULL, '3254e9ef-08da-4cd7-8aa1-083896ed9bec'::uuid, 'CIDM-5888', now(), 'CIDM-5888', now(), now(), NULL, NULL, NULL, NULL, NULL, '3254e9ef-08da-4cd7-8aa1-083896ed9bec',  NULL)ON CONFLICT DO NOTHING;

--For Frederick

INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid) 
VALUES('6a0afb42-e9af-4ea1-af3c-39ed2f3ea018'::uuid, 1, 'FTDM Facilitator', '1437_FTDM', 'CW', 'FTDM Facilitator', NULL, NULL, 'd0a6f218-4dee-45c3-b842-be7446a5ef41'::uuid, 'CIDM-5888', now(), 'CIDM-5888', now(), now(), NULL, NULL, NULL, NULL, NULL, 'd0a6f218-4dee-45c3-b842-be7446a5ef41',  NULL)ON CONFLICT DO NOTHING;

-- For Garrett

INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid) 
VALUES('3b32aef1-fa07-4093-a1c7-1f5fde96d6a4'::uuid, 1, 'FTDM Facilitator', '1438_FTDM', 'CW', 'FTDM Facilitator', NULL, NULL, 'ec6a5d23-4bc8-451a-9ea6-9253448aeb8a'::uuid, 'CIDM-5888', now(), 'CIDM-5888', now(), now(), NULL, NULL, NULL, NULL, NULL, 'ec6a5d23-4bc8-451a-9ea6-9253448aeb8a',  NULL)ON CONFLICT DO NOTHING;


-- For Anne Arundel

INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid) 
VALUES('5e2ad7d9-5925-4068-9d72-20a828ffc377'::uuid, 1, 'FTDM Facilitator', '1428_FTDM', 'CW', 'FTDM Facilitator', NULL, NULL, 'f5214cb2-953e-41a9-a4ad-71341501e2ad'::uuid, 'CIDM-5888', now(), 'CIDM-5888', now(), now(), NULL, NULL, 0, NULL, NULL, 'f5214cb2-953e-41a9-a4ad-71341501e2ad',  NULL)ON CONFLICT DO NOTHING;


-- For Washington County

INSERT INTO cjams.team (teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid) 
VALUES('7efa1282-38ff-4a08-bd37-0b46ce8cb7c5'::uuid, 1, 'FTDM Facilitator', '1448_FTDM', 'CW', 'FTDM Facilitator', NULL, NULL, 'e2c90cd0-a905-4cca-ad60-396ac2cfc41e'::uuid, 'CIDM-5888', '2020-10-09 19:18:33.502', 'CIDM-5888', now(), now(), NULL, NULL, 0, NULL, NULL, 'e2c90cd0-a905-4cca-ad60-396ac2cfc41e',  NULL)ON CONFLICT DO NOTHING;