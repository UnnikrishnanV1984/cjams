delete from routingstatustype where sequencenumber='609';
INSERT INTO routingstatustype
(sequencenumber, routingstatustypekey, activeflag, typedescription, effectivedate, expirationdate, "timestamp", insertedby, updatedby, insertedon, updatedon, old_id)
VALUES(609, 'PRASSRE', 1, 'Reopening the application', now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL);
delete from routingconfig where routingconfigid='0741de91-b0e6-4bca-8632-55bfb3ea2508';
INSERT INTO cjams.routingconfig
(routingconfigid, eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype)
VALUES('0741de91-b0e6-4bca-8632-55bfb3ea2508', 'PRASS', 'LDSSSP', 1, 'admin', '2019-05-29 17:28:49.478', NULL, '2019-05-29 17:28:49.478', '2019-05-29 17:28:49.478', NULL, NULL, 'LDSSHSW', NULL, NULL, NULL);
