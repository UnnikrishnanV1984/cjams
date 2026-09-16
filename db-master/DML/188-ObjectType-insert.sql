delete from objecttype where objecttypekey in ('InvestigationFindingMed','InvsFindlawEnforcement','InvsFindPhysican');

INSERT INTO cjams.objecttype
(sequencenumber, objecttypekey, activeflag, datavalue, editable, typedescription, effectivedate, expirationdate, "timestamp", insertedby, updatedby, insertedon, updatedon, old_id)
VALUES(909, 'InvestigationFindingMed', 1, 907, 0, 'InvestigationFindingMedicalAssessments',  now(), NULL, NULL, 'admin', NULL,  now(), NULL, NULL);
INSERT INTO cjams.objecttype
(sequencenumber, objecttypekey, activeflag, datavalue, editable, typedescription, effectivedate, expirationdate, "timestamp", insertedby, updatedby, insertedon, updatedon, old_id)
VALUES(910, 'InvsFindlawEnforcement', 1, 910, 0, 'InvestigationFindingLawEnforcement',  now(), NULL, NULL, 'admin', NULL,  now(), NULL, NULL);
INSERT INTO cjams.objecttype
(sequencenumber, objecttypekey, activeflag, datavalue, editable, typedescription, effectivedate, expirationdate, "timestamp", insertedby, updatedby, insertedon, updatedon, old_id)
VALUES(911, 'InvsFindPhysican', 1, 911, 0, 'InvestigationFindingPhysican',  now(), NULL, NULL, 'admin', NULL,  now(), NULL, NULL);
