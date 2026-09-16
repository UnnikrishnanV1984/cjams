/*
   Issue Description: CDM-18439
   Category/ Module  : OOH program end date
   Root cause: user wants to open OOH program assignment
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update personprogramarea p2  set enddate = null,updatedon =now(),updatedby ='CDM-19120'
where personprogramid  = '362badd2-d615-4f45-b0c1-dcd025b05290'
and activeflag  = 1;