/*
Issue Description: CJAMS-64583 Incorrect GAP rate
Category/Module: Out-of-home
Root cause: User requested to update correct subsidy rate for the child
Fix provided: Data fix has been promoted to update the subsidy rate
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix: The issue is specific to data and is not a recurring one or a logical issue.
*/

UPDATE gapagreementrate 
SET paymentamout = 902, updatedon = NOW(), updatedby = 'CJAMS-64583'
WHERE gapagreementrateid ='e1bafd8a-e8f6-426a-8241-9fdc8b98364b'
AND activeflag = 1;

update gapratesrevision 
set approvaldate=now(), updatedon = now(), updatedby = 'CJAMS-64583' 
where gaprateid = 'e1bafd8a-e8f6-426a-8241-9fdc8b98364b';