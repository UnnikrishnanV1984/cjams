delete from routingstatustype where routingstatustypekey in ('PRASSA','PRASSP','PRASSR','PRASSI','PRASSC','PRASSS',
'PRASSSA','PRASSPA','PRASSAP');

INSERT INTO cjams.routingstatustype
(sequencenumber, routingstatustypekey, activeflag, typedescription, effectivedate, expirationdate, "timestamp", insertedby, updatedby, insertedon, updatedon, old_id)
VALUES(600, 'PRASSA', 1, 'Accepted', now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routingstatustype
(sequencenumber, routingstatustypekey, activeflag, typedescription, effectivedate, expirationdate, "timestamp", insertedby, updatedby, insertedon, updatedon, old_id)
VALUES(601, 'PRASSP', 1, 'Approved', now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routingstatustype
(sequencenumber, routingstatustypekey, activeflag, typedescription, effectivedate, expirationdate, "timestamp", insertedby, updatedby, insertedon, updatedon, old_id)
VALUES(602, 'PRASSR', 1, 'Rejected', now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routingstatustype
(sequencenumber, routingstatustypekey, activeflag, typedescription, effectivedate, expirationdate, "timestamp", insertedby, updatedby, insertedon, updatedon, old_id)
VALUES(603, 'PRASSI', 1, 'Incomplete', now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routingstatustype
(sequencenumber, routingstatustypekey, activeflag, typedescription, effectivedate, expirationdate, "timestamp", insertedby, updatedby, insertedon, updatedon, old_id)
VALUES(604, 'PRASSC', 1, 'Closed', now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routingstatustype
(sequencenumber, routingstatustypekey, activeflag, typedescription, effectivedate, expirationdate, "timestamp", insertedby, updatedby, insertedon, updatedon, old_id)
VALUES(605, 'PRASSS', 1, 'Submitted', now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routingstatustype
(sequencenumber, routingstatustypekey, activeflag, typedescription, effectivedate, expirationdate, "timestamp", insertedby, updatedby, insertedon, updatedon, old_id)
VALUES(606, 'PRASSSA', 1, 'Submit for Approval', now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routingstatustype
(sequencenumber, routingstatustypekey, activeflag, typedescription, effectivedate, expirationdate, "timestamp", insertedby, updatedby, insertedon, updatedon, old_id)
VALUES(607, 'PRASSPA', 1, 'Provisionally Accept', now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO cjams.routingstatustype
(sequencenumber, routingstatustypekey, activeflag, typedescription, effectivedate, expirationdate, "timestamp", insertedby, updatedby, insertedon, updatedon, old_id)
VALUES(608, 'PRASSAP', 1, 'Provisionally Approve', now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL);


