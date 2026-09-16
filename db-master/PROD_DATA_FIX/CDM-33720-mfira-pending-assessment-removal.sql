/*
   Issue Description: CDM-33720
   Category/ Module  : Dashboard
   Root cause: pending assessmnet in approval inbox
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/ 
update routing set activeflag =0,updatedby ='CDM-33720' ,updatedon =now() 
where routingid in ('c3c991dc-1bff-415c-9f38-e29ea1cecdb7',
'66f04be5-a5ec-45f2-ad12-7de4f2ab2d88','389fcc3c-db05-4b9f-81a6-0145c5237a52',
'd8b4b4e4-b25c-45de-8ccf-7bf7e6545406','05b5b279-5128-4857-83c5-a9731ac84f57',
'56b3dd66-ec2d-4274-b6c3-9b15c53abbee');
