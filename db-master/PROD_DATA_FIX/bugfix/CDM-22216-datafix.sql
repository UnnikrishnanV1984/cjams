/*
   Issue Description: CDM-22216
   Category/ Module  :  User wanted to update the latest notes 
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

SELECT * FROM progressnotedetail
where   progressnotedetailid ='201921d5-5d91-408d-938a-e71e3c2bfcbd'
        and ProgressNoteId = 'd5c96854-60b2-4320-92c9-9be698ad5a05' AND activeflag=1;

/*
    table audit columns are not updating since it will mess up the order of notes and the contact details
*/
update  progressnotedetail 
set     description = '<p>Ms. Bateman asked this worker how to spell the middle names for the birth certificates.  Worker found this concerning and notified Worker Orjuela.  At the time, Ms. Bateman did not appear to be under the influence of drugs or alcohol.   </p>'
where   progressnotedetailid ='201921d5-5d91-408d-938a-e71e3c2bfcbd'
        and ProgressNoteId = 'd5c96854-60b2-4320-92c9-9be698ad5a05' AND activeflag=1;