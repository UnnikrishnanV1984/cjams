/*
Issue: Program Manager's Approval Box - Service Logs
Root cause: Not a defect ,Requested to reassign the Purchase Authorizations  Netricia Barnett's individually assigned service logs from her individual Program Manager Approval Box to the Role Based Program Manager Approval Box so all Program mangers  will be able to approved it.
Fix provided: Data fix has been done to reassign the Purchase Authorizations to Role Based Program Manager Approval Box
Data/Code fix ticket#: CJAMS-69320
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support
*/
update routing set eventcode = 'PCAUTHR',tosecurityusersid = null, updatedby='CJAMS-69320',updatedon=now()
where routingid in ('e2514b85-1ffe-4d70-92ee-e4b59d8d883f',
'5105711e-7fd0-4aa9-b31a-e80d3b08fdd6',
'50d51934-e9c1-44fe-8f09-aa2ac3e9cb0e',
'8736f644-abc7-46dc-b900-59ed5fa3f348',
'd81fa472-8ecd-42c3-be6c-4ee1b0b3f4cd',
'355bc90d-bdec-489b-a915-8b78138eae0c',
'c46b142b-de11-4d25-9cbb-74b2186e933c') and activeflag=1;