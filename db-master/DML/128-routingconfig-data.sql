
INSERT INTO cjams.routingconfig
(eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype,resourceid)
VALUES('PCAUTH', 'CWSP', 1, 'admin', now(), 'admin', now(),  now(),
NULL, NULL, 'CWSP', NULL, NULL, 'USER','031b845a-66e1-4e71-9585-eff2e17681d6');

--UPDATE EXISTING 

UPDATE routingconfig SET resourceid ='d5ca77df-42c1-4329-a09f-6b7d99b45143' WHERE routingconfigid ='367b8f7d-da54-4c25-bbe5-f000b20e3b01';
UPDATE routingconfig SET resourceid ='d5ca77df-42c1-4329-a09f-6b7d99b45143' WHERE routingconfigid ='f4343d5c-83da-40b3-8eae-f9dcedafdea5';
UPDATE routingconfig SET resourceid ='031b845a-66e1-4e71-9585-eff2e17681d6' WHERE routingconfigid ='bf52810a-cddd-4416-89ed-8772a909842e';
UPDATE routingconfig SET resourceid ='97eb840b-0102-4cae-b234-941ffeb14d67' WHERE routingconfigid ='afb20a6e-73a9-4cbc-a497-f041a2ba9aea';
UPDATE routingconfig SET resourceid ='d5ca77df-42c1-4329-a09f-6b7d99b45143' WHERE routingconfigid ='946965b1-542a-4dae-9dd4-95c07a517b76';
UPDATE routingconfig SET resourceid ='d5ca77df-42c1-4329-a09f-6b7d99b45143' WHERE routingconfigid ='b267a6bb-1c4d-4f0c-a3e3-f33823bbb5f5';
UPDATE routingconfig SET resourceid ='97eb840b-0102-4cae-b234-941ffeb14d67' WHERE routingconfigid ='da0e3ca3-8314-4b37-ae0c-892b8bf4d55f';
