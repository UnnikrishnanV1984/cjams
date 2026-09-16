INSERT INTO amtask
(amtaskid, "name", description, activitytypekey, activeflag, effectivedate, expirationdate, insertedby, insertedon, updatedby, updatedon, "timestamp", voidedby, voidedon, voidreasonid, old_id, iskinship)
VALUES('dff19b43-e12e-45bc-a3f6-d41a9966e70d', 'Acknowledgement to reporting source', 'Acknowledgement to reporting source', 'services', 1, now(), NULL, 'admin', now(), 'admin', now(), NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO ammappingtask
(ammappingtaskid, ammappingid, amtaskid, required, helptext, "sequence", duedateoffset, activitytasktypekey, activityprioritytypekey, objectid, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, "timestamp", duedatebasetypekey, voidedby, voidedon, voidreasonid, objecttypekey, intakeservreqtypeid, servicerequestsubtypeid, intakeserreqstatustypeid, intakeservreqinputtypeid, assessmenttemplateid, old_id, ismandatory, duedatetype)
VALUES(gen_random_uuid(), '27619e48-5359-43a5-880e-6957767cf2f7', 'dff19b43-e12e-45bc-a3f6-d41a9966e70d', true, NULL, 317, NULL, 'InvGeneral', 'InvHigh', NULL, 1, 'admin', now(), 'admin', now(), now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, false, NULL);

INSERT INTO amtask
(amtaskid, "name", description, activitytypekey, activeflag, effectivedate, expirationdate, insertedby, insertedon, updatedby, updatedon, "timestamp", voidedby, voidedon, voidreasonid, old_id, iskinship)
VALUES('3ca83838-2f7e-4b23-84ea-d69dbbd09ca0', 'Safety Plan, if applicable', 'Safety Plan, if applicable', 'services', 1, now(), NULL, 'admin', now(), 'admin', now(), NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO ammappingtask
(ammappingtaskid, ammappingid, amtaskid, required, helptext, "sequence", duedateoffset, activitytasktypekey, activityprioritytypekey, objectid, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, "timestamp", duedatebasetypekey, voidedby, voidedon, voidreasonid, objecttypekey, intakeservreqtypeid, servicerequestsubtypeid, intakeserreqstatustypeid, intakeservreqinputtypeid, assessmenttemplateid, old_id, ismandatory, duedatetype)
VALUES(gen_random_uuid(), '27619e48-5359-43a5-880e-6957767cf2f7', '3ca83838-2f7e-4b23-84ea-d69dbbd09ca0', true, NULL, 317, NULL, 'InvGeneral', 'InvHigh', NULL, 1, 'admin', now(), 'admin', now(), now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, false, NULL);

INSERT INTO amtask
(amtaskid, "name", description, activitytypekey, activeflag, effectivedate, expirationdate, insertedby, insertedon, updatedby, updatedon, "timestamp", voidedby, voidedon, voidreasonid, old_id, iskinship)
VALUES('6ec7a30d-5589-4e40-9f62-62870e03dfed', 'Service Log updated', 'Service Log updated', 'services', 1, now(), NULL, 'admin', now(), 'admin', now(), NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO ammappingtask
(ammappingtaskid, ammappingid, amtaskid, required, helptext, "sequence", duedateoffset, activitytasktypekey, activityprioritytypekey, objectid, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, "timestamp", duedatebasetypekey, voidedby, voidedon, voidreasonid, objecttypekey, intakeservreqtypeid, servicerequestsubtypeid, intakeserreqstatustypeid, intakeservreqinputtypeid, assessmenttemplateid, old_id, ismandatory, duedatetype)
VALUES(gen_random_uuid(), '27619e48-5359-43a5-880e-6957767cf2f7', '6ec7a30d-5589-4e40-9f62-62870e03dfed', true, NULL, 317, NULL, 'InvGeneral', 'InvHigh', NULL, 1, 'admin', now(), 'admin', now(), now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, false, NULL);

INSERT INTO amtask
(amtaskid, "name", description, activitytypekey, activeflag, effectivedate, expirationdate, insertedby, insertedon, updatedby, updatedon, "timestamp", voidedby, voidedon, voidreasonid, old_id, iskinship)
VALUES('690e1de8-40bb-4825-8141-6736e9ed1ccd', 'Update demographic info on all family members/roles/relationships', 'Update demographic info on all family members/roles/relationships', 'services', 1, now(), NULL, 'admin', now(), 'admin', now(), NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO ammappingtask
(ammappingtaskid, ammappingid, amtaskid, required, helptext, "sequence", duedateoffset, activitytasktypekey, activityprioritytypekey, objectid, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, "timestamp", duedatebasetypekey, voidedby, voidedon, voidreasonid, objecttypekey, intakeservreqtypeid, servicerequestsubtypeid, intakeserreqstatustypeid, intakeservreqinputtypeid, assessmenttemplateid, old_id, ismandatory, duedatetype)
VALUES(gen_random_uuid(), '27619e48-5359-43a5-880e-6957767cf2f7', '690e1de8-40bb-4825-8141-6736e9ed1ccd', true, NULL, 317, NULL, 'InvGeneral', 'InvHigh', NULL, 1, 'admin', now(), 'admin', now(), now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, false, NULL);

INSERT INTO amtask
(amtaskid, "name", description, activitytypekey, activeflag, effectivedate, expirationdate, insertedby, insertedon, updatedby, updatedon, "timestamp", voidedby, voidedon, voidreasonid, old_id, iskinship)
VALUES('274f5de9-631b-4ad3-89fa-16d35fb373c0', 'CANS-F', 'CANS-F', 'services', 1, now(), NULL, 'admin', now(), 'admin', now(), NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO ammappingtask
(ammappingtaskid, ammappingid, amtaskid, required, helptext, "sequence", duedateoffset, activitytasktypekey, activityprioritytypekey, objectid, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, "timestamp", duedatebasetypekey, voidedby, voidedon, voidreasonid, objecttypekey, intakeservreqtypeid, servicerequestsubtypeid, intakeserreqstatustypeid, intakeservreqinputtypeid, assessmenttemplateid, old_id, ismandatory, duedatetype)
VALUES(gen_random_uuid(), '27619e48-5359-43a5-880e-6957767cf2f7', '274f5de9-631b-4ad3-89fa-16d35fb373c0', true, NULL, 317, NULL, 'InvGeneral', 'InvHigh', NULL, 1, 'admin', now(), 'admin', now(), now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, false, NULL);

INSERT INTO amtask
(amtaskid, "name", description, activitytypekey, activeflag, effectivedate, expirationdate, insertedby, insertedon, updatedby, updatedon, "timestamp", voidedby, voidedon, voidreasonid, old_id, iskinship)
VALUES('7b36c64f-b0e3-4111-896f-48105272c53a', 'Complete summary of case activity', 'Complete summary of case activity', 'services', 1, now(), NULL, 'admin', now(), 'admin', now(), NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO ammappingtask
(ammappingtaskid, ammappingid, amtaskid, required, helptext, "sequence", duedateoffset, activitytasktypekey, activityprioritytypekey, objectid, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, "timestamp", duedatebasetypekey, voidedby, voidedon, voidreasonid, objecttypekey, intakeservreqtypeid, servicerequestsubtypeid, intakeserreqstatustypeid, intakeservreqinputtypeid, assessmenttemplateid, old_id, ismandatory, duedatetype)
VALUES(gen_random_uuid(), '27619e48-5359-43a5-880e-6957767cf2f7', '7b36c64f-b0e3-4111-896f-48105272c53a', true, NULL, 317, NULL, 'InvGeneral', 'InvHigh', NULL, 1, 'admin', now(), 'admin', now(), now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, false, NULL);

INSERT INTO amtask
(amtaskid, "name", description, activitytypekey, activeflag, effectivedate, expirationdate, insertedby, insertedon, updatedby, updatedon, "timestamp", voidedby, voidedon, voidreasonid, old_id, iskinship)
VALUES('3cd1905c-d181-4c24-9912-c4f2a23d1eff', 'Notify the caregiver(s) of service recommendations – Closing/transfer letter', 'Notify the caregiver(s) of service recommendations – Closing/transfer letter', 'services', 1, now(), NULL, 'admin', now(), 'admin', now(), NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO ammappingtask
(ammappingtaskid, ammappingid, amtaskid, required, helptext, "sequence", duedateoffset, activitytasktypekey, activityprioritytypekey, objectid, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, "timestamp", duedatebasetypekey, voidedby, voidedon, voidreasonid, objecttypekey, intakeservreqtypeid, servicerequestsubtypeid, intakeserreqstatustypeid, intakeservreqinputtypeid, assessmenttemplateid, old_id, ismandatory, duedatetype)
VALUES(gen_random_uuid(), '27619e48-5359-43a5-880e-6957767cf2f7', '3cd1905c-d181-4c24-9912-c4f2a23d1eff', true, NULL, 317, NULL, 'InvGeneral', 'InvHigh', NULL, 1, 'admin', now(), 'admin', now(), now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, false, NULL);

INSERT INTO amtask
(amtaskid, "name", description, activitytypekey, activeflag, effectivedate, expirationdate, insertedby, insertedon, updatedby, updatedon, "timestamp", voidedby, voidedon, voidreasonid, old_id, iskinship)
VALUES('7fda9b36-5bed-47e1-89db-055d54508cb3', 'Document initial face-to-face of all children', 'Document initial face-to-face of all children', 'services', 1, now(), NULL, 'admin', now(), 'admin', now(), NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO ammappingtask
(ammappingtaskid, ammappingid, amtaskid, required, helptext, "sequence", duedateoffset, activitytasktypekey, activityprioritytypekey, objectid, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, "timestamp", duedatebasetypekey, voidedby, voidedon, voidreasonid, objecttypekey, intakeservreqtypeid, servicerequestsubtypeid, intakeserreqstatustypeid, intakeservreqinputtypeid, assessmenttemplateid, old_id, ismandatory, duedatetype)
VALUES(gen_random_uuid(), '27619e48-5359-43a5-880e-6957767cf2f7', '7fda9b36-5bed-47e1-89db-055d54508cb3', true, NULL, 317, NULL, 'InvGeneral', 'InvHigh', NULL, 1, 'admin', now(), 'admin', now(), now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, false, NULL);

INSERT INTO amtask
(amtaskid, "name", description, activitytypekey, activeflag, effectivedate, expirationdate, insertedby, insertedon, updatedby, updatedon, "timestamp", voidedby, voidedon, voidreasonid, old_id, iskinship)
VALUES('1cbf9b47-35c0-4e95-9829-afca734b5b45', 'SAFE-C', 'SAFE-C', 'services', 1, now(), NULL, 'admin', now(), 'admin', now(), NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO ammappingtask
(ammappingtaskid, ammappingid, amtaskid, required, helptext, "sequence", duedateoffset, activitytasktypekey, activityprioritytypekey, objectid, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, "timestamp", duedatebasetypekey, voidedby, voidedon, voidreasonid, objecttypekey, intakeservreqtypeid, servicerequestsubtypeid, intakeserreqstatustypeid, intakeservreqinputtypeid, assessmenttemplateid, old_id, ismandatory, duedatetype)
VALUES(gen_random_uuid(), '27619e48-5359-43a5-880e-6957767cf2f7', '1cbf9b47-35c0-4e95-9829-afca734b5b45', true, NULL, 317, NULL, 'InvGeneral', 'InvHigh', NULL, 1, 'admin', now(), 'admin', now(), now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, false, NULL);
