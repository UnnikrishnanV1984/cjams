/*
   Issue Description: CDM-20123
   Category/ Module  : Contact notes
   Root cause: user wants to remove the duplicate contact notes
*/

UPDATE progressnote 
SET activeflag = 0, updatedby = 'CDM-20123' , updatedon = now()
WHERE progressnoteid = '4db5e99d-41be-43b0-b866-8b6ea46d067b';

UPDATE progressnotedetail 
SET activeflag  = 0, updatedby = 'CDM-20123' , updatedon = now()
WHERE progressnoteid = '4db5e99d-41be-43b0-b866-8b6ea46d067b';