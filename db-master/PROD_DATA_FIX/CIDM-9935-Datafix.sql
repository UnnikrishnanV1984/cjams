/*
  Issue Description: CIDM-9935
   Category/ Module  : County
   Root cause: In the finance tab all the counties were mapped to countyid
   Pull request# for code fix: NA
   Reason why no related code fix: NA
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: NA
*/

UPDATE csesclientsupportorder
SET socounty = a.countyid
FROM county a
WHERE a.countyname = socounty
  AND csesclientsupportorder.activeflag = 1
  AND socounty IS NOT NULL
  AND as_uuid_or_null(socounty::text) IS NULL;