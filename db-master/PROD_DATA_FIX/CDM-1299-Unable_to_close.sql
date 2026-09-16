update intakedastaging
set jsondata = (select jsonb(jsondata) - 'General' || jsonb(json_build_object('General',(select jsonb(jsondata->>'General')-'countyid' || jsonb(json_build_object('countyid','3254e9ef-08da-4cd7-8aa1-083896ed9bec') )
from intakedastaging i 
where intakenumber = 'I202000162832' and activeflag = 1)))
from intakedastaging i2
where intakenumber = 'I202000162832' and activeflag = 1)
where intakenumber = 'I202000162832' and activeflag = 1;

update intakesnapshot 
set activeflag = 0
where intakesnapshotid in ('ef3a8114-1618-46b4-81cb-a1209476379e','fd949e63-2547-4c96-989c-e3a2ceb9d609');	

update intakesnapshot
set jsondata = (select jsonb(jsondata) - 'General' || jsonb(json_build_object('General',(select jsonb(jsondata->>'General')-'countyid' || jsonb(json_build_object('countyid','3254e9ef-08da-4cd7-8aa1-083896ed9bec') )
from intakesnapshot i 
where intakenumber = 'I202000162832' and activeflag = 1)))
from intakesnapshot i2
where intakenumber = 'I202000162832' and activeflag = 1)
where intakenumber = 'I202000162832' and activeflag = 1;