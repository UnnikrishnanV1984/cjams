/*
   Issue Description: CDM-28911
   Category/ Module  :Person Program Area 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/
UPDATE cjams.personprogramarea
SET enddate=null, updatedon=now(), updatedby='CDM-28911'
WHERE personprogramid='88556102-31d7-4986-8a99-4d0a8362708d' and personid='c8813e67-ee19-41bf-90a2-8bf8e0ba4311'
and objectid='3b35577e-825a-4991-a982-7c055df0cd93';
