--------------------------------------
--Revision(s)
-- 02/06/2024 - CIDM-10020 - User story changes added referencetype and routingconfig
-----------------------------------------
DELETE FROM routingconfig WHERE eventcode= 'MPAI' and insertedby = 'CIDM-10020';
 
INSERT INTO cjams.routingconfig
(routingconfigid, eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype, resourceid)
VALUES(gen_random_uuid(), 'MPAI', 'CWSP', 1, 'CIDM-10020', now(), 'CIDM-10020', now(), now(), NULL, NULL, 'CWCW', NULL, NULL, NULL, NULL);

DELETE FROM routingconfig WHERE eventcode= 'MPIA' and insertedby = 'CIDM-10020';

INSERT INTO cjams.routingconfig
(routingconfigid, eventcode, targetrolekey, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, targetteamtypekey, sourcerolekey, old_id, routingstatustypekey, principaltype, resourceid)
VALUES(gen_random_uuid(), 'MPIA', 'CWSP', 1, 'CIDM-10020', now(), 'CIDM-10020', now(), now(), NULL, NULL, 'CWCW', NULL, NULL, NULL, NULL);



DELETE FROM referencetype WHERE  referencetypeid= 941;
INSERT INTO referencetype
(referencetypeid, typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES(941, 'Move Person', 'actor', 1, 'CIDM-10020', Now(), 'CIDM-10020', Now(), NULL);

DELETE FROM referencevalues WHERE  referencetypeid= 941;

INSERT INTO referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('PRRV', 941, 'Move Person Review', 'Move Person Review', 'CW',1,1,'CIDM-10020', Now(),'CIDM-10020', Now(), NULL, NULL, NULL);

INSERT INTO referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('PRAP', 941, 'Move Person Approve', 'Move Person Approve', 'CW',1,2,'CIDM-10020', Now(),'CIDM-10020', Now(), NULL, NULL, NULL);

INSERT INTO referencevalues(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('PRRJ', 941, 'Move Person Reject', 'Move Person Reject', 'CW',1,3,'CIDM-10020', Now(),'CIDM-10020', Now(), NULL, NULL, NULL);
