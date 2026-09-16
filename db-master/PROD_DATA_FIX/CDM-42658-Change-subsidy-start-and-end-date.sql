/*
   Issue Description: CDM-42658
   Category/ Module  :  Gap agreemnet
   Root cause: user wants to  update the subsidy start and end dates.
   Pull request# for data fix:
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: Need data fix
*/


update gapagreementrate
set startdate='2024-11-18 01:00:00', enddate='2025-11-17 01:00:00', updatedby = 'CDM-42658', updatedon = now() 
where gapagreementrateid = '3edf84ea-47f7-4fa5-bd86-63c8f0e2eb29' and activeflag=1;

update gapratesrevision
set approvaldate = now(), ratestartdate='2024-11-18 01:00:00', rateenddate='2025-11-17 01:00:00', updatedby = 'CDM-42658', updatedon = now() 
where gaprateid = '3edf84ea-47f7-4fa5-bd86-63c8f0e2eb29' and activeflag=1;
