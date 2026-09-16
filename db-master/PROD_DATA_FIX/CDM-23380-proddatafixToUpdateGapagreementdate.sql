/*
   Issue Description: CDM-23380
   Category/ Module  : Prod data fix to data gap agreement end date
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


-- 2021-08-04 08:00:00
update gapagreement set enddate = '2022-02-04 05:00:00', updatedon = now(), updatedby = 'CDM-23380' where gapagreementid = 'e1c0bbb7-6bcd-4072-926d-d676865ca414';
update gapagreementrevision set enddate = '2022-02-04 05:00:00',approvaldate = now() , updatedon = now(), updatedby = 'CDM-23380'
where gapagreementid = 'e1c0bbb7-6bcd-4072-926d-d676865ca414' and activeflag = 1;
