/*
Issue Description: CJAMS-61278
Category/Module: Litigation Hold - Preserve Record
Root cause: User requested to check the checkbox of Do not expunge field. Confirmed the fix with QA
Fix provided: Data fix has been promoted to check the checkbox of Do not expunge field. Confirmed the fix with QA
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix: Data fix 
*/

INSERT INTO cjams.expungement
(investigationfindingid, isunsubstansiated, isindicated, isremovemaltreator, donotexpunge, manualexpunge, unsubstansiateddate, indicateddate, removemaltreatordate, investigationfinding, appealfinding, finalfinding, resultoflawenforcement, insertedon, insertedby, updatedon, updatedby, activeflag, investigationnarrative, maltreatmentid, isremoverofindings, reason, justification)
VALUES('aa19ae4b-e1a1-4b0b-9629-36b91c76b5cf', NULL, NULL, NULL, true, NULL, NULL, NULL, NULL, 'RO', NULL, NULL, NULL, '2025-10-20 15:03:11.000', '22f78177-19c0-4bb2-a921-c133de3590cd', now(), '22f78177-19c0-4bb2-a921-c133de3590cd', 1, NULL, 'e058d9b0-a06c-4159-a252-1ff2a0115a22', NULL, 'Do not Expunge', 'LHR');
