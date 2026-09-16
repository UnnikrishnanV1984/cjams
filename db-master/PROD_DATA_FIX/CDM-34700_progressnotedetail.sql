/* 
   Issue Description: CDM-34700
   Category/ Module  : Progress Note Addendum
   Root cause: Insertedby column was null. 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/

UPDATE cjams.progressnotedetail
SET insertedby='322e01f4-f387-4208-b8b8-f25a3a32b1db', updatedby='CDM-34700', updatedon=now()
WHERE progressnotedetailid='f44c8e19-433f-4066-8241-7edecf32192e' and progressnoteid='46f85c90-d69b-4364-b6d2-1ffc4c9943ee';
