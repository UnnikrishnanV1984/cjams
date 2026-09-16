/*
   Issue Description: CDM-14717
   Category/ Module  :  Updating the End date for Person program
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Program has been ended by 2020-08-13 09:42:07	RSV130603 in chessie
*/


-- 2020-08-13 09:42:01
update personprogramarea set enddate = null, updatedby = 'CDM-14717'  where personprogramid = '8b0e3237-babb-4a36-bfff-172f97333bf2';