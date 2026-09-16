/*
   Issue Description: CDM-23520
   Category/ Module  : Approval Inbox - Need to update activeflag=0 from activeflag=1
   Root cause: User don't want to see Approved records in approval inbox since they got stuck in approval inbox so we are updating the
   Pull request# for code fix: 5817
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Need to do data fix
*/

update routing set activeflag =0, updatedby = 'CDM-23520', updatedon = now() 
where routingid in ('673f9ef5-dd54-4099-aa2c-eac4d5f7af33',
'd7a10a46-ea8e-4328-816e-dac33016b70f',
'bd653096-e004-4b72-9826-cbd1349c6683',
'06c815a3-f64f-4aa7-a46b-84391d5892c2',
'2b74e3a7-d8d5-4929-b863-b5eab7dad6bb',
'195088ae-08b3-454d-a069-768cc68c7245',
'9b301e7c-af15-4d3f-ae95-7c76e0498167',
'14a7826d-c91e-4933-97e3-5a5dcf8c8610',
'7a1450c9-d2a1-4c3e-ac08-ba5b6267416b',
'82ea2e2c-2f18-40fd-96eb-db6be75df54e',
'b155bf69-c021-4748-b8ed-bc66e2501d9b',
'c3a02ece-bbf9-4632-9fd2-1d25ecf4b9f4',
'31d859c4-aec7-4970-a73e-d16b860d21c4',
'7b2d9f0d-53fd-498f-8d0e-bc3701249266',
'e923437b-5bc7-4b8e-a1bf-2dbf1ee85c9c',
'1e95f342-8c78-43a1-8b03-1a3ddf6f898d',
'afa1c3b8-6047-4de5-9727-4ef50ddf9945',
'708e92b8-35d2-4505-be37-d3848bcee768');