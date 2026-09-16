-- B-185252_CIDM-8350_IV-E Case to Remain Open User Story

-- Adding new role to routings
delete from cjams.routingconfig where eventcode = 'IVECCR';

INSERT INTO cjams.routingconfig
(routingconfigid, eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype, resourceid)
VALUES(gen_random_uuid(), 'IVECCR', 'CWCW', 1, 'admin', now(), 'admin', now(), now(), NULL, NULL, 'CWSP', NULL, NULL, NULL, NULL);

-- Adding Status to routings
DELETE FROM routingstatustype WHERE sequencenumber in (201,202,203,204,205,206);

INSERT INTO cjams.routingstatustype
(sequencenumber, routingstatustypekey, activeflag, typedescription, effectivedate, expirationdate, "timestamp", insertedby, updatedby, insertedon, updatedon, old_id)
VALUES(201, 'CCR_Review', 1, 'Case Closure Review to Supervisor', now(), NULL, NULL, 'admin', NULL, NULL, NULL, NULL);

INSERT INTO cjams.routingstatustype
(sequencenumber, routingstatustypekey, activeflag, typedescription, effectivedate, expirationdate, "timestamp", insertedby, updatedby, insertedon, updatedon, old_id)
VALUES(202, 'CCR_Assigned', 1, 'Case Closure assigned from Supervisor to Specialist', now(), NULL, NULL, 'admin', NULL, NULL, NULL, NULL);

INSERT INTO cjams.routingstatustype
(sequencenumber, routingstatustypekey, activeflag, typedescription, effectivedate, expirationdate, "timestamp", insertedby, updatedby, insertedon, updatedon, old_id)
VALUES(203, 'CCR_Pending', 1, 'Case Closure Review sent from Specialist to Supervisor', now(), NULL, NULL, 'admin', NULL, NULL, NULL, NULL);

INSERT INTO cjams.routingstatustype
(sequencenumber, routingstatustypekey, activeflag, typedescription, effectivedate, expirationdate, "timestamp", insertedby, updatedby, insertedon, updatedon, old_id)
VALUES(204, 'CCR_Approved', 1, 'Case Closure approved by Supervisor', now(), NULL, NULL, 'admin', NULL, NULL, NULL, NULL);

INSERT INTO cjams.routingstatustype
(sequencenumber, routingstatustypekey, activeflag, typedescription, effectivedate, expirationdate, "timestamp", insertedby, updatedby, insertedon, updatedon, old_id)
VALUES(205, 'CCR_Rejected', 1, 'Case Closure Rejected by Supervisor', now(), NULL, NULL, 'admin', NULL, NULL, NULL, NULL);

INSERT INTO cjams.routingstatustype
(sequencenumber, routingstatustypekey, activeflag, typedescription, effectivedate, expirationdate, "timestamp", insertedby, updatedby, insertedon, updatedon, old_id)
VALUES(206, 'CCR_Reopened', 1, 'Case Closure status updated when reopen case has active removal episode', now(), NULL, NULL, 'admin', NULL, NULL, NULL, NULL);
