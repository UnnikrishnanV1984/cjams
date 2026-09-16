/*
   Issue Description: CDM-39160- Assignment 
   Category/ Module  : Case Assignment
   Root cause: There is an existing family assignment which is not allowing to enddate with overlapping dates
   Fix Provided: Data fix to remove end date for case assignment
*/

update caseassignment
set updatedby='CDM-39160', updatedon=now(), enddate = '2024-04-30 09:19:37'
where caseassignmentid in ('a21577c3-c4ce-42b2-85c3-a8801e8a2c5c','52d27db9-5e5f-4e77-b9da-5218934395f3');