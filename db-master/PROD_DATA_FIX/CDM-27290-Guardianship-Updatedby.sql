/*
   Issue Description: CDM-27290
   Category/ Module  : Permanency plan
   Root cause: user wants update the approved and updated by in plan
   Pull request# for code fix: 7267
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/

-- '2ef1f30a-cff2-487d-b5c7-1152a87a69eb'  - Emily
-- 'acdceddb-659f-487c-a18c-bae2b5e10b90'  - Kafi

update
    routing
set
    fromsecurityusersid = 'acdceddb-659f-487c-a18c-bae2b5e10b90',
    tosecurityusersid = '2ef1f30a-cff2-487d-b5c7-1152a87a69eb',
    updatedby = 'CDM-27290',
    updatedon = now()
where
    routingid = '1cc22ca1-5112-4045-927f-1a4da0c2b9af';

update
    gapapplication
set
    insertedby = '2ef1f30a-cff2-487d-b5c7-1152a87a69eb',
    updatedby = 'CDM-27290',
    updatedon = now()
where
    gapid = 'c86a8ec5-851b-4454-aa62-df06ce7e17b0';

update
	gapapplication
set
	updatedby = '2ef1f30a-cff2-487d-b5c7-1152a87a69eb',
	updatedon = now()
where
	gapapplicationid = 'a5eefbea-24ed-475f-94fb-83e3f363a58b'
	and activeflag = 1;