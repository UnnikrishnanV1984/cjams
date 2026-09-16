/*
 Issue Description:CJAMS-61008
 Category/ Module:delete intake
 Root cause: delete duplicate intake
 Pull request# N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/

update intakedastaging set activeflag=0,updatedon=now(),updatedby='CJAMS-61008'where intakenumber='I251013260263' and activeflag =1;

-- intakedastatus already been deactivated by CJAMS-58918
--update intakedastatus set activeflag=0,updatedon=now(),updatedby='CJAMS-61008'where intakenumber='I251013260263';
-- Others doesn't have the records
--update intakesnapshot set activeflag=0,updatedon=now(),updatedby='CJAMS-61008'where intakenumber='I251013260263';
--update routing set activeflag=0,updatedon=now(),updatedby='CJAMS-61008'where objectid='I251013260263';
