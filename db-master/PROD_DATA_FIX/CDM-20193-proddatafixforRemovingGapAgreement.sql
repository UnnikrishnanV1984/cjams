
/*
   Issue Description: CDM-20193
   Category/ Module  : Updating Date of agreement end date
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

-- 2021-11-17 05:00:00
update gapagreement set enddate = '2022-11-17 05:00:00', updatedon = now(), updatedby = 'CDM-20193' where gapagreementid = '19fdab28-89a8-41d6-ba50-cd325de45273';
update gapagreementrevision set enddate = '2022-11-17 05:00:00',approvaldate = now() , updatedon = now(), updatedby = 'CDM-20193' where gapagreementid = '19fdab28-89a8-41d6-ba50-cd325de45273' and activeflag = 1;
