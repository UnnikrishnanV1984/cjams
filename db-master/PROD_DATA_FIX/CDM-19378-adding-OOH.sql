/*
 Issue Description: CDM-19378
 Category/ Module: Adding PA
 Root cause: update
 Pull request# N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/
update personprogramarea set enddate =null,updatedon=now(),updatedby='CDM-19378'where personid='d8a35937-e072-485d-826c-6ac6fc8fb4fa' and objectid ='a127239b-eb4f-4756-98a5-3e8d5a6c29f1' and activeflag='1' and programkey='OOH';