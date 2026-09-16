/*
Issue:Please remove the highlighted Permanency Plan and also need to remove the record from the Permanency Plan History
Root Cause: User requeste to delete  Permanency Plan and  History.
Fix Provided (Data Fix Only):Data fix was done by Updated intakeservreqchildremoval table.
Data/Code fix ticket#: CJAMS-62764
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/
update permanencyplan
set activeflag = 0, updatedby ='CJAMS-62764',updatedon =now()
where permanencyplanid in ('b9a350b6-40ca-46b3-874b-565c41ca15ff') and activeflag=1;

update permanencyplan_history
set activeflag = 0, updatedby ='CJAMS-62764',updatedon =now()
where permanencyplanhistoryid in 
('18c3d263-cc26-4dd6-b9fb-4c567af76177',
'cd7077d5-5a0a-4731-8764-5dede9171d2d',
'6cfa6681-842b-4731-8b9c-01bf9eefc64d',
'36b77088-9ad7-4a68-9448-18edeb76d74a',
'c1ec3cee-5162-41fe-a71c-3d8261d02304',
'95af22fe-7b15-4135-a734-961cb98de615',
'3c313143-ad79-4aaf-8461-7b02a09a348e',
'1756066e-6c99-4068-b632-9da9f32b4383',
'1eeaa05b-ea18-4630-be3b-13bd6cd93b1a',
'935b077c-3c02-450f-ac18-d931355f52f2',
'9ffc260f-4641-4949-9c42-7e05e5917a96',
'2704556a-14eb-4b38-92e5-4421d59b7c0f',
'ed0f7a89-a55c-4eb3-aa5f-735fed176ac9',
'3e158ebf-2179-4917-9e02-98e3b804314d',
'8de42271-ac96-4cb0-b428-4de1804f0616')  and activeflag=1;

