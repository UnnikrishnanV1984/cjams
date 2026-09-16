/*
Issue: CJAMS-64365 APPLA Assessment is blank upon approval submission
Category/Module: Approval Case/Assessment Pending Approval
Root cause: User requested to remove the assessment from the pending dashboard
Fix provided: Data fix has been done to remove the APPLA assessment from the pending dashboard.
Data/Code fix ticket#: CJAMS-64365
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User requested for data fix to remove the assessment.
*/

update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-64365'
where objectid = '4759e0e9-e2f7-40ad-8fbf-f4356bfb485a'
and routingid = 'b39e6535-ef46-40c6-ab1e-0451260955cb'
and activeflag =1;