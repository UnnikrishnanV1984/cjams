INSERT INTO cjams.team
( teamid, activeflag, teamname, teamnumber, teamtypekey, description, officetimingfrom, officetimingto, parentteamid, 
insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", region, regionid, old_id, countyid, supervisorid)
VALUES('bc724155-4949-46c7-b9e9-4529d3fcf74c', 1, 'CJAMS', '3824_99', 'CW', '-', NULL, NULL, '0694e49a-0d97-461a-abb1-78c4783ac572', 
'admin2', now(), 'admin2', now(), now(), NULL, NULL, NULL, NULL, NULL, '11dc65f0-b116-45a9-a07a-8fbe171f0c9d', NULL)
ON CONFLICT DO NOTHING;

UPDATE teammember
SET teamid = 'bc724155-4949-46c7-b9e9-4529d3fcf74c'
WHERE teammemberid = 'a2ea1539-9d2b-40b8-b79e-4d982ab3ae34';

UPDATE userprofile
SET firstname = 'Migration', fullname = 'Migration User' ,displayname = 'Migration User'
WHERE securityusersid = '00000000-0000-0000-0000-000000000000';