
/*
   Issue Description: CDM-33362
   Category/ Module  : Updating gap Start date and end date
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/



 -- 2023-04-06 08:00:00
 update gapagreement set startdate = '2023-07-13 08:00:00',
 updatedon = now(), updatedby = 'CDM-33362'
 where gapagreementid = 'f186610f-76c0-49c1-86ec-d4ac4565f352';


update gapagreementrevision set startdate = '2023-07-13 08:00:00',
updatedon = now(), updatedby = 'CDM-18865'
where gapagreementid = 'f186610f-76c0-49c1-86ec-d4ac4565f352';
