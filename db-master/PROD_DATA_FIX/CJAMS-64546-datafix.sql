/*
Issue Description: CJAMS-64546 Delete Intakes
Category/Module: Delete Intakes
Root cause: User requested to delete the intakes from the system
Fix provided: Data fix has been promoted to delete the intakes from the system.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix: The issue is specific to data and is not a recurring one or a logical issue.
*/

UPDATE intakedastatus 
SET activeflag = 0, updatedon = NOW(), updatedby = 'CJAMS-64546'
WHERE intakenumber IN ('I251013380037', 'I251013377294', 'I251013376509')
AND activeflag = 1;

UPDATE intakedastaging 
SET activeflag = 0, updatedon = NOW(), updatedby = 'CJAMS-64546'
WHERE intakenumber IN ('I251013380037', 'I251013377294', 'I251013376509')
AND activeflag = 1;
