/*
   Issue Description: CDM-43021
   Category/ Module  : END OOH Program Assignment
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/




update personprogramarea  
set enddate = '2024-11-29T04:00:00.000Z',updatedon =now(),updatedby ='CDM-43021'
where personprogramid in ('4b77cd2b-d132-466c-b1ab-9c10024379e6', '18fc911b-ad47-43c2-b1c6-c32c225ac9fd', 'fdf46981-3cc3-493e-9613-108b1bd47713')
and activeflag  = 1;

update personprogramarea  
set startdate  = '2024-11-29T04:00:00.000Z',updatedon =now(),updatedby ='CDM-43021'
where personprogramid in ('32ad3f2c-d169-4062-93a2-6190bf1f3835','6708276e-0e10-4373-8fce-7f98ece52d77','8d910626-6fd9-4578-b608-d4693a05f662')
and activeflag  = 1;


