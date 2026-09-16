
/*
   Issue Description: CDM-19686
   Category/ Module  : Updating Gap Agreement Rate
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

-- 2022-02-16 00:00:00
update gapagreement set enddate = '2024-02-16 00:00:00', updatedon = now(), updatedby = 'CDM-19686' where gapagreementid = 'd69960a4-9894-4bd3-9edf-0855a8696d44';
update gapagreementrevision set enddate = '2024-02-16 00:00:00',approvaldate = now() , updatedon = now(), updatedby = 'CDM-19686' where gapagreementid = 'd69960a4-9894-4bd3-9edf-0855a8696d44' and activeflag = 1;
