
/*
Issue Description: Case Approved But Not Assigned
Category/Module: case management 
Root cause: I261014088692:CJAMS froze when I screened this case in, and I was not able to assign it. Intake NumberI261014088692
Fix provided: Data fix done to Please keep the Intake# I261014088692 for Supervisor approval as the case didn't get created and to Remove the SUPERVISOR DECISION (In the Grey dropdown) and Submission History, Submitted To/ Approved By, Approved/Closed On, Status to Review
Data/Code fix ticket#: CJAMS-68122
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data Fix
*/
update routing
set routingstatustypeid=1,
supervisordecision=null
where routingid='15c8d360-4671-4428-be51-e156c2f952f0' and activeflag=1;

update intakedastatus
set status=1, updatedon = now(), updatedby = 'CJAMS-68122'
where intakedastatusid='c5a79e8b-3cdf-4556-add9-8cf99bbdda4a';


update intakedastaging
set status='pending', ispreintake=false, updatedon = now(), updatedby = 'CJAMS-68122'
where intakenumber='I261014088692' and activeflag=1;


update intakesnapshot
set jsondata = jsonb_set(jsondata, '{reviewstatus,status}', '"supreview"'), updatedon = now(), updatedby = 'CJAMS-68122'
where intakenumber='I261014088692' and activeflag=1;

UPDATE intakesnapshot
SET jsondata =
jsonb_set(
jsonb_set(
jsonb_set(
jsonb_set(
jsonb_set(
jsonb_set(
jsonb_set(
jsonb_set(
jsonb_set(
jsonb_set(
jsonb_set(
jsonb_set(
jsondata,
'{DAType,DATypeDetail,0,supDisposition}', '""'
), '{DAType,DATypeDetail,0,supStatus}', '""'
), '{DAType,DATypeDetail,0,DAStatus}', '"Review"'
), '{DAType,DATypeDetail,0,dispositioncode}', '""'
), '{disposition,0,supDisposition}', '""'
), '{disposition,0,supStatus}', '""'
), '{disposition,0,DAStatus}', '"Review"'
), '{disposition,0,dispositioncode}', '""'
), '{intakeDATypeDetails,0,supDisposition}', '""'
), '{intakeDATypeDetails,0,supStatus}', '""'
), '{intakeDATypeDetails,0,DAStatus}', '"Review"'
), '{intakeDATypeDetails,0,dispositioncode}', '""'
), updatedon = now(), updatedby = 'CJAMS-68122'
WHERE intakenumber = 'I261014088692'
AND activeflag = 1;