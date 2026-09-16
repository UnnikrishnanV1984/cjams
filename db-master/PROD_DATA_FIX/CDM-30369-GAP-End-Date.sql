/*
   Issue Description: CDM-30369
   Category/ Module  : Permamnency plan tab
   Root cause: User requested to change GAP aggrement end date
   Pull request# for code fix:8686
   Reason why no related code fix: 
    requested a data fix to resolve
*/
update gapagreement set enddate = '2026-01-25 00:00:00', updatedon = now(), updatedby = 'CDM-30369' 
where gapagreementid = 'ebec41b8-7da2-4209-995f-735ae682015b';

update gapagreementrevision set enddate = '2026-01-25 00:00:00', updatedon = now(), 
updatedby = 'CDM-30369' where gapagreementid = 'ebec41b8-7da2-4209-995f-735ae682015b' and activeflag = 1;