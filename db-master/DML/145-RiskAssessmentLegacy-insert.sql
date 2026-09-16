delete from  assessmenttemplatecategoryfiltermap where assessmenttemplateid= '96c02732-e410-4745-b494-217064419c03';

delete from assessmenttemplateroleconfig where assessmenttemplateid= '96c02732-e410-4745-b494-217064419c03';

delete from assessmenttemplate where assessmenttemplateid= '96c02732-e410-4745-b494-217064419c03';



INSERT INTO cjams.assessmenttemplate
(assessmenttemplateid, name, description, "version", titleheadertext, assessmenttextpositiontypekey, instructions, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, old_id, "timestamp", helptext, datamappingenabled, enableassessmentscore, scoringname, calculationmethod, assessmentscoresetupid, external_templateid, isvisible, duedays, ismandatory, targetroletypekey, notifywhencomplete, isrequired)
VALUES('96c02732-e410-4745-b494-217064419c03', 'riskAssessmentLegacy', 'desc', 1.00, 'Risk Assessment Legacy', 'Center', 'instructions', 1, 'admin',now(), 'admin', now(), now(), NULL, NULL, decode('20','hex'), 'helptext', true, true, NULL, NULL, NULL, '5d286e60927e9405e4c9a06f', true, NULL, NULL, NULL, false, false);


INSERT INTO cjams.assessmenttemplateroleconfig
(assessmenttemplateroleconfigid, assessmenttemplateid, teamtypekey, roletypecode, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, old_id)
VALUES('818243db-cf9f-47b0-b805-fabb235c9317', '96c02732-e410-4745-b494-217064419c03', 'CW', 'CW', 1, 'admin', now(), 'admin', now(), now(), NULL);


INSERT INTO cjams.assessmenttemplatecategoryfiltermap
(assessmenttemplatecategoryfiltermapid, assessmenttemplateid, assessmenttemplatecategoryfilterid, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, old_id, "timestamp", "repeatable", intakeservicerequesttypeid, intakeservicerequestsubtypeid, assessmenttemplatetargetid, teamtypekey)
VALUES('484b0691-6bb7-432b-b1ab-653ce7161f6a', '96c02732-e410-4745-b494-217064419c03', NULL, 1, 'admin',  now(), 'admin',  now(),  now(), NULL, NULL, NULL, true, '13be391c-de90-4ab1-bf07-515a431c3e9c', '00000000-0000-0000-0000-000000000000', '30c89758-0cc4-4b4a-92b6-df57819a178b', 'CW');

INSERT INTO cjams.assessmenttemplatecategoryfiltermap
(assessmenttemplatecategoryfiltermapid, assessmenttemplateid, assessmenttemplatecategoryfilterid, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, old_id, "timestamp", "repeatable", intakeservicerequesttypeid, intakeservicerequestsubtypeid, assessmenttemplatetargetid, teamtypekey)
VALUES('841e6d83-1dd5-4bcc-afab-d22b1e222d75', '96c02732-e410-4745-b494-217064419c03', NULL, 1, 'admin',  now(), 'admin',  now(),  now(), NULL, NULL, NULL, true, '00000000-0000-0000-0000-000000000000', '00000000-0000-0000-0000-000000000000', '2a999e91-c11f-4da0-8e46-ae934cd59ea2', 'CW');
