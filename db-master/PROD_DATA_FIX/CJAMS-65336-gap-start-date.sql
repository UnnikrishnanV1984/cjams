/*
   Issue Description: CJAMS-65336
   Category/ Module  : Updating gap Start date and end date
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update gapagreementrate
set startdate='2025-10-08', enddate ='2026-10-7' , updatedby = 'CJAMS-65336', updatedon = now()
where gapagreementrateid ='a73794b0-37aa-43a5-a304-a5fb5f4d5a48' and activeflag = 1;

update gapagreementrate
set  enddate ='2025-10-7' , updatedby = 'CJAMS-65336', updatedon = now()
where gapagreementrateid ='3ec15f46-b8b9-442d-8dea-11ba1621e817' and activeflag = 1;

update gapratesrevision
set ratestartdate ='2025-10-08', rateenddate  ='2026-10-7' , updatedby = 'CJAMS-65336', updatedon = now()
where gaprateid in ('a73794b0-37aa-43a5-a304-a5fb5f4d5a48')
and activeflag = 1;


update gapratesrevision
set  rateenddate  ='2025-10-7' , updatedby = 'CJAMS-65336', updatedon = now()
where gaprateid in ('3ec15f46-b8b9-442d-8dea-11ba1621e817')
and activeflag = 1;