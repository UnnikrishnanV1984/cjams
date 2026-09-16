/*
Issue Description: CJAMS-61277
Category/Module: Litigation Hold - Preserve Record
Root cause: CPS-IR : 241022938395, ruled out finding User requested to check the checkbox of Do not expunge field.
Fix provided: Data fix has been promoted to check the checkbox of Do not expunge field.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix: This is a Ruled out case and user requested for a data fix
*/


INSERT INTO cjams.expungement
(expungementid, investigationfindingid, isunsubstansiated, isindicated, isremovemaltreator, donotexpunge, manualexpunge, unsubstansiateddate, indicateddate, removemaltreatordate, investigationfinding, appealfinding, finalfinding, resultoflawenforcement, insertedon, insertedby, updatedon, updatedby, activeflag, investigationnarrative, maltreatmentid, isremoverofindings, reason, justification)
VALUES(gen_random_uuid(), 'be23099b-0816-489d-b2b8-3b77e7f17b20', NULL, NULL, NULL, true, NULL, NULL, NULL, NULL, 'RO', NULL, NULL, '', now(), '75135d25-8b7f-4ae5-b792-12fdc5ac00bc', now(), '75135d25-8b7f-4ae5-b792-12fdc5ac00bc', 1, '', 'aee270e6-fea3-48ac-ac9d-a0412c395448', NULL, 'Do not Expunge', 'LHR');
