/*
   Issue Description: CIDM-9543
   Category/ Module  : Case Assignment
   Root cause: Data fix for the old data to get self assigned to the supervisor who approved the case when no assignment done.
   Pull request# for code fix: 
   Reason why no related code fix:  
   Status of the code fix if already submitted and expected prod fix date: 
*/
-- Please run the caseselfassignment Proc before running this data fix
select * from caseselfassignment('CIDM-9543');