-- Team member role type 
DELETE from cjams.teammemberroletype where roletypekey in ('FTDMQIS','QUINW','FTDMFW') and activeflag=1;

INSERT INTO cjams.teammemberroletype
(sequencenumber, roletypekey, activeflag, description, teamtypekey, isroutable, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", isupervisor, old_id, rolelevel)
VALUES(1512, 'FTDMFW', 1, 'FTDM Facilitator', 'CW', true, 'ADMIN', now(), 'ADMIN', now(), now(), NULL, NULL, true, NULL, 1);
INSERT INTO cjams.teammemberroletype
(sequencenumber, roletypekey, activeflag, description, teamtypekey, isroutable, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", isupervisor, old_id, rolelevel)
VALUES(1513, 'QUINW', 1, 'Qualified Individual', 'CW', true, 'ADMIN', now(), 'ADMIN', now(), now(), NULL, NULL, true, NULL, 1);
INSERT INTO cjams.teammemberroletype
(sequencenumber, roletypekey, activeflag, description, teamtypekey, isroutable, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, "timestamp", isupervisor, old_id, rolelevel)
VALUES(1514, 'FTDMQIS', 1, 'FTDM/QI Supervisor', 'CW', true, 'ADMIN', now(), 'ADMIN', now(), now(), NULL, NULL, true, NULL, 1);

