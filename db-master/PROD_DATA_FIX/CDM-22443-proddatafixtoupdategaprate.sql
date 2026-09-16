/*
   Issue Description: CDM-22443
   Category/ Module  : Prod data fix To update gap rate
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


-- 2022-03-18 08:00:00.000
update gapagreement set startdate = '2022-03-16 08:00:00.000', updatedby = 'CDM-22443', updatedon = now() 
where gapagreementid = '5cf9653c-f129-445a-81b5-59feffc959a5';

-- 2022-03-18 08:00:00.000
update gapagreementrevision set startdate = '2022-03-16 08:00:00.000', updatedby = 'CDM-22443', updatedon = now() 
where gapagreementid = '5cf9653c-f129-445a-81b5-59feffc959a5';


-- 2023-03-15 04:00:00.000 33.66 
update gapagreementrate set  enddate = '2023-02-28 05:00:00.000', paymentamout = '1024',
updatedon = now(), updatedby = 'CDM-22443' where gapagreementrateid = '3ebd9fd4-3658-4f5c-b607-d33b814e4f48';
update gapratesrevision set rateenddate  = '2023-02-28 05:00:00.000', paymentamt = '1024',approvaldate =  now() , updatedon = now(), updatedby = 'CDM-22443' 
where gaprateid = '3ebd9fd4-3658-4f5c-b607-d33b814e4f48' and activeflag = 1;
