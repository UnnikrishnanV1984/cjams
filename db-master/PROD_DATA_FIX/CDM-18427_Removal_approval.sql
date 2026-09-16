/*
 Issue Description:CDM-18427
 Category/ Module: Removal Approval
 Root cause: Removed the record
 Pull request# N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/
update routing set activeflag=0,updatedon=now(),updatedby='CDM-18427'where objectid='5b989d2a-0b71-4d72-9e0f-bd1a686b9142';
update Intakeservreqchildremoval set activeflag=0,updatedon=now(),updatedby='CDM-18427'where intakeservreqchildremovalid='5b989d2a-0b71-4d72-9e0f-bd1a686b9142';