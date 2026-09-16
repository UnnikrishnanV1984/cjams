/*
Issue Description: 251023068972:Change the workers phone number to 410-371-4730. Please ensure the phone number remains 410-371-4730
Category/Module: Intake
Root cause: User requested to update the phone number from (443) 699-0145 to 410-371-4730 and we need a data fix for this issue.
Fix provided: Data fix has been to done to update the user phone number.
Data/Code fix ticket#:N/A
Regression Impacts: N/A
Is Code fix Required?: N/A
Code fix ticket#: N/A
Reason why no related code fix: User requested to update the phone number and data fix should resolve it.
*/


update userprofilephonenumber set phonenumber = '4103714730', updatedby = 'CJAMS-60815', updatedon = now() where userprofilephonenumberid = '18c8630f-758e-41df-ba10-95ea01c547d7' and securityusersid='22bb0feb-90b5-441b-aaa4-c70619674ccd';