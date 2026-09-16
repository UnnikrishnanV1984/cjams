update personprogramarea set activeflag = 0, updatedon =now(), updatedby = 'CDM-11587' where personprogramid in (
'70ad9b57-3347-4218-93dd-79c65f50d973',
'4e8d6e8f-8390-4e41-b5db-b57bddf438b3',
'e7b4171d-1fae-4ff1-b2af-a7db682a0266', 
'd03f3a29-dea1-4845-b2ee-c11e432ea4eb',
'c275e0c3-8373-4786-afdb-7daeffaed95a',
'6fdeac13-262a-4225-b226-024e0b065aea'
)
and entityid in ('2021026075272','2021049082862') and programkey = 'CPS' and activeflag = 1;