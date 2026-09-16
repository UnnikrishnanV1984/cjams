/*
   Issue Description: CDM-36094
   Category/ Module  : Contact notes
   Root cause: user wants to delete contact notes as it was entered on incorrect case.
   Fix Provided: Data Fix  to soft deleted the  contact note ID # 12058846 as per the user request
*/


select *from progressnote where progressnoteid='b9b83631-c6ab-4211-a1d1-d1d2f8b08ee8' and activeflag=1;

update progressnote set activeflag = 0, updatedon = now(), updatedby = 'CDM-36094' 
where progressnoteid = 'b9b83631-c6ab-4211-a1d1-d1d2f8b08ee8'and activeflag  = 1;


select *from progressnotedetail where progressnoteid='b9b83631-c6ab-4211-a1d1-d1d2f8b08ee8' and activeflag=1;

update progressnotedetail set activeflag  = 0, updatedon = now(), updatedby = 'CDM-36094'
where progressnoteid = 'b9b83631-c6ab-4211-a1d1-d1d2f8b08ee8' and activeflag  = 1;