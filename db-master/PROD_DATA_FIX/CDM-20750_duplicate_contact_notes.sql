/*
   Issue Description: CDM-20750
   Category/ Module  : Contact notes
   Root cause: user asked to remove duplicate contact notes
*/

UPDATE progressnote 
SET activeflag = 0, updatedby = 'CDM-20750', updatedon = now() 
WHERE progressnoteid in ('83e59980-1aeb-408f-82b6-e678f027f935');

UPDATE progressnotedetail 
SET activeflag  = 0, updatedby = 'CDM-20750', updatedon = now()
WHERE progressnoteid in ('83e59980-1aeb-408f-82b6-e678f027f935');