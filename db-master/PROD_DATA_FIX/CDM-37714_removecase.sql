-- CDM-37714 - Remove Case from Dash Board
/* Issue Description: User requested to remove this case from my dashboard

-- case number: I202000569736
-- Category/ Module: Disposition 

-- Root cause: User requested to remove this case from my dashboard.
-- Fix Provided: Datafix has been provided to remove casefrom dashboard 
-- Pull request# N/A

*/

select * from intakedastaging i where intakenumber = 'I202000569736' and activeflag = 1;

UPDATE cjams.intakedastaging
SET activeflag = 0,
updatedby = 'CDM-37714',
updatedon = now()
WHERE intakenumber = 'I202000569736' and activeflag = 1;

select * from intakedastatus where intakenumber = 'I202000569736' and activeflag = 1;

UPDATE cjams.intakedastatus
SET activeflag = 0,
updatedby = 'CDM-37714',
updatedon = now()
WHERE intakenumber = 'I202000569736' and activeflag = 1;
