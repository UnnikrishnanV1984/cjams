/*
   Issue Description: CDM-29108
   Category/ Module  : Contact notes
   Root cause: user wants to delete the contact note
*/


update
    ProgressNote
set
    activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-29108'
where
    progressnoteid = 'a9324f70-88f7-4e21-830d-e096efc23d76';

update
    progressnotedetail
set
    activeflag = 0,
    updatedon = now(),
    updatedby = 'CDM-29108'
where
    progressnotedetailid = 'cfe583b1-a2ab-42f9-899f-8d9f175b8c16';