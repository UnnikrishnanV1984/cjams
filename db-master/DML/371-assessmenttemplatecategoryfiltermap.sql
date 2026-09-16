                         
INSERT INTO cjams.assessmenttemplate
(assessmenttemplateid, "name", description, "version", titleheadertext, assessmenttextpositiontypekey, instructions, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, old_id, "timestamp", helptext, datamappingenabled, enableassessmentscore, scoringname, calculationmethod, assessmentscoresetupid, external_templateid, isvisible, duedays, ismandatory, targetroletypekey, notifywhencomplete, isrequired)
VALUES('a4089e4b-91e1-43ea-bb57-fd9e243b2605', 'stsi', 'desc', 1.00, 'SEX TRAFFICKING(CST) SCREENING INTERVIEW', 'Center', 'instructions', 1, 'admin', '2020-03-30 12:16:36.000', 'admin', '2020-03-30 12:16:36.000', '2020-03-30 12:16:36.000', NULL, NULL, decode('20','hex'), 'helptext', true, true, NULL, NULL, NULL, NULL, true, NULL, NULL, NULL, false, false);
                   

INSERT INTO cjams.assessmenttemplateroleconfig
(assessmenttemplateroleconfigid, assessmenttemplateid, teamtypekey, roletypecode, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, old_id)
VALUES('6d255abb-cee4-421e-a7f3-8ab3db2c1d1f', 'a4089e4b-91e1-43ea-bb57-fd9e243b2605', 'CW', 'CW', 1, 'admin', '2020-03-30 12:16:36.000', 'admin', '2020-03-30 12:16:36.000', '2020-03-30 12:16:36.000', NULL);


INSERT INTO cjams.assessmenttemplatecategoryfiltermap
(assessmenttemplatecategoryfiltermapid, assessmenttemplateid, assessmenttemplatecategoryfilterid, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, old_id, "timestamp", "repeatable", intakeservicerequesttypeid, intakeservicerequestsubtypeid, assessmenttemplatetargetid, teamtypekey)
VALUES('bd80c721-d8f9-4db5-868c-17dd4571613e', 'a4089e4b-91e1-43ea-bb57-fd9e243b2605', NULL, 1, 'admin', '2020-03-30 12:16:36.000', 'admin', '2020-03-30 12:16:36.000', '2020-03-30 12:16:36.000', NULL, ' ', decode('20','hex'), true, '13be391c-de90-4ab1-bf07-515a431c3e9c', '00000000-0000-0000-0000-000000000000', '30c89758-0cc4-4b4a-92b6-df57819a178b', 'CW');
             

INSERT INTO cjams.assessmenttemplatecategoryfiltermap
(assessmenttemplatecategoryfiltermapid, assessmenttemplateid, assessmenttemplatecategoryfilterid, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, old_id, "timestamp", "repeatable", intakeservicerequesttypeid, intakeservicerequestsubtypeid, assessmenttemplatetargetid, teamtypekey)
VALUES('ce8632f4-37d5-4843-9f10-771a9203b38d', 'a4089e4b-91e1-43ea-bb57-fd9e243b2605', NULL, 1, 'admin', '2020-03-30 12:16:36.000', 'admin', '2020-03-30 12:16:36.000', '2020-03-30 12:16:36.000', NULL, ' ', decode('20','hex'), true, '00000000-0000-0000-0000-000000000000', '00000000-0000-0000-0000-000000000000', '2a999e91-c11f-4da0-8e46-ae934cd59ea2', 'CW');
 




