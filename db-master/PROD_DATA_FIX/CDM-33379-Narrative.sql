/*
   Issue Description: CDM-33379
   Category/ Module  : Intake  
   Root cause: User request 
   Fix Provide: Did data fix to update narrative info
*/

update
	intakesnapshot
set
	jsondata = jsonb_set(jsondata, '{General}', jsonb_set(jsondata->'General', '{Narrative}', '"<p>Completed a CPS background clearance check and LISA C YERRID was indicated for Child Neglect in Howard County in 1998; therebefore she is unable to be cleared.</p>"')),
	updatedby = 'CDM-33379',
	updatedon = now()
where
	intakenumber = 'I231010885123'
	and activeflag = 1;


update
	intakedastaging
set
	jsondata = jsonb_set(jsondata, '{General}', jsonb_set(jsondata->'General', '{Narrative}', '"<p>Completed a CPS background clearance check and LISA C YERRID was indicated for Child Neglect in Howard County in 1998; therebefore she is unable to be cleared.</p>"')),
	updatedby = 'CDM-33379',
	updatedon = now()
where
	intakenumber = 'I231010885123'
	and activeflag = 1;