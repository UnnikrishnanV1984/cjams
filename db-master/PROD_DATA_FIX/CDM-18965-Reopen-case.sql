/*
   Issue Description: CDM-18965
   Category/ Module  : User wants to reopen a case
   Root cause:userfilled it by mistake
   Pull request# for code fix: 
   Explanantion: user wants to reopen a case and remove the exisiting case
*/

update servicecasedisposition 
        set activeflag = 0,updatedon = now(), updatedby = 'CDM-18965'
        where servicecasedispositionid  = '90f7b673-26da-4732-8b1a-65edbb04cee7'
        and servicecaseid  = '50daf6f2-0a85-4b32-ac40-b01f33da6e75';

update personprogramarea 
        set enddate = null ,updatedon = now(), updatedby = 'CDM-18965'
        where personid  =  '3357e4f8-a0d7-46f2-a0bf-5472545ed8ac'
        and personprogramid = 'df6c1314-ec6d-4215-a7be-963e405282bb';

