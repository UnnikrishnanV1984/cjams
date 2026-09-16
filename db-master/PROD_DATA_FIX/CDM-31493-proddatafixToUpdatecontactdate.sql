/*
   Issue Description: CDM-31493
   Category/ Module  : Prod data fix to update contact date
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


-- 2023-05-19 00:00:00
update progressnote set contactdate = '2023-05-12 00:00:00', updatedby = 'CDM-31493', updatedon = now()
where progressnoteid = 'ede4ca5f-e9bf-42bc-9dbd-36fdfeba2ad5';
