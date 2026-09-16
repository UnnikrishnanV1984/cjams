/*
 Issue Description:CJAMS-66521
 Category/ Module:reopened case in error. Un able to close
 Root cause: User requested to remove the case assignment record as they are unable to close the case
 Fix provided: Data fix is done to remove the case assignment record
 Pull request# N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/
update caseassignment
set activeflag=0,
updatedby='CJAMS-66521',
updatedon=now()
where caseassignmentid='9bc5b444-4990-4097-9d2c-e9fe2386e6f5' and activeflag=1;