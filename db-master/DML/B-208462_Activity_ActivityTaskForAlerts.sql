

delete from activitytaskstatustype  where activitytypekey = 'ChildRemoval';
delete from activitytasktype  where activitytypekey = 'ChildRemoval';
delete from activitytype where activitytypekey = 'ChildRemoval';

-- Inserting ChildRemoval in activitytype table
INSERT INTO cjams.activitytype
(sequencenumber, activitytypekey, activeflag, datavalue, editable, typedescription, effectivedate, expirationdate, "timestamp", insertedby, updatedby, insertedon, updatedon, old_id)
VALUES(10, 'ChildRemoval', 1, 10, 0, 'ChildRemoval', now(), NULL, NULL, 'CIDM-10354', 'CIDM-10354', now(), now(), NULL);


-- Inserting activity taskt ype in activitytasktype table
INSERT INTO cjams.activitytasktype
(sequencenumber, activitytasktypekey, activitytypekey, activeflag, datavalue, editable, typedescription, effectivedate, expirationdate, "timestamp", insertedby, updatedby, insertedon, updatedon, old_id)
VALUES(1, 'HealthDisorder', 'ChildRemoval', 1, 1, 0, 'HealthDisorder', now(), NULL, NULL, 'CIDM-10354', 'CIDM-10354', now(), now(), NULL);

INSERT INTO cjams.activitytasktype
(sequencenumber, activitytasktypekey, activitytypekey, activeflag, datavalue, editable, typedescription, effectivedate, expirationdate, "timestamp", insertedby, updatedby, insertedon, updatedon, old_id)
VALUES(1, 'MedicationPsychotropic', 'ChildRemoval', 1, 1, 0, 'MedicationPsychotropic', now(), NULL, NULL, 'CIDM-10354', 'CIDM-10354', now(), now(), NULL);



-- Inserting activity task status type in activitytaskstatustype table
INSERT INTO cjams.activitytaskstatustype
(sequencenumber, activitytaskstatustypekey, activitytypekey, activeflag, datavalue, editable, typedescription, effectivedate, expirationdate, "timestamp", insertedby, updatedby, insertedon, updatedon, old_id)
VALUES(1, 'CROpen', 'ChildRemoval', 1, 1, 0, 'Open', now(), NULL, NULL, 'CIDM-10354', 'CIDM-10354', now(), now(), NULL);

INSERT INTO cjams.activitytaskstatustype
(sequencenumber, activitytaskstatustypekey, activitytypekey, activeflag, datavalue, editable, typedescription, effectivedate, expirationdate, "timestamp", insertedby, updatedby, insertedon, updatedon, old_id)
VALUES(2, 'CRInProgress', 'ChildRemoval', 1, 1, 0, 'In Progress', now(), NULL, NULL, 'CIDM-10354', 'CIDM-10354', now(), now(), NULL);

INSERT INTO cjams.activitytaskstatustype
(sequencenumber, activitytaskstatustypekey, activitytypekey, activeflag, datavalue, editable, typedescription, effectivedate, expirationdate, "timestamp", insertedby, updatedby, insertedon, updatedon, old_id)
VALUES(3, 'CRClosed', 'ChildRemoval', 1, 1, 0, 'Closed', now(), NULL, NULL, 'CIDM-10354', 'CIDM-10354', now(), now(), NULL);
