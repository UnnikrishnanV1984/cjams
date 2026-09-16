/*
  Issue Description: CDM-23303
   Category/ Module  :  permanency plan end date and update and deleted
   Root cause: user asked to update it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update permanencyplan set enddate = '2022-06-07 00:00:00', updatedby = 'CDM-23303', updatedon = now() 
 where permanencyplanid in('1a3842aa-9ec4-4cde-950f-1789c379e71e','1633172a-7dbd-46f2-bd59-6dd90dd02f2f');
