/*
Issue: Program Manager's Approval Box - Service Logs
Root cause: Not a defect ,Requested to reassign the Purchase Authorizations Terri Alston's individually assigned service logs from her individual Program Manager Approval Box to the Role Based Program Manager Approval Box so all Program mangers  will be able to approved it.
Fix provided: Data fix has been done to reassign the Purchase Authorizations to Role Based Program Manager Approval Box
Data/Code fix ticket#: CJAMS-69316
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support
*/

---We are not updating for few records since they are not searchable In UI and are updated by migration purchase authorization
update routing set eventcode = 'PCAUTHR',tosecurityusersid = null, updatedby='CJAMS-69316',updatedon=now()
where routingid in ('f1d78baa-7228-4613-8b0c-9c74220aa2df',
'14f6865a-5707-4d8e-9b64-d8f25d2bb45a',
'5b3b39eb-8c1e-4b9b-8087-34edb16c7b27',
'e793c388-be89-44ab-b437-1cbe3b7559c9',
'd89e9d9d-8c86-4546-8b1e-fc39e8dbb594',
'7b121dae-e97c-40ca-bf5e-55a51408adf2',
'74599809-a160-4bc6-90ed-3ccf5d4385ca',
'd9dfd7e7-0e95-4b9a-ae9e-c179a8607995',
'c6e59d0a-6051-46e5-8529-fa2ae1730460',
'4ba143da-d9eb-4228-9af5-f9735160c688',
'c47b3ae2-13e3-4dd3-818d-278f77b47170',
'e406e339-6db4-45a3-ac0b-97c618628811',
'0a2c0bbf-1e65-46b1-bd50-11bfe5371f56',
'3df152db-f3ca-4bd1-8a4c-2e206f6d67c5',
'f451fd99-f219-477d-98b5-589f83c51968') and activeflag=1 and toroleid='LDSSPM';

