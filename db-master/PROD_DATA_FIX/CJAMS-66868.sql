
/*
Issue Description: CJAMS-66868 Change the provider involve maltreatment to yes
Category/Module: Workload 
Root cause: User requested update provider involved
Fix provided: Data fix has been done to update the provider involved to Yes
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: 
*/


update investigationallegation
set isproviderinvolved=1,
updatedby='CJAMS-66868',
updatedon=now()
 where investigationid ='13b4c981-50d8-4579-ba02-91c055690ded' and activeflag =1;