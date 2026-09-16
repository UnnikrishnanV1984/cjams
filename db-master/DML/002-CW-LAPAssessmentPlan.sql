
delete from assessmenttemplatecategoryfiltermap
where assessmenttemplateid='3c56c5f9-c1a2-4400-ba20-fd35ada4adfe';

delete from assessmenttemplateroleconfig
where assessmenttemplateid='3c56c5f9-c1a2-4400-ba20-fd35ada4adfe';

delete from assessmenttemplate
where assessmenttemplateid='3c56c5f9-c1a2-4400-ba20-fd35ada4adfe';

INSERT INTO assessmenttemplate
(assessmenttemplateid, "name", description, "version", titleheadertext, assessmenttextpositiontypekey, instructions, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, old_id, "timestamp", helptext, datamappingenabled, enableassessmentscore, scoringname, calculationmethod, assessmentscoresetupid, external_templateid, isvisible, duedays, ismandatory, targetroletypekey, notifywhencomplete, isrequired)
VALUES('3c56c5f9-c1a2-4400-ba20-fd35ada4adfe', 'lapAssessmentPlan', 'LAP Assessment Plan', 1.00, 'LAP Assessment Plan', 'Center', 'instructions', 1, 'admin', now(), 'admin', now(), now(), NULL, NULL, decode('20','hex'), 'helptext', true, true, NULL, NULL, NULL, '5cb6fc9e3ff66c72a4f7fafc', true, NULL, NULL, NULL, false, false);


INSERT INTO assessmenttemplateroleconfig
(assessmenttemplateroleconfigid, assessmenttemplateid, teamtypekey, roletypecode, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, old_id)
VALUES('99530b5e-4291-400d-bc74-4e0ac9e6ad53', '3c56c5f9-c1a2-4400-ba20-fd35ada4adfe', 'CW', 'CW', 1, 'admin', now(), 'admin', now(), now(), NULL);


INSERT INTO assessmenttemplatecategoryfiltermap
(assessmenttemplatecategoryfiltermapid, assessmenttemplateid, assessmenttemplatecategoryfilterid, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, old_id, "timestamp", "repeatable", intakeservicerequesttypeid, intakeservicerequestsubtypeid, assessmenttemplatetargetid, teamtypekey)
VALUES('25c53e9a-2bd0-407f-8285-b3ec7cd7b5c5', '3c56c5f9-c1a2-4400-ba20-fd35ada4adfe', NULL, 1, 'admin', now(), 'admin', now(), now(), NULL, ' ', decode('20','hex'), true, '00000000-0000-0000-0000-000000000000', '00000000-0000-0000-0000-000000000000', '2a999e91-c11f-4da0-8e46-ae934cd59ea2', 'CW');
