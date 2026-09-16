
 /* 
   Issue Description: CDM-30651-Program assignment did not close
   Category/ Module  :  Person
   Root cause: 
   Pull request# for code fix: N/A.
   Reason why no related code fix: N/A.
   Status of the code fix if already submitted and expected prod fix date: N/A 
*/
UPDATE cjams.personprogramarea
SET enddate='2021-08-09 12:30:35', updatedon=now(), updatedby='CDM-30651'
WHERE personprogramid='90702097-39d5-44ed-ba2b-8eb6df5e3e45' and personid='95e704d3-9893-4245-8e84-b5a13aa1adc8';

