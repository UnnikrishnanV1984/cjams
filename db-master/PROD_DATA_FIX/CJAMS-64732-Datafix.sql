/*
Issue: CJAMS-64732 Intake stuck on my dashboard
Category/Module: Intake
Root cause: As per the user, they override the intake and then initiated the transfer.
In stg3, not able to initiate the transfer when the intake is in review status or after approval or override.

Currently the intake is stuck, user is not able to assign the intake to the intake worker.
Need analysis on the issue and the intake worker should be able to submit the intake.
Please do the following data fixes,

1. Need to display the screen In(Accepted) record in the submission history)
2. Add the worker Cynthia Galloway(cynthia.galloway1@maryland.gov) in the transfer History
3. Update the worker name in the Author field
4. Remove the intake from the Assign transfer dashboard of the supervisor(Whitney Daggett)
5. Verify whether the assigned intake worker is able to submit the intake and make sure the case is not impacted.
6. Remove the intake from Jennifer Knotts's Pending review dashboard.
7. Display the intake in Cynthia Galloway's Pending dashbaord


Fix provided:  Data fix has been done to make the changes in the intake as requested by the user
Data/Code fix ticket#: CJAMS-64732
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: We are unable to reproduce this issue in stage-3 and will closely monitor it for future occurences.
*/

update routing
set routingstatustypeid = 2,
	supervisordecision = 'Scrnin',
	updatedon='2026-01-22',
	eventcode = 'INTR',
	updatedby = 'd86bb458-2309-4182-b155-ae22d36cf9d6'
where objectid = 'I261013785699'
and routingid =  '7309c9d1-5c24-47f1-a4d0-5ddcae682cda';

UPDATE intakedastaging
SET status = 'Accepted',
updatedby = 'CJAMS-64732', updatedon = now(), 
jsondata = jsonb_set(jsondata, '{DAType}',
jsonb_set(jsondata->'DAType', '{DATypeDetail}',
jsonb_set(jsondata->'DAType'->'DATypeDetail', '{0}',
jsonb_set(jsondata->'DAType'->'DATypeDetail'->0, '{supDisposition}', '"Scrnin"'))))
WHERE intakenumber = 'I261013785699' AND activeflag=1;

