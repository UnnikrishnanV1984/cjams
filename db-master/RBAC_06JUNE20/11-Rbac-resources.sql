INSERT INTO cjams.permissiongroup
(permissiongroupname, description, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('IV-E Eligibility Administrator', '', 1, 'RBAC', 'RBAC', now(), now(), NULL);
INSERT INTO cjams."resource"
(parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES(NULL, 'IV-E Eligibility Administrator', 2, 1, 'RBAC', now(), 'RBAC', now(), 'IV-E Eligibility Administrator', NULL, NULL, 'IV-E Eligibility Administrator', NULL, '');
INSERT INTO cjams.permissiongroup
(permissiongroupname, description, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('IV-E Eligibility Administrator Assistant', '', 1, 'RBAC', 'RBAC', now(), now(), NULL);
INSERT INTO cjams."resource"
(parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES(NULL, 'IV-E Eligibility Administrator Assistant', 2, 1, 'RBAC', now(), 'RBAC', now(), 'IV-E Eligibility Administrator Assistant', NULL, NULL, 'IV-E Eligibility Administrator Assistant', NULL, '');
INSERT INTO cjams.permissiongroup
(permissiongroupname, description, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('IV-E Eligibility Analyst', '', 1, 'RBAC', 'RBAC', now(), now(), NULL);
INSERT INTO cjams."resource"
(parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES(NULL, 'IV-E Eligibility Analyst', 2, 1, 'RBAC', now(), 'RBAC', now(), 'IV-E Eligibility Analyst', NULL, NULL, 'IV-E Eligibility Analyst', NULL, '');
INSERT INTO cjams.permissiongroup
(permissiongroupname, description, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('IV-E Eligibility Quality Assurance', '', 1, 'RBAC', 'RBAC', now(), now(), NULL);
INSERT INTO cjams."resource"
(parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES(NULL, 'IV-E Eligibility Quality Assurance', 2, 1, 'RBAC', now(), 'RBAC', now(), 'IV-E Eligibility Quality Assurance', NULL, NULL, 'IV-E Eligibility Quality Assurance', NULL, '');
INSERT INTO cjams.permissiongroup
(permissiongroupname, description, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('IV-E Liaison', '', 1, 'RBAC', 'RBAC', now(), now(), NULL);
INSERT INTO cjams."resource"
(parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES(NULL, 'IV-E Liaison', 2, 1, 'RBAC', now(), 'RBAC', now(), 'IV-E Liaison', NULL, NULL, 'IV-E Liaison', NULL, '');
INSERT INTO cjams.permissiongroup
(permissiongroupname, description, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('Finance Ar Receivable', '', 1, 'RBAC', 'RBAC', now(), now(), NULL);
INSERT INTO cjams.permissiongroup
(permissiongroupname, description, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('Licensing Coordinator', '', 1, 'RBAC', 'RBAC', now(), now(), NULL);
INSERT INTO cjams."resource"
(parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES(NULL, 'Licensing Coordinator', 2, 1, 'RBAC', now(), 'RBAC', now(), 'Licensing Coordinator', NULL, NULL, 'Licensing Coordinator', NULL, '');
INSERT INTO cjams.permissiongroup
(permissiongroupname, description, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('QA Coordinator', '', 1, 'RBAC', 'RBAC', now(), now(), NULL);
INSERT INTO cjams."resource"
(parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES(NULL, 'QA Coordinator', 2, 1, 'RBAC', now(), 'RBAC', now(), 'QA Coordinator', NULL, NULL, 'QA Coordinator', NULL, '');
INSERT INTO cjams.permissiongroup
(permissiongroupname, description, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('Placement Validation - PGNo Acess', '', 1, 'RBAC', 'RBAC', now(), now(), NULL);
INSERT INTO cjams."resource"
(parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES(NULL, 'Placement Validation', 2, 1, 'RBAC', now(), 'RBAC', now(), 'Placement Validation', NULL, NULL, 'Placement Validation', NULL, '');
INSERT INTO cjams.permissiongroup
(permissiongroupname, description, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('Client Demographic search - PGRead', '', 1, 'RBAC', 'RBAC', now(), now(), NULL);
INSERT INTO cjams.permissiongroup
(permissiongroupname, description, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('Client Demographics-IVE-PGRead Excep', '', 1, 'RBAC', 'RBAC', now(), now(), NULL);
UPDATE cjams."resource"
SET resourceid='person.involved.addassignment'
WHERE resourcename='addassignment' and resourceid='person.person.addassignment';
UPDATE cjams."resource"
SET resourceid='person.involved.editassignment'
WHERE resourcename='editassignment' and resourceid='person.person.editassignment';
INSERT INTO cjams.permissiongroup
(permissiongroupname, description, activeflag, insertedby, updatedby, insertedon, updatedon, old_id)
VALUES('Court_Order_FA', '', 1, 'RBAC', 'RBAC', now(), now(), NULL);
INSERT INTO cjams."resource"
(parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES(NULL, 'Court_Order_FA', 2, 1, 'RBAC', now(), 'RBAC', now(), 'Court_Order_FA', NULL, NULL, 'Court_Order_FA', NULL, '');
