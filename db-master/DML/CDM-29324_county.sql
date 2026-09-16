INSERT INTO cjams.county
(countyid, activeflag, countyname, regionid, statecountycode, fipscode, insertedby, insertedon, updatedby, updatedon, expirationdate, effectivedate, state, countycode)
VALUES('a1a3ca08-bee8-4040-83ff-e16898b982d2', 1, 'DHRIS', '4e193b3c-b58d-de11-8864-006073ea33a2', '9116', 50, 'CDM-29324', now(), 'CDM-29324', now(), NULL, now(), 'MD', 'DHRIS')on conflict do nothing;

--DHRIS
--parentteamid with new county
INSERT INTO cjams.team
(teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid)
VALUES('c19f9886-e441-498a-8b6f-239f75f1bea4', 1, 'DHRIS', '29324', 'CNTRL', 'DHRIS', '01:00:00', '04:00:00', '1ef09545-3626-4ed7-b0a8-0e9937f425c7', 'CDM-29324', now(), 'CDM-29324', now(), now(), NULL, NULL, 0, NULL, NULL, 'a1a3ca08-bee8-4040-83ff-e16898b982d2', NULL)on conflict do nothing;;

INSERT INTO cjams.team
(teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid)
VALUES('0d4e1877-3fcb-406e-afe9-a532699c2a7b', 1, 'OTHS', '29324_OTHS', 'CW', 'OTHS', NULL, NULL, 'c19f9886-e441-498a-8b6f-239f75f1bea4',  'CDM-29324', NOW(), 'CDM-29324',NOW(), NOW(), NULL, NULL, 0, NULL, NULL, 'a1a3ca08-bee8-4040-83ff-e16898b982d2', NULL)on conflict do nothing;

INSERT INTO cjams.team
(teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid)
VALUES('e28e7414-9c4d-4e72-a51f-d8e433ed33ff', 1, 'OTHS', '29324_OTHS_1', 'AS', 'OTHS', NULL, NULL, 'c19f9886-e441-498a-8b6f-239f75f1bea4',  'CDM-29324', NOW(), 'CDM-29324',NOW(), NOW(), NULL, NULL, 0, NULL, NULL, 'a1a3ca08-bee8-4040-83ff-e16898b982d2', NULL)on conflict do nothing;
