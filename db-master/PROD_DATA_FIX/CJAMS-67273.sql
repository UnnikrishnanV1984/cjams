/*
 Issue Description:CJAMS-67273
 Category/ Module:reopened case in error. Un able to close
 Root cause: Requested to remove case assignment as it got opened for a closed case,it got inserted by a deactivated user
 Fix provided: Data fix is done to remove the case assignment record
 Pull request# N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
*/
update caseassignment
set activeflag=0,
updatedby='CJAMS-67273',
updatedon=now()
where caseassignmentid in ('523e35e9-f4e7-4beb-84f2-3551336b2260','2a347188-e2ed-40b7-b7d1-4b196201b900') and activeflag=1;