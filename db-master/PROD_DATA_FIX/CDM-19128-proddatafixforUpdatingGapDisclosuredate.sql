
/*
   Issue Description: CDM-19218
   Category/ Module  : GAP disclosure start date
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

-- 2021-07-28 04:00:00
update gapdisclosure set disclosuredate = '2021-10-25 04:00:00', updatedby = 'CDM-19218', updatedon = now() where gapdisclosureid = '3e1810a4-1c65-4ea6-a261-3e371e97ca34';
         