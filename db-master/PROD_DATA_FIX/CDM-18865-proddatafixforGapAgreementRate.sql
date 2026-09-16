
/*
   Issue Description: CDM-18865
   Category/ Module  : Updating gap Start date and end date
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


-- 2020-06-22 04:00:00
update gapagreement set startdate = '2021-06-22 04:00:00', updatedon = now(), updatedby = 'CDM-18865' where gapagreementid = 'c142a61d-b81c-4a55-93a4-8dd21b84fe4f';
update gapagreementrevision set startdate = '2021-06-22 04:00:00',approvaldate =  now() , updatedon = now(), updatedby = 'CDM-18865' where gapagreementid = 'c142a61d-b81c-4a55-93a4-8dd21b84fe4f';


-- 2021-06-21 04:00:00
update gapagreementrate set enddate = '2022-06-21 04:00:00', updatedon = now(), updatedby = 'CDM-18865' where gapagreementid = 'c142a61d-b81c-4a55-93a4-8dd21b84fe4f';
update gapratesrevision set rateenddate = '2022-06-21 04:00:00',approvaldate = now() , updatedon = now(), updatedby = 'CDM-18865' where gaprateid = '66a6440d-acc5-4cba-8f28-0567416c9268';

