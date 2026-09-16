delete from routingconfig where routingconfigid = '92ee2c47-411d-4d60-93ac-48010702691c';
INSERT INTO routingconfig
(routingconfigid, eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey)
VALUES('92ee2c47-411d-4d60-93ac-48010702691c', 'COMMACCDEL', 'FNSFS', 1, 'admin', '2019-02-11 13:08:26.521', 'admin', '2019-02-11 13:08:26.521', '2019-02-11 13:08:26.521', NULL, NULL, 'FNSFW', NULL, NULL);

delete from routingstatustype where sequencenumber =45;
INSERT INTO routingstatustype
(sequencenumber, routingstatustypekey, activeflag, typedescription, effectivedate, expirationdate, "timestamp", insertedby, updatedby, insertedon, updatedon, old_id)
VALUES(45, 'COMMACCDEL', 1, 'comingled account', '2018-12-28 17:16:15.740', NULL, NULL, NULL, NULL, NULL, NULL, NULL);

