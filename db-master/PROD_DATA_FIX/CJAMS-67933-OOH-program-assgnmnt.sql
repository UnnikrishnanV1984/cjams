/*
   Issue Description: CJAMS-67933
   Category/ Module  : Chile  removal and OOH should be shown in this case - 261030666309 /for Lee David Gaskins (CJAMS PID# 204325390
 Need Investigation on why this kid is not showing correclty
 and child needs to  be removed from (231030152077
   Root cause: user wants to remove
   Pull request# for code fix: 
  explanantion:  user asked tp remove the clid removal record
*/

update personprogramarea
set updatedby='CJAMS-67933', updatedon=now(), objectid='ad2669f4-5f57-4a62-acf6-6c1fdeaa2b65', entityid='261030666309'
where personprogramid='2b8f8d34-f344-4e12-8819-222ea87d2da5' and activeflag = 1;



