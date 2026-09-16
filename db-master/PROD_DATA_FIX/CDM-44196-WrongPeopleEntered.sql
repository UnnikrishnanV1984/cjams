/*
Issue Description: SSA approved on 02/11/2025 and please proceed with the data fix to delete/remove those three client from the CPS-AR : 251022992054.
Category/Module: Use Error
Root cause:  User can enter only person daetils but user can not remove person details in person tab.
Fix provided: DB queries to update  record in actor  and intakeservicerequestactor ,personrole table.
Data/Code fix ticket#: CDM-44115
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Use error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/
--update actor
update actor
set activeflag = 0, updatedby = 'CDM-44196', updatedon = now()
where  actorid in ('f7924c34-372b-476d-8177-dc62bc0a3017','b956dedf-8e41-486a-8087-af9b24b87098','35045474-3a15-4c9a-be90-f5f5c3b832f9') and activeflag =1;

--update personrole
update personrole
set activeflag = 0, updatedby = 'CDM-44196', updatedon = now()
where  personroleid in ('e98f2748-4db4-470d-b80c-2c6fb8be952a', 'c462d6a5-bc34-4e6b-82b6-49ea188e48c7','3d9d9784-6f84-491f-84cd-125e6b16fada') and activeflag =1;


--update intakeservicerequestactor
update intakeservicerequestactor
set activeflag = 0, updatedby = 'CDM-44196', updatedon = now()
where  intakeservicerequestactorid in  ('b4740b14-ed1a-4ba0-ad18-830653cd1bb7','2b62b878-3d5a-465c-8a36-8256becce882','c4ffbc07-5fac-4a71-b5a4-fe857ff852fe') and activeflag =1;

--update personprogramarea
update personprogramarea
set activeflag = 0, updatedby = 'CDM-44196', updatedon = now()
where  personprogramid in  ('fc7708a8-3395-4ba2-84e1-1c828b6904af','102faf42-4aba-4c3a-bea8-ab772ec120db','9de63a4c-1b81-42a2-8d35-4a3926b8d639') and activeflag =1;

--udate actorrelationship
update actorrelationship
set activeflag = 0,updatedby = 'CDM-44196', updatedon = now()
where actorrelationshipid in (
'7a4b4f12-9964-484f-b450-3e417f673514',
'8001436e-95b9-4f15-b3fc-91f283489f6e',
'fca27b1f-614d-4f22-96f8-f8b0dbac4d0e',
'8bb98663-df74-48b3-92cb-d5e26752a343',
'd0dffafe-99a8-4de1-99f0-82b70caadf07',
'67b69061-fcf6-46fe-a8ec-e13973d76a39',
'62c340f1-eb22-463a-98d6-d90137b60ad3',
'0cf16528-cfb6-4bcd-8cf2-a6ea889a02f4',
'9c81f7e6-a963-48dc-b3c3-73eb2c5e4d82',
'1e8336e4-b182-41ae-afbd-6536855a436e',
'b049fbea-92a6-4caf-939c-f7d4f5e3b6be',
'2fcb2be5-9798-4163-86f0-45898c7419ae',
'8812bc67-5020-418c-a844-abdb766f5d04',
'1fcfaefa-039c-4d3e-b56b-d4a796b5eb39',
'07e6ca7e-0838-46db-a400-4160faee4683',
'08f29705-83f8-42f2-89f7-8e84d1cf21fe',
'7116156d-3591-43b3-a9dd-372107e68c3a',
'6dd0b976-3c87-427c-8dd6-8fd637532e3d',
'80bd6a6f-6d8e-4bc5-99b3-ea20a4122a59',
'd7601de2-8ddf-4cc3-b878-c75e12ba0346',
'598475e7-9653-4656-90ea-7b000529e3bb',
'e248a354-73c2-4fd5-8177-6cf824abca32',
'd0dffafe-99a8-4de1-99f0-82b70caadf07',
'56c3c8e8-f8a0-45af-9077-0f6945bf3ddf',
'80dbcfe7-8190-4ae6-b32f-075a1121bd8a',
'bd17ffa3-1299-461b-8a3f-90b469b3b23b',
'acd70a5c-1e1e-423f-982e-6f582237d0a3',
'1e5b68e8-cd75-490f-bd86-c0e8654934ed',
'f74d26ce-a416-41c7-b70a-a6264950061c',
'2a67e075-d0b1-4750-a839-cd91e1697a93',
'c96e307a-3cf8-438c-94df-ea842dd7340c',
'637959df-dccf-4423-86a4-88401c3416f0',
'10fcdee1-6598-40f2-bec7-9bc50fe7a9af',
'5f2f7025-7502-4f98-bc7b-1665351af021',
'b049fbea-92a6-4caf-939c-f7d4f5e3b6be',
'7116156d-3591-43b3-a9dd-372107e68c3a',
'd55967a4-b9b8-405d-b1bc-f77a3cfca665',
'1527c49d-26f1-433e-bc2b-64687593d093',
'd9123985-bfc5-4ba6-9ff1-a21e43730bb5',
'5725ee98-e89b-4397-97ea-4ba7c1660ce7',
'087df4a3-9925-445a-8da6-9822bfad1938',
'ff27be76-7db8-42bd-a87b-931b71a0f887',
'07e6ca7e-0838-46db-a400-4160faee4683',
'598475e7-9653-4656-90ea-7b000529e3bb',
'f74d26ce-a416-41c7-b70a-a6264950061c',
'67b69061-fcf6-46fe-a8ec-e13973d76a39',
'1e8336e4-b182-41ae-afbd-6536855a436e',
'6a1a5df8-b195-4769-b10a-f21f576ae688',
'27051e24-f3c5-4d4e-952b-b65a430ca1fa',
'd55967a4-b9b8-405d-b1bc-f77a3cfca665',
'f5408a61-bbb2-41ce-ab29-de564d7cf2fb',
'a14d480a-e5f8-4c04-890b-2ba748388130',
'8db06521-324e-4a6b-a1d3-0c3c5e265c0b'
) and activeflag = 1;