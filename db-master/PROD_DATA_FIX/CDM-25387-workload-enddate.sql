/*
   Issue Description: CDM-20181
         Category/ Module  : workload
   Root cause: case was appearing in workload even after closure
   Pull request# for code fix: 6451
  explanantion: user wants to remove
  */

UPDATE caseassignment 
SET enddate = '2022-09-09 00:00:00', updatedon = now(), updatedby = 'CDM-25387'
where caseassignmentid = '0a34edb6-f3b5-42bd-aba8-612b8eb2140e';