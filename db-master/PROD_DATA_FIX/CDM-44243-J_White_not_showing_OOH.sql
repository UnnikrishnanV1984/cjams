/*
  Issue Description:  CDM-44243
   Category/ Module  :Pragram assignment
   Root cause: Incorrect case number got linked to OOH program.
   Pull request# for code fix: 
   Reason why no related code fix:Could not reproduce this issue in stage 3 and local. 
*/


update personprogramarea 
set objectid='b6243aba-3634-4030-82fb-0a042cdbd336',
    entityid='3268183',
    updatedon=now(),
    updatedby ='CDM-44243'
where personprogramid ='e4beab20-db16-43c7-9fc0-f6777d524fe1' and activeflag = 1;