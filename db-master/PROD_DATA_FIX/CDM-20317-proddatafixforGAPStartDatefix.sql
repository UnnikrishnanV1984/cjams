
/*
   Issue Description: CDM-20317
   Category/ Module  : Updating Gap Agreement Start Date
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update gapagreement set startdate = '2021-11-12 05:00:00', updatedon = now(), updatedby = 'CDM-20317' where gapagreementid = '81a9f068-a199-4545-be06-02e5ecf1012b';
update gapagreementrevision set startdate = '2021-11-12 05:00:00',approvaldate =  now() , updatedon = now(), updatedby = 'CDM-20317' where gapagreementid = '81a9f068-a199-4545-be06-02e5ecf1012b';
