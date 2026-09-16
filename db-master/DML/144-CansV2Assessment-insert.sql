
delete from  assessmenttemplatecategoryfiltermap where assessmenttemplateid= '6d307680-4611-4cfb-806e-d1fb75d26a61';

delete from assessmenttemplateroleconfig where assessmenttemplateid= '6d307680-4611-4cfb-806e-d1fb75d26a61';

delete from assessmenttemplate where assessmenttemplateid= '6d307680-4611-4cfb-806e-d1fb75d26a61';



INSERT INTO cjams.assessmenttemplate
(assessmenttemplateid, name, description, "version", titleheadertext, assessmenttextpositiontypekey, instructions, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, old_id, "timestamp", helptext, datamappingenabled, enableassessmentscore, scoringname, calculationmethod, assessmentscoresetupid, external_templateid, isvisible, duedays, ismandatory, targetroletypekey, notifywhencomplete, isrequired)
VALUES('6d307680-4611-4cfb-806e-d1fb75d26a61', 'cansV2', 'desc', 1.00, 'cans-v2', 'Center', 'instructions', 1, 'admin', now(), 'admin', now(), now(), NULL, NULL, decode('20','hex'), 'helptext', true, true, NULL, NULL, NULL, '5d26ec3d927e9405e4c99fb1', true, NULL, NULL, NULL, false, false);


INSERT INTO cjams.assessmenttemplateroleconfig
(assessmenttemplateroleconfigid, assessmenttemplateid, teamtypekey, roletypecode, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, old_id)
VALUES('90023da7-59ae-4668-9f17-31de853aa857', '6d307680-4611-4cfb-806e-d1fb75d26a61', 'CW', 'CW', 1, 'admin', now(), 'admin', now(), now(), NULL);


INSERT INTO cjams.assessmenttemplatecategoryfiltermap
(assessmenttemplatecategoryfiltermapid, assessmenttemplateid, assessmenttemplatecategoryfilterid, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, old_id, "timestamp", "repeatable", intakeservicerequesttypeid, intakeservicerequestsubtypeid, assessmenttemplatetargetid, teamtypekey)
VALUES('5aca0f38-44ba-472f-8f5f-b31790fa1ec3', '6d307680-4611-4cfb-806e-d1fb75d26a61', NULL, 1, 'admin', '2019-07-12 16:02:16.071', 'admin', now(), now(), NULL, NULL, NULL, true, '00000000-0000-0000-0000-000000000000', '00000000-0000-0000-0000-000000000000', '2a999e91-c11f-4da0-8e46-ae934cd59ea2', 'CW');
