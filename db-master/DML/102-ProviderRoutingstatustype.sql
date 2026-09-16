delete from routingstatustype where sequencenumber in (85,86,87,88,89,90);
INSERT INTO cjams.routingstatustype
(sequencenumber, routingstatustypekey, activeflag, typedescription, effectivedate, expirationdate, "timestamp", insertedby, updatedby, insertedon, updatedon, old_id)
VALUES(85, 'PRASSP', 1, 'Approved', now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routingstatustype
(sequencenumber, routingstatustypekey, activeflag, typedescription, effectivedate, expirationdate, "timestamp", insertedby, updatedby, insertedon, updatedon, old_id)
VALUES(86, 'PRASSR', 1, 'Rejected', now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routingstatustype
(sequencenumber, routingstatustypekey, activeflag, typedescription, effectivedate, expirationdate, "timestamp", insertedby, updatedby, insertedon, updatedon, old_id)
VALUES(87, 'PRASSI', 1, 'Incomplete', now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routingstatustype
(sequencenumber, routingstatustypekey, activeflag, typedescription, effectivedate, expirationdate, "timestamp", insertedby, updatedby, insertedon, updatedon, old_id)
VALUES(88, 'PRASSC', 1, 'Closed', now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routingstatustype
(sequencenumber, routingstatustypekey, activeflag, typedescription, effectivedate, expirationdate, "timestamp", insertedby, updatedby, insertedon, updatedon, old_id)
VALUES(89, 'PRASSS', 1, 'Submitted', now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO cjams.routingstatustype
(sequencenumber, routingstatustypekey, activeflag, typedescription, effectivedate, expirationdate, "timestamp", insertedby, updatedby, insertedon, updatedon, old_id)
VALUES(90, 'PRASSSA', 1, 'Submit for Approval', now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL);

