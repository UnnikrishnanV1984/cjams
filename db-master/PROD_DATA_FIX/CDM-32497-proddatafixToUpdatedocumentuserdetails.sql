/*
   Issue Description: CDM-32497
   Category/ Module  : Prod data fix to update document user details
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/




--384ebf8f-20af-45be-9043-aa942ef98551
--f07a0291-ad55-474f-8558-8d5ae62f5eae
--bb732146-eb75-464e-83d9-bbb7680c328e
--c5e0a74b-8f3c-4804-8ec7-af7038043f3f
--adefc97d-1989-4c9a-a292-c69f34499c81
--2ff6613d-5f45-4ed7-9153-b51d3a9e2472
update documentproperties set insertedby = 'd89df45b-9f7b-4334-b8a5-d21598d6dd56', updatedby = 'CDM-32497'
where documentpropertiesid in ('ab008f38-31d5-419d-a861-7d266c37d26b',
'61f8fa2a-9798-42de-80ad-57c762fe8045','671c1df8-ee9f-4356-a1ee-29231979eb63','9d96e189-acfb-476d-9d14-060af34f8fd5',
'2322ee32-cea0-433e-b97e-5fafbe630e68','5838e21e-ed52-48e6-b429-02d175329a6f'
);


--384ebf8f-20af-45be-9043-aa942ef98551
--f07a0291-ad55-474f-8558-8d5ae62f5eae
--bb732146-eb75-464e-83d9-bbb7680c328e
--c5e0a74b-8f3c-4804-8ec7-af7038043f3f
--adefc97d-1989-4c9a-a292-c69f34499c81
--2ff6613d-5f45-4ed7-9153-b51d3a9e2472
update documentattachment set insertedby = 'd89df45b-9f7b-4334-b8a5-d21598d6dd56', updatedby = 'CDM-32497'
where documentpropertiesid in ('ab008f38-31d5-419d-a861-7d266c37d26b',
'61f8fa2a-9798-42de-80ad-57c762fe8045','671c1df8-ee9f-4356-a1ee-29231979eb63','9d96e189-acfb-476d-9d14-060af34f8fd5',
'2322ee32-cea0-433e-b97e-5fafbe630e68','5838e21e-ed52-48e6-b429-02d175329a6f'
);