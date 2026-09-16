/*
Issue Description: CJAMS-69363 - Do Not Expunge for a Rule Out
Category/Module: Investigation Findings / Expungement
Root cause: The maltreatment type on CPS-AR # 261023816025 is Sexual Abuse, so the expungement section is disabled on the Investigation Findings screen and the user cannot check the Do not Expunge check box. Removing the case assignment end date or adding a new appeal assignment does not enable the check box.
Fix provided: Data fix has been promoted to check the checkbox of Do not expunge field with the reason for the ruled out finding on CPS-AR # 261023816025.
Data/Code fix ticket#: CJAMS-69363
Regression Impacts: N/A
Is Code fix Required?: Yes
Code fix ticket#: To be linked
Reason why no related code fix: N/A
*/

INSERT INTO cjams.expungement
(expungementid, investigationfindingid, isunsubstansiated, isindicated, isremovemaltreator, donotexpunge, manualexpunge, unsubstansiateddate, indicateddate, removemaltreatordate, investigationfinding, appealfinding, finalfinding, resultoflawenforcement, insertedon, insertedby, updatedon, updatedby, activeflag, investigationnarrative, maltreatmentid, isremoverofindings, reason, justification)
VALUES(gen_random_uuid(), '6b90fa61-66a7-4e6d-8b7c-2fb418210551', NULL, NULL, NULL, true, NULL, NULL, NULL, NULL, 'RO', NULL, NULL, '', now(), 'dffeeac8-06ad-4124-8f8d-8660da1c6262', now(), 'dffeeac8-06ad-4124-8f8d-8660da1c6262', 1, '', 'c1b59f58-0362-4a62-85c9-b74d6d6a150d', NULL, 'Data fix is done through CJAMS-69363 not to expunge the case', NULL);
