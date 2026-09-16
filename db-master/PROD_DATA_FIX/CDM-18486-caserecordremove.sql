/*
 Issue Description:CDM-18486
 Category/ Module:case removal record
 Root cause: case removal
 Pull request# N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/
update caseassignment set activeflag=0,updatedon=now(),updatedby='CDM-18486' where objectid='0da4d53b-a09b-46d6-a74e-13f90557027d';
