
/*
Issue Description:  the case connection on CPS IR 251022986216 and service case # 3274720. Make sure all documents from CPS IR 251022986216 are removed from the service case.
Category/Module: Bug
Root cause: user can  able case but  not  able to change case.
Fix provided: DB queries to nullservicecase in intakeservicerequestactor
Data/Code fix ticket#: CJAMS-58018
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/
--step1
update intakeservicerequest 
set servicecaseid = null, updatedby = 'CJAMS-58018', updatedon = now()
where intakeserviceid = '3fd25ca2-5d4f-471f-a0a0-4db01c71b79a' and activeflag = 1;



update actor
set activeflag = 0 ,updatedby = 'CJAMS-58018', updatedon = now()
where actorid in (
'00a6e6e6-9fe4-4a4b-8d2c-57bf50944a3f',
'246aef3f-67da-4754-8535-39f2b4b5419a',
'37ce2976-59c8-44b3-92b8-d99e1c7fe022',
'50855778-e699-46fb-9164-4d889955199a',
'8faa92cc-98ff-4185-a9ac-6f5e72abc02c',
'bbc89462-ca01-44f4-9a4a-0e86cdf62e69',
'e571289b-ba22-4049-a464-e8db004fb2a3'
) and activeflag =1;


update  intakeservicerequestactor
set activeflag = 0 ,updatedby = 'CJAMS-58018', updatedon = now()
where intakeservicerequestactorid in (
'4e493225-d913-4bdd-b820-11d0f46901df',
'9181d63e-c551-4735-953c-0baf119a2889',
'5303ea49-1de0-474e-9379-7fc7151666d5',
'd6c52e2f-179a-4272-9b9d-19ea1236c61a',
'05c0697d-ca03-450c-994d-fb72193c49a6',
'4465502a-322c-4b94-9908-e9431fc8bd7f',
'fa8a9d5f-c878-4118-be87-8c97229591f9',
'e475608e-a6ed-4ec2-a4c2-d7dc384a9632',
'9202fec7-21e0-49ae-9892-9c1ff6d342a6',
'960a55d7-bb97-4f36-8e34-b0aef30ae075',
'af119c8d-3ee3-43c0-94b3-0bc7d5c3cd94',
'd0999909-8d75-49ae-9938-d76cee04c367',
'f1580857-2a7b-4978-93db-281f88634646',
'430b4297-3dce-46b6-9618-dea7606f0b15'
) and activeflag =1;


update actorrelationship
set activeflag = 0 ,updatedby = 'CJAMS-58018', updatedon = now()
where actorrelationshipid  in (
'e6dd9a9e-afa3-4a37-bdfc-e9751eeb0879',
'5a187338-ac41-4bd5-9fca-f7a2592bc731',
'420e1d14-d99a-4307-a502-c77dd33b1056',
'431549ee-0b86-4191-9ba7-326d62c5fadf',
'fca4c618-1ad0-467c-a0e1-d07a12ed0f80',
'c94fc3ad-03aa-4b75-ab15-c7f567a69105',
'3f207d95-3d8e-4772-b386-5119687a3033',
'8e72a4e0-6f72-490e-b08c-eb99e0b66da2',
'b42e608e-d868-4edb-a87b-3189cebe0584',
'25e91483-7172-4983-9cac-aba783ff9160',
'bf3e0b95-7054-46b8-8197-9c110414255f',
'350c9184-605f-44ef-9a42-183101b3baf8',
'e6c59400-ccb1-4943-a859-cb79c0d2fb41',
'1f16df75-0a76-4a88-8862-8a6030f6dc06',
'49ff211b-bc3c-4513-96a7-937baae8e672',
'8cf4a25a-c68f-4242-91d8-ac10c83842a1',
'1f014c3d-659c-476c-923a-af484d02d116',
'6b2671b8-943b-4e57-b6e2-f0e21f194fd1',
'405c52f0-dcf2-4278-9a6d-897568b47f28',
'af6a4376-ca8e-4bbe-815f-e17e18aa37b3',
'd5eafcb0-1b39-4706-b77a-924cad7e12d8',
'b7133f07-44c5-48e5-b632-ee47dc685e07',
'edca5c6c-d714-4f2c-bdc5-f25768b1f488',
'508c988b-87ec-4afc-8cc0-20250cd1ff61',
'd1a67842-a5e2-4fdb-bffb-ac7cd073d2e5',
'd8efb7ad-1127-41c6-85e9-3bd365655068',
'b761a9c0-2b37-4723-9566-b4de5b65838d',
'ac2dc403-e64e-4481-ae21-f3263f97f558',
'9710ff44-4af6-4656-b974-4b18df12c915',
'ed15f137-a334-4ef4-8f86-39d1c9564aa7',
'b0d5d8a1-03c8-4afd-bfff-d4bfcb5510ec',
'5784e313-53dc-4bb2-91ae-a802af052362',
'05409cb5-cfe6-43c5-8df0-aa6b8fee07f1',
'e1a4989e-fcc8-4ccb-b2f7-82e1cddd4b57',
'1a5c8299-17a2-429c-875c-a3ec8507f6ab',
'34c34795-7efc-4d9c-9177-f547bacf1efc',
'ee101d45-ef99-4829-a1db-6ba51d6e3dcc',
'1173ab66-5f0e-4dc3-9315-f5cfabcdd5e3',
'c7273078-b7cc-41ae-9321-a02622ca7bb5',
'3d46ef72-2477-4b80-b8c0-0af062a91b73',
'cc8891de-6dcc-4d2b-9ae1-7da7c676fe63',
'1e860e66-b9be-4106-91a4-40c91970869d',
'ecda7efa-06f8-46bf-815d-d224feffc37f',
'e67998dc-3a46-482e-9d85-e9ac16c82e7e',
'96362f7b-8702-42c2-914b-06dfad0479e8',
'20dbd1aa-e053-4e66-96ef-055c0ab6b25f',
'17ed9f91-f54c-4da2-b1f3-cb4c4fa6beb1',
'7a5281bc-c0d8-4125-8c2c-5baf460f780e',
'cc2c2778-df8d-4452-bed3-575462a67d99',
'260d1eda-0840-416a-8a96-1d7322c67227',
'ad689f39-6160-47e8-b9f9-04939f415c42',
'4254620b-c9f3-42b7-bfcf-ffddfb7f0f50',
'2021154e-d64a-49e7-bc04-b4c5621d2ef0',
'a620b8c4-b4e9-4bec-b566-2adc3365cd3f',
'b538e49c-06fc-4fe8-858b-53c1825f97d0',
'ac78befa-5b13-4f7c-b5da-09923267c63b',
'f1931dd4-5245-4e31-aa4c-117b04945eeb',
'b0d86fd1-299f-47a4-a9ef-cd6ad31ea046',
'dc42ad6a-deef-4ed2-85f6-c061dfa50762',
'25a12a02-8d8e-4b8f-86e6-4004d96fc399',
'97c353ff-c9e9-4c6b-abd1-ec1b80157882',
'8b4402c3-345f-46a1-b991-3e3675b52200',
'e8219d00-5285-40ac-9179-c93b6a38748f',
'06fc8ce9-d08d-4375-bcbb-8f6fd8806894',
'10ffa880-0049-4c66-9a5a-252640a12679',
'1157c8fd-8581-4d22-9d13-1d1ac7e45b84',
'54e91257-5c00-4752-90a4-402b185b276e',
'50138997-4bda-4349-bd0c-ce3c9ac8d1fb',
'fdfdc850-6d9a-43f4-ab31-1bce38b59dc0',
'95c9502f-59e7-4d54-9085-63e2aeab4de3',
'dd80e6a6-2a58-4dbd-abfa-acdd784fe99f',
'36719e70-5de0-4097-b21b-206995edbfb1',
'da572720-a332-4171-bcea-44d558cd4365',
'ca4e0e3f-2f07-4172-a065-6c7ccd22e52d',
'2117eede-3d8e-4f89-82b8-a8028c2fc67e',
'1cba87c1-91de-4b1f-bedc-5594bdcdf238',
'89db29cf-e4bf-42e1-a443-1e3d157d357d',
'5b10e085-17b2-48dd-a352-a9028862a5f3',
'd94a6b5b-3add-4b27-a9a3-4c470f7eb47b',
'6ee28466-f6be-4734-b700-13908ed3d51c',
'c2fd6988-23f3-4681-8c39-56d07f6b36df',
'006beb35-7e48-470c-8e52-c87502f99859'
) and activeflag =1 ;


update personrole
set activeflag = 0 ,updatedby = 'CJAMS-58018', updatedon = now()
where personroleid in (
'bd138e3d-0f57-4b25-8f9f-d3597f4051aa',
'bfbeb1fc-97af-4fa6-a1b4-00215fac5e11',
'eddd9ea9-86c6-43b3-a84a-63e9dd54229c',
'a56b0d9a-93bf-420d-89c9-9a3d269e6b3c',
'1c1f6ea0-2ebc-4b02-9f34-85e2239ac073',
'e5c6ed96-9eb0-4af5-a7c2-a4b7b91ea256',
'149495ea-1452-4bd5-9331-5187e52b9436',
'8ad26e6c-8779-495c-90f8-7e6f8f111253',
'1222bfdf-c8fe-4e53-a247-d08d1d0c150f',
'7e82cbd6-c676-4053-a4b3-19d0823dfd63'
) and servicecaseid = '5fbf8d5a-cbc7-480b-930b-1372b0eba96c' and activeflag =1; 


update personroletype
set activeflag =0 ,updatedby = 'CJAMS-58018', updatedon = now()
where personroletypeid in (
'ad87bb70-70f9-44c4-ba5c-9217ce322177',
'3665ba90-6d30-4ece-9249-3b388db47ca5',
'b449f99d-0ffa-461d-88f1-c9b1be60fba0',
'67cb96d3-989c-40a3-8948-c0e8967af72d',
'63c3e0e5-3743-46e9-a8fe-65eced613a9f',
'651f5ff6-1b25-43c8-a57e-88102288e18a',
'672b5dea-a74a-4370-b7dc-9deec1b04ad1',
'edceb278-f97f-45ad-a58c-f2510183597e',
'e15808db-d144-4ad5-ac15-a70593d1a41a',
'0fff4d6a-687b-4ad6-bab1-da50ce38fb20',
'c84e33a8-6379-4953-b48b-ce2e6ede5328',
'4b114e8c-53b9-414d-aed4-00b9bb288fb6',
'6abc6f5b-8dd4-4f24-8c0b-c2b882b5bb95',
'a3ea3740-7fd7-4cc7-b45b-19a845094574',
'074f3ce1-abf4-40a9-9b8c-c668a4d6af1c',
'2dbcaa49-bb34-466b-97a5-644d89c90ab9',
'c35079c2-8577-4d62-ad5d-9287b0b70a85',
'd9c676a8-6cbe-48ca-a016-2aff12414d05'
) and activeflag =1; 



update documentproperties
set activeflag =0 ,updatedby = 'CJAMS-58018', updatedon = now()
where documentpropertiesid in ('d1cb0f01-10bb-47ab-94e2-9a9430be3370','b15b5e77-2948-4bb6-9429-5038b50b036f',
'c4c9eb6b-ce3c-48a6-a30c-21db12377cc8') and activeflag =1;
