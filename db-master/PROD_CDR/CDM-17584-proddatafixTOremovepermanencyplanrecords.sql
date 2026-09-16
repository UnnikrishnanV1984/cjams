 /*
  Issue Description: CDM-17584
   Category/ Module  :  permanency plan
   Root cause: user asked to update it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update permanencyplan set activeflag = 0, updatedby = 'CDM-17584', updatedon = now() where permanencyplanid in ('0e68c7da-60be-406c-a14b-bde25a6b69ce', '9982ee23-2cd4-4076-b66d-aeb40f45b99a',
'd9db12c7-391c-43b4-ba97-8d405ee48e26','00591126-3fde-4199-8ef1-e1310ea6d65e','7ee5de7d-fb4a-4500-b475-3f01012f5c33',
'a2ad19de-4ec6-458d-baa4-3b3bdd350c07','ccf701b8-39ce-4003-9539-6c9bab7c9781','7eccaf37-85b4-47c4-a7c9-5336d986da7d');
