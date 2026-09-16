/*
 Issue Description:CDM-19046
 Category/ Module:OHP
 Root cause: removed user
 Pull request# N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/
update personprogramarea set enddate=null,updatedby='CDM-19046',updatedon=now() where objectid='a127239b-eb4f-4756-98a5-3e8d5a6c29f1' and personprogramid ='f8978806-d3f3-4431-8fb1-3fc3c3e7ddb1';