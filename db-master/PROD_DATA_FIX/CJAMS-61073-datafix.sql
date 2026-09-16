/*
Issue: Data fix has been done to update the screening decision to screenin for the intake# I251013332873.
Category/Module: Bug
Root cause: User requested to update the screening decision to screenin for the intake# I251013332873. 
As per the comments, Issue is not replicable in any environment
Fix provided: Data fix has been done to update the screening decision to screenin for the intake# I251013332873.
Data/Code fix ticket#: CJAMS-61073
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update intakesnapshot 
set jsondata = replace(jsondata::text, '"screeningRecommend": "ScreenOUT",' , '"screeningRecommend": "Scrnin",')::json, 
updatedon = now(),updatedby = 'CJAMS-61073' where intakenumber = 'I251013332873';