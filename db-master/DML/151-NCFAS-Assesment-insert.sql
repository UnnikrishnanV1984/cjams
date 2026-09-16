delete from  assessmenttemplatecategoryfiltermap where assessmenttemplateid= '187edb90-d3aa-4321-9674-631e6baa2292';

delete from assessmenttemplateroleconfig where assessmenttemplateid= '187edb90-d3aa-4321-9674-631e6baa2292';

delete from assessmenttemplate where assessmenttemplateid= '187edb90-d3aa-4321-9674-631e6baa2292';




INSERT INTO cjams.assessmenttemplate
(assessmenttemplateid, name, description, "version", titleheadertext, assessmenttextpositiontypekey, instructions, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, old_id, "timestamp", helptext, datamappingenabled, enableassessmentscore, scoringname, calculationmethod, assessmentscoresetupid, external_templateid, isvisible, duedays, ismandatory, targetroletypekey, notifywhencomplete, isrequired)
VALUES('187edb90-d3aa-4321-9674-631e6baa2292', 'ncfas', 'desc', 1.00, 'NCFAS', 'Center', 'instructions', 1, 'admin', '2019-07-17 05:33:41.000', 'admin', now(), now(), NULL, NULL, decode('20','hex'), 'helptext', true, true, NULL, NULL, NULL, '5d2eeb74927e9405e4c9a64c', true, NULL, NULL, NULL, false, false);


INSERT INTO cjams.assessmenttemplateroleconfig
(assessmenttemplateroleconfigid, assessmenttemplateid, teamtypekey, roletypecode, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, old_id)
VALUES('834c5dd6-7161-4dd6-b717-6430791f640e', '187edb90-d3aa-4321-9674-631e6baa2292', 'CW', 'CW', 1, 'admin', now(), 'admin', now(), now(), NULL);


INSERT INTO cjams.assessmenttemplatecategoryfiltermap
(assessmenttemplatecategoryfiltermapid, assessmenttemplateid, assessmenttemplatecategoryfilterid, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, old_id, "timestamp", "repeatable", intakeservicerequesttypeid, intakeservicerequestsubtypeid, assessmenttemplatetargetid, teamtypekey)
VALUES('64ff865d-f314-4ecf-bc4d-57f88af6d969', '187edb90-d3aa-4321-9674-631e6baa2292', NULL, 1, 'admin',  now(), 'admin',  now(),  now(), NULL, NULL, NULL, true, '13be391c-de90-4ab1-bf07-515a431c3e9c', '00000000-0000-0000-0000-000000000000', '30c89758-0cc4-4b4a-92b6-df57819a178b', 'CW');

INSERT INTO cjams.assessmenttemplatecategoryfiltermap
(assessmenttemplatecategoryfiltermapid, assessmenttemplateid, assessmenttemplatecategoryfilterid, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, old_id, "timestamp", "repeatable", intakeservicerequesttypeid, intakeservicerequestsubtypeid, assessmenttemplatetargetid, teamtypekey)
VALUES('e749f2a4-9d08-480a-b27b-c455bd8873f3', '187edb90-d3aa-4321-9674-631e6baa2292', NULL, 1, 'admin',  now(), 'admin',  now(),  now(), NULL, NULL, NULL, true, '00000000-0000-0000-0000-000000000000', '00000000-0000-0000-0000-000000000000', '2a999e91-c11f-4da0-8e46-ae934cd59ea2', 'CW');
