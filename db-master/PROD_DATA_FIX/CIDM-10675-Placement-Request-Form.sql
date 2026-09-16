/*
Issue Description: CIDM-10675 Placement Error
Category/Module: Placement Request Form
Root cause: The phone number was saved in a different format not accepted by application. 
Fix provided: Data fix has been done to change the format of the phone number.
Data/Code fix ticket#:CIDM-10675
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: CIDM-10675
Reason why no related code fix: N/A
*/


UPDATE userprofilephonenumber
SET 
    phonenumber = '4103863418',
    updatedby = 'CIDM-10675',
    updatedon = now()
WHERE 
    securityusersid = 'b9ff2e8f-ef5d-4991-8d30-3bf54a144933';