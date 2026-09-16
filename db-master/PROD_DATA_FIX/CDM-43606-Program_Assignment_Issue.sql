/*
  Issue Description:  CDM-43606
   Category/ Module  :  Program Assignment
   Root cause: Person program assignment ended without child removal end.
   Pull request# for code fix:
   Reason why no related code fix: 
*/


update personprogramarea set enddate = null, updatedon = now(),updatedby ='CDM-43606'
where personprogramid ='a563b69d-37a3-4999-b1fd-1978173cb2f8'