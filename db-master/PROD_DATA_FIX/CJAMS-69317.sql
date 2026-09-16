/*
Issue: Program Manager's Approval Box - Service Logs
Root cause: Not a defect ,Requested to reassign the Purchase Authorizations Janet Bridge's individually assigned service logs from her individual Program Manager Approval Box to the Role Based Program Manager Approval Box so all Program mangers  will be able to approved it.
Fix provided: Data fix has been done to reassign the Purchase Authorizations to Role Based Program Manager Approval Box
Data/Code fix ticket#: CJAMS-69317
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support
*/
update routing set eventcode = 'PCAUTHR',tosecurityusersid = null, updatedby='CJAMS-69317',updatedon=now()
where routingid in ('67527b23-c1a1-427f-9c8f-e87674a9b8b6',
'd7c8706c-6f6f-4004-b941-90270c580caf',
'50f5b973-ecb0-4a3e-90f7-6641641c63c3',
'58645f2f-50ac-4c7e-9418-1c053e4b9602',
'd8d8c3bd-9473-4127-aee8-744d8c5ed277',
'46cc7e10-176b-4601-a351-4214d40d4b4f',
'25757efb-e9c9-4741-81f2-2718b9497e4c',
'48f4fe8d-d28f-4e86-8faf-69275973d120',
'c0939ee5-9828-41bb-86b4-4620f5f974f5',
'097fcc15-8aed-4a71-ab30-d905df9c3c2b',
'c6c5d2a0-24bf-4993-98ee-21f0d6340599',
'a1286cb6-26b0-4b89-81b0-d478c5662c95',
'669bcc00-d0fb-438d-8274-dcba194bce30',
'a9dbb746-4e5b-4796-98af-82cf36f0a0f8') and toroleid='LDSSPM' and activeflag=1;