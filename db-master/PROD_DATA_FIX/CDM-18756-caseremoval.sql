/*
 Issue Description:CDM-18756
 Category/ Module:case removal
 Root cause: case removed
 Pull request# N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/
update servicecasedisposition set activeflag=0,updatedon=now(),updatedby='CDM-18756' where servicecasedispositionid='70690f8f-d40e-4e67-acc2-7a27f4ebe11b';
update personprogramarea set enddate=null,updatedon=now(),updatedby='CDM-18756' where personprogramid='fd54b753-18b1-467b-bc2b-3b61aeed085d'and programkey='OOH';
update personprogramarea set enddate=null,updatedon=now(),updatedby='CDM-18756' where personprogramid='f38fe129-425e-49a5-9787-39ec32196100'and programkey='OOH';