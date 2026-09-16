/*
 Issue Description:CDM-18249
 Category/ Module: Program Assignment Error
 Root cause: Removed the records
 Pull request# N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/
update personprogramarea set activeflag=0,updatedon=now(),updatedby='CDM-18249' where personprogramid='5a33d1da-dac2-47fc-b308-90b4570e6576';
update personprogramarea set activeflag=0,updatedon=now(),updatedby='CDM-18249' where personprogramid='23b5b993-1bed-432b-ae77-8f8ea7cb2a89';