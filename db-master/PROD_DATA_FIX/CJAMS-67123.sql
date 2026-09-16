
/*
Issue: Need to close GAP
Category/Module:
Root cause: User requested to update the Rate slab to approved, since user has modified the date its not going through approval
Fix provided: Data fix has been done to approve the rate slab
Data/Code fix ticket#:CJAMS-67123
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data was done in the database to fix the issue. No code change was required.
*/


update gapagreementrate set status='Approved',
updatedby='CJAMS-67123',
updatedon=now()
where gapagreementrateid='ec20ee55-f363-4395-af4e-cd487530df35' and activeflag=1;

update gapratesrevision set approvalstatustypekey='3047',
approvaldate = now(),updatedby='CJAMS-67123',
updatedon=now()
where gaprateid='ec20ee55-f363-4395-af4e-cd487530df35' and activeflag=1;

update routing 
set routingstatustypeid =16,
updatedby='CJAMS-67123',
updatedon=now()
where routingid ='dacbac2a-b054-4885-8da8-d67f739360bb' and eventcode ='GARR' and activeflag =1;