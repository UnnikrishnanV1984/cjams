/* 
   Issue Description: CDM-34892
   Category/ Module  : Progress Note Addendum
   Root cause: Insertedby column was null. 
   Pull request# for code fix: 
   Reason why no related code fix: fix done as part of CDM-34700
   Status of the code fix if already submitted and expected prod fix date: 
   Case is closed without closing removal and placement. Need to do data fix
*/

UPDATE cjams.progressnotedetail pnd
SET insertedby=(select pn.updatedby from progressnote pn where pn.progressnoteid = pnd.progressnoteid and pn.activeflag = 1), updatedby='CDM-34892', updatedon=now()
WHERE pnd.progressnoteid in (select progressnoteid from progressnote where intakeserviceid = '5cc756e8-34b5-4a38-bdc4-d1b4ce4b49d2' and activeflag = 1) 
and isaddendum = 1 and insertedby is null and updatedby is null;