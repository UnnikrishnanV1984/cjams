/*
   Issue Description: CJAMS-65879
   Category/ Module  :Assignments & Closure.
   Root cause: Requested to remove  the duplicate Program Assignment against Case# 251023072350, Client ID: 204154288 Client Name: D'Aris Fowlkes.
   Fix provided: Data fix is done to remove duplicate program assignment.
   Pull request# for code fix: na
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update personprogramarea
set activeflag =0,updatedby='CJAMS-65879',updatedon=now()
where personprogramid='c0eb7ac0-2a49-47a7-ab6d-46e6631a28af' and activeflag=1;