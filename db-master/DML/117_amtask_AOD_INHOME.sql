INSERT INTO amtask
(amtaskid, "name", description, activitytypekey, activeflag, effectivedate, expirationdate, insertedby, insertedon, updatedby, updatedon, "timestamp", voidedby, voidedon, voidreasonid, old_id, iskinship)
VALUES('7a0ffac8-7d33-429e-b383-75b355968235', 'AOD FORM', 'AOD FORM', 'services', 1, now(), NULL, 'admin', now(), 'admin', now(), NULL, NULL, NULL, NULL, NULL, NULL);

INSERT INTO ammappingtask
(ammappingtaskid, ammappingid, amtaskid, required, helptext, "sequence", duedateoffset, activitytasktypekey, activityprioritytypekey, objectid, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, expirationdate, "timestamp", duedatebasetypekey, voidedby, voidedon, voidreasonid, objecttypekey, intakeservreqtypeid, servicerequestsubtypeid, intakeserreqstatustypeid, intakeservreqinputtypeid, assessmenttemplateid, old_id, ismandatory, duedatetype)
VALUES(gen_random_uuid(), '27619e48-5359-43a5-880e-6957767cf2f7', '7a0ffac8-7d33-429e-b383-75b355968235', true, NULL, 317, NULL, 'InvGeneral', 'InvHigh', NULL, 1, 'admin', now(), 'admin', now(), now(), NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, false, NULL);
