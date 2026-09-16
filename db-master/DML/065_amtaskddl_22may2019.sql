INSERT INTO amtask
(amtaskid, "name", description, activitytypekey, activeflag, effectivedate, expirationdate, insertedby, insertedon, updatedby, updatedon, "timestamp", voidedby, voidedon, voidreasonid, old_id, iskinship)
VALUES('63a4f693-9b03-42a6-a48a-67ea3987697f', 'Acknowledgement to reporting source', 'Acknowledgement to reporting source', 'Investigation', 1, now(), NULL, 'admin', now(), 'admin', now(), NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO ammappingtask
(ammappingtaskid, ammappingid, amtaskid, required, helptext, "sequence", duedateoffset, activitytasktypekey, activityprioritytypekey, objectid, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, "timestamp", duedatebasetypekey, voidedby, voidedon, voidreasonid, objecttypekey, intakeservreqtypeid, servicerequestsubtypeid, intakeserreqstatustypeid, intakeservreqinputtypeid, assessmenttemplateid, old_id, ismandatory, duedatetype)
VALUES(gen_random_uuid(), 'bee2ad92-73d4-473b-977c-5dfae3e8db0d', '63a4f693-9b03-42a6-a48a-67ea3987697f', true, NULL, 317, NULL, 'InvGeneral', 'InvHigh', NULL, 1, 'admin', now(), 'admin', now(), now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, false, NULL);

INSERT INTO amtask
(amtaskid, "name", description, activitytypekey, activeflag, effectivedate, expirationdate, insertedby, insertedon, updatedby, updatedon, "timestamp", voidedby, voidedon, voidreasonid, old_id, iskinship)
VALUES('33dd164d-f64b-42b3-af13-c249e5eaf897', 'Notification to law enforcement of IR/AR assignment', 'Notification to law enforcement of IR/AR assignment', 'Investigation', 1, now(), NULL, 'admin', now(), 'admin', now(), NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO ammappingtask
(ammappingtaskid, ammappingid, amtaskid, required, helptext, "sequence", duedateoffset, activitytasktypekey, activityprioritytypekey, objectid, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, "timestamp", duedatebasetypekey, voidedby, voidedon, voidreasonid, objecttypekey, intakeservreqtypeid, servicerequestsubtypeid, intakeserreqstatustypeid, intakeservreqinputtypeid, assessmenttemplateid, old_id, ismandatory, duedatetype)
VALUES(gen_random_uuid(), 'bee2ad92-73d4-473b-977c-5dfae3e8db0d', '33dd164d-f64b-42b3-af13-c249e5eaf897', true, NULL, 317, NULL, 'InvGeneral', 'InvHigh', NULL, 1, 'admin', now(), 'admin', now(), now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, false, NULL);

INSERT INTO amtask
(amtaskid, "name", description, activitytypekey, activeflag, effectivedate, expirationdate, insertedby, insertedon, updatedby, updatedon, "timestamp", voidedby, voidedon, voidreasonid, old_id, iskinship)
VALUES('4d59d801-caa1-48fc-993a-13d5d89022a7', 'Service Log updated', 'Service Log updated', 'Investigation', 1, now(), NULL, 'admin', now(), 'admin', now(), NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO ammappingtask
(ammappingtaskid, ammappingid, amtaskid, required, helptext, "sequence", duedateoffset, activitytasktypekey, activityprioritytypekey, objectid, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, "timestamp", duedatebasetypekey, voidedby, voidedon, voidreasonid, objecttypekey, intakeservreqtypeid, servicerequestsubtypeid, intakeserreqstatustypeid, intakeservreqinputtypeid, assessmenttemplateid, old_id, ismandatory, duedatetype)
VALUES(gen_random_uuid(), 'bee2ad92-73d4-473b-977c-5dfae3e8db0d', '4d59d801-caa1-48fc-993a-13d5d89022a7', true, NULL, 317, NULL, 'InvGeneral', 'InvHigh', NULL, 1, 'admin', now(), 'admin', now(), now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, false, NULL);

INSERT INTO amtask
(amtaskid, "name", description, activitytypekey, activeflag, effectivedate, expirationdate, insertedby, insertedon, updatedby, updatedon, "timestamp", voidedby, voidedon, voidreasonid, old_id, iskinship)
VALUES('b6178e13-8d51-4dbb-99ff-fa75a026629a', 'Document victims, maltreators and findings for all allegations/casetypes', 'Document victims, maltreators and findings for all allegations/casetypes', 'Investigation', 1, now(), NULL, 'admin', now(), 'admin', now(), NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO ammappingtask
(ammappingtaskid, ammappingid, amtaskid, required, helptext, "sequence", duedateoffset, activitytasktypekey, activityprioritytypekey, objectid, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, "timestamp", duedatebasetypekey, voidedby, voidedon, voidreasonid, objecttypekey, intakeservreqtypeid, servicerequestsubtypeid, intakeserreqstatustypeid, intakeservreqinputtypeid, assessmenttemplateid, old_id, ismandatory, duedatetype)
VALUES(gen_random_uuid(), 'bee2ad92-73d4-473b-977c-5dfae3e8db0d', 'b6178e13-8d51-4dbb-99ff-fa75a026629a', true, NULL, 317, NULL, 'InvGeneral', 'InvHigh', NULL, 1, 'admin', now(), 'admin', now(), now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, false, NULL);

INSERT INTO amtask
(amtaskid, "name", description, activitytypekey, activeflag, effectivedate, expirationdate, insertedby, insertedon, updatedby, updatedon, "timestamp", voidedby, voidedon, voidreasonid, old_id, iskinship)
VALUES('277b31a8-c6eb-43bf-bae6-6b1a6bf80a42', 'Notification to SAO of abuse investigation finding (Indicated, Unsub, and Ruled out)', 'Notification to SAO of abuse investigation finding (Indicated, Unsub, and Ruled out)', 'Investigation', 1, now(), NULL, 'admin', now(), 'admin', now(), NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO ammappingtask
(ammappingtaskid, ammappingid, amtaskid, required, helptext, "sequence", duedateoffset, activitytasktypekey, activityprioritytypekey, objectid, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, "timestamp", duedatebasetypekey, voidedby, voidedon, voidreasonid, objecttypekey, intakeservreqtypeid, servicerequestsubtypeid, intakeserreqstatustypeid, intakeservreqinputtypeid, assessmenttemplateid, old_id, ismandatory, duedatetype)
VALUES(gen_random_uuid(), 'bee2ad92-73d4-473b-977c-5dfae3e8db0d', '277b31a8-c6eb-43bf-bae6-6b1a6bf80a42', true, NULL, 317, NULL, 'InvGeneral', 'InvHigh', NULL, 1, 'admin', now(), 'admin', now(), now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, false, NULL);

INSERT INTO amtask
(amtaskid, "name", description, activitytypekey, activeflag, effectivedate, expirationdate, insertedby, insertedon, updatedby, updatedon, "timestamp", voidedby, voidedon, voidreasonid, old_id, iskinship)
VALUES('85c6185c-54eb-4e15-a979-bfddcc3b4754', 'Transfer investigation to Appeal Coordinator for all investigations with Indicated and Unsub. findings', 'Transfer investigation to Appeal Coordinator for all investigations with Indicated and Unsub. findings', 'Investigation', 1, now(), NULL, 'admin', now(), 'admin', now(), NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO ammappingtask
(ammappingtaskid, ammappingid, amtaskid, required, helptext, "sequence", duedateoffset, activitytasktypekey, activityprioritytypekey, objectid, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, "timestamp", duedatebasetypekey, voidedby, voidedon, voidreasonid, objecttypekey, intakeservreqtypeid, servicerequestsubtypeid, intakeserreqstatustypeid, intakeservreqinputtypeid, assessmenttemplateid, old_id, ismandatory, duedatetype)
VALUES(gen_random_uuid(), 'bee2ad92-73d4-473b-977c-5dfae3e8db0d', '85c6185c-54eb-4e15-a979-bfddcc3b4754', true, NULL, 317, NULL, 'InvGeneral', 'InvHigh', NULL, 1, 'admin', now(), 'admin', now(), now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, false, NULL);

INSERT INTO amtask
(amtaskid, "name", description, activitytypekey, activeflag, effectivedate, expirationdate, insertedby, insertedon, updatedby, updatedon, "timestamp", voidedby, voidedon, voidreasonid, old_id, iskinship)
VALUES('c28463c3-a9e0-41e0-a1d5-ffcefeb696d8', 'Refer all children aged 3 and under on IR w/Indicated findings to Infants and Toddler', 'Refer all children aged 3 and under on IR w/Indicated findings to Infants and Toddler', 'Investigation', 1, now(), NULL, 'admin', now(), 'admin', now(), NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO ammappingtask
(ammappingtaskid, ammappingid, amtaskid, required, helptext, "sequence", duedateoffset, activitytasktypekey, activityprioritytypekey, objectid, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, "timestamp", duedatebasetypekey, voidedby, voidedon, voidreasonid, objecttypekey, intakeservreqtypeid, servicerequestsubtypeid, intakeserreqstatustypeid, intakeservreqinputtypeid, assessmenttemplateid, old_id, ismandatory, duedatetype)
VALUES(gen_random_uuid(), 'bee2ad92-73d4-473b-977c-5dfae3e8db0d', 'c28463c3-a9e0-41e0-a1d5-ffcefeb696d8', true, NULL, 317, NULL, 'InvGeneral', 'InvHigh', NULL, 1, 'admin', now(), 'admin', now(), now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, false, NULL);

INSERT INTO amtask
(amtaskid, "name", description, activitytypekey, activeflag, effectivedate, expirationdate, insertedby, insertedon, updatedby, updatedon, "timestamp", voidedby, voidedon, voidreasonid, old_id, iskinship)
VALUES('16f96884-1520-4dfd-abce-c168bb68edf3', 'Document initial face-to-face of all children in the care of the alleged maltreator', 'Document initial face-to-face of all children in the care of the alleged maltreator', 'Investigation', 1, now(), NULL, 'admin', now(), 'admin', now(), NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO ammappingtask
(ammappingtaskid, ammappingid, amtaskid, required, helptext, "sequence", duedateoffset, activitytasktypekey, activityprioritytypekey, objectid, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, "timestamp", duedatebasetypekey, voidedby, voidedon, voidreasonid, objecttypekey, intakeservreqtypeid, servicerequestsubtypeid, intakeserreqstatustypeid, intakeservreqinputtypeid, assessmenttemplateid, old_id, ismandatory, duedatetype)
VALUES(gen_random_uuid(), 'bee2ad92-73d4-473b-977c-5dfae3e8db0d', '16f96884-1520-4dfd-abce-c168bb68edf3', true, NULL, 317, NULL, 'InvGeneral', 'InvHigh', NULL, 1, 'admin', now(), 'admin', now(), now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, false, NULL);

INSERT INTO amtask
(amtaskid, "name", description, activitytypekey, activeflag, effectivedate, expirationdate, insertedby, insertedon, updatedby, updatedon, "timestamp", voidedby, voidedon, voidreasonid, old_id, iskinship)
VALUES('c3984c04-dbaa-42fb-9723-4333fac505c7', 'Document initial face-to-face of all family members', 'Document initial face-to-face of all family members', 'Investigation', 1, now(), NULL, 'admin', now(), 'admin', now(), NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO ammappingtask
(ammappingtaskid, ammappingid, amtaskid, required, helptext, "sequence", duedateoffset, activitytasktypekey, activityprioritytypekey, objectid, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, "timestamp", duedatebasetypekey, voidedby, voidedon, voidreasonid, objecttypekey, intakeservreqtypeid, servicerequestsubtypeid, intakeserreqstatustypeid, intakeservreqinputtypeid, assessmenttemplateid, old_id, ismandatory, duedatetype)
VALUES(gen_random_uuid(), 'bee2ad92-73d4-473b-977c-5dfae3e8db0d', 'c3984c04-dbaa-42fb-9723-4333fac505c7', true, NULL, 317, NULL, 'InvGeneral', 'InvHigh', NULL, 1, 'admin', now(), 'admin', now(), now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, false, NULL);
