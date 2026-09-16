/*
Issue Description: CJAMS-61276
Category/Module: Litigation Hold - Preserve Record
Root cause: CPS-IR :  (CPS-IR : 241022257793), ruled out finding User requested to check the checkbox of Do not expunge field.
            We are going to preserve this IR from Manual expungement.
Fix provided: Data fix has been promoted to check the checkbox of Do not expunge field.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix: This is a Ruled out case and user requested for a data fix
*/


INSERT INTO cjams.expungement
(expungementid, investigationfindingid, isunsubstansiated, isindicated, isremovemaltreator, donotexpunge, manualexpunge, unsubstansiateddate, indicateddate, removemaltreatordate, investigationfinding, appealfinding, finalfinding, resultoflawenforcement, insertedon, insertedby, updatedon, updatedby, activeflag, investigationnarrative, maltreatmentid, isremoverofindings, reason, justification)
VALUES(gen_random_uuid(), '57dc7c61-8594-4ec6-8387-cf7aff60015f', NULL, NULL, NULL, true, NULL, NULL, NULL, NULL, 'RO', NULL, NULL, '', now(), '75135d25-8b7f-4ae5-b792-12fdc5ac00bc', now(), '75135d25-8b7f-4ae5-b792-12fdc5ac00bc', 1, '', '8d584861-e261-45b2-bc0c-a0f773ebd3fa', NULL, 'Do not Expunge', 'LHR');