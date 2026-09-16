update intakedastaging set status='pending',ispreintake=false where intakenumber in ('I202000461774','I202000262096') and activeflag=1
and id in (130612,123779);

update intakeDAStatus set status=1  where intakenumber in ('I202000461774','I202000262096') and 
intakedastatusid in ('0988d643-502b-4644-892e-3b7d3b3498fd','3c10f671-6abc-4067-86cf-a5b48f966d77');

update routing set eventcode='INTR', activeflag=1 where 
objectid = 'I202000461774'and routingid='5e1a1c5f-09c2-4931-ad20-056d55b4e4d5';

update routing set eventcode='INTR', activeflag=1 where 
objectid = 'I202000262096'and routingid='ec863b1d-d9a4-4a52-ac3a-6248c8178aee';