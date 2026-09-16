
/*
Issue Description: CJAMS-68046 Intake No longer needed
Category/Module: Glitched Referral-Disappeared 
Root cause:I261014077280:Intake no longer needed. Duplicate of another referral's information
Fix provided: Data fix has been promoted to remove the intake referral I261014077280
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix: Data fix 
*/
select * from cw_transactions_dataclenup('INTKE', 'I261014077280', 'CJAMS-68046');