
/*
   Issue Description: CDM-33261
   Category/ Module  : Updating gap Start date and end date
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/



 -- 2021-07-26 08:00:00
 update gapagreement set startdate = '2023-05-12 08:00:00',
 updatedon = now(), updatedby = 'CDM-33261'
 where gapagreementid = '304f83d5-9486-4801-9edd-30b26c31402f';

-- 2021-07-26 08:00:00
update gapagreementrevision set startdate = '2023-05-12 08:00:00',
updatedon = now(), updatedby = 'CDM-33261'
where gapagreementid = '304f83d5-9486-4801-9edd-30b26c31402f';
