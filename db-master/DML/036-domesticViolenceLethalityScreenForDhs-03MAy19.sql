


delete from assessmenttemplatecategoryfiltermap where assessmenttemplateid ='e88a1ea0-39d7-49a5-8560-612b38f6bef1';

delete from assessmenttemplateroleconfig where assessmenttemplateid ='e88a1ea0-39d7-49a5-8560-612b38f6bef1';

delete from assessmenttemplate where assessmenttemplateid ='e88a1ea0-39d7-49a5-8560-612b38f6bef1';



INSERT INTO assessmenttemplate
(assessmenttemplateid, "name", description, "version", titleheadertext, assessmenttextpositiontypekey, instructions, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, old_id, "timestamp", helptext, datamappingenabled, enableassessmentscore, scoringname, calculationmethod, assessmentscoresetupid, external_templateid, isvisible, duedays, ismandatory, targetroletypekey, notifywhencomplete, isrequired)
VALUES('e88a1ea0-39d7-49a5-8560-612b38f6bef1', 'domesticViolenceLethalityScreenForDhs', 'desc', 1.00, 'DOMESTIC VIOLENCE LETHALITY SCREEN FOR DHS', 'Center', 'instructions', 1, 'S-1-5-21-152097760-152508613-1969071786-500', '2019-04-03 12:16:36.000', 'S-1-5-21-152097760-152508613-1969071786-500', '2019-04-03 13:11:30.000', '2019-04-03 12:16:36.000', NULL, NULL, decode('20','hex'), 'helptext', true, true, NULL, NULL, NULL, '5ca4a423c952f91528b1f582', true, NULL, NULL, NULL, false, false);


INSERT INTO assessmenttemplateroleconfig
(assessmenttemplateroleconfigid, assessmenttemplateid, teamtypekey, roletypecode, activeflag, updatedby, updatedon, insertedby, insertedon, effectivedate, old_id)
VALUES('0ee25d49-2d79-4d81-9c43-55a4e43451cf', 'e88a1ea0-39d7-49a5-8560-612b38f6bef1', 'CW', 'CW', 1, 'admin', '2019-05-03 15:30:14.718', 'admin', '2019-05-03 15:30:14.718', '2019-05-03 15:30:14.718', NULL);


INSERT INTO assessmenttemplatecategoryfiltermap
(assessmenttemplatecategoryfiltermapid, assessmenttemplateid, assessmenttemplatecategoryfilterid, activeflag, insertedby, insertedon, updatedby, updatedon, effectivedate, expirationdate, old_id, "timestamp", "repeatable", intakeservicerequesttypeid, intakeservicerequestsubtypeid, assessmenttemplatetargetid, teamtypekey)
VALUES('0cc911bb-a2a4-483d-9172-5baaa0b9dd2b', 'e88a1ea0-39d7-49a5-8560-612b38f6bef1', NULL, 1, 'admin', '2019-05-03 15:30:17.718', 'admin', '2019-05-03 15:30:17.718', '2019-05-03 15:30:17.718', NULL, ' ', decode('20','hex'), true, '00000000-0000-0000-0000-000000000000', '00000000-0000-0000-0000-000000000000', '2a999e91-c11f-4da0-8e46-ae934cd59ea2', 'CW');
