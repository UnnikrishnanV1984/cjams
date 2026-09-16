update serviceplan
set
serviceplancandidacy = '{"candidates": [{"id": "200149540", "name": "Amelia Cox", "candidacy": "1"}]}',
updatedon = now(),
updatedby = 'CDM-10475'
 where serviceplanid = 'f3c81265-1dae-44d4-956e-e5099f2b2852';