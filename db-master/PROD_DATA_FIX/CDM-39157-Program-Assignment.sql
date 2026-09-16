/* 
   Issue Description: CDM-39157
   Category/ Module  : SDM
   Root cause: Needs a datafix for all members with a CPS with an end date.
   Pull request# for code fix: N/A
   Reason why no related code fix: N/A
   Status of the code fix if already submitted and expected prod fix date: N/A
    
*/




/* Query for end date for Person 1*/

update personprogramarea
set enddate='2023-04-11',updatedby='CDM-39157',updatedon=now()
where personid='62e40b9c-5eaa-47eb-9fdb-8b9b2c3b4186'
and personprogramid='620aef50-74eb-42e6-905b-31144c844e46';

/* Query for end date for Person 2*/

update personprogramarea
set enddate='2023-04-11',updatedby='CDM-39157',updatedon=now()
where personid='b99c9263-1eb1-4a38-afad-b418035e6256'
and personprogramid='4ad78c00-6e9c-4d18-9ae8-3c6e4abca645';

/* Query for end date for Person 3*/

update personprogramarea
set enddate='2023-04-11',updatedby='CDM-39157',updatedon=now()
where personid='c5271305-324a-4f40-b47a-19612bd60814'
and personprogramid='d240ac64-9ad2-40c2-8336-cf1b698d58ab';


