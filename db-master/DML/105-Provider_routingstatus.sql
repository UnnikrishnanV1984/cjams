delete from routingstatustype where sequencenumber in (91,92);
INSERT INTO cjams.routingstatustype
(sequencenumber, routingstatustypekey, activeflag, typedescription, effectivedate, expirationdate, "timestamp", insertedby, updatedby, insertedon, updatedon, old_id)
VALUES(91, 'PRASSPA', 1, 'Provisionally Accept', '2019-06-13 14:59:56.278', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routingstatustype
(sequencenumber, routingstatustypekey, activeflag, typedescription, effectivedate, expirationdate, "timestamp", insertedby, updatedby, insertedon, updatedon, old_id)
VALUES(92, 'PRASSAP	', 1, 'Provisionally Approve', '2019-06-13 15:00:29.079', NULL, NULL, NULL, NULL, NULL, NULL, NULL);
