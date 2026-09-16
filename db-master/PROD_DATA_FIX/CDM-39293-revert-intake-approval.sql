/*
   Issue Description: CDM-39293 Cannot close CPS-ROA case
   Category/ Module  : Title IV-E
   Root cause: User wants to add the contacts to ROA CPS intake# I241012407946 and the dummy case# 241022227909 should be deleted.
   Fix Provided :Data fix has been promoted to revert the approval request and delete the dummy case created
   Pull request# for code fix:  N/A
   Reason why no related code fix: N/A
   Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete: N/A
*/

update intakesnapshot
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-39293'
where intakesnapshotid::character varying = '3035f38f-57f1-4fff-b306-cbd642275add';

update intakeservicerequest
set activeflag = 0,
updatedon = now(),
updatedby = 'CDM-39293'				
where intakenumber = 'I241012407946';

update routing
set routingstatustypeid  = 1,
supervisordecision = null,
updatedon = now()
where objectid = 'I241012407946';

update intakedastatus
set status = 1,
updatedon = now(),
updatedby = 'CDM-39293'
where intakenumber = 'I241012407946' and activeflag=1;

update intakedastaging
set status = 'pending',
ispreintake = FALSE,
updatedon = now(),
updatedby = 'CDM-39293'
where intakenumber = 'I241012407946' and activeflag = 1;