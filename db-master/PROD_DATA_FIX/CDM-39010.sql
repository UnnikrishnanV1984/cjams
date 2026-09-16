/*
 * CDM-39010 - Remove Profile
 * Customer Email ID:whitney.daggett2@maryland.gov
 * Description - 241022117353:Hello,We need to remove Brandon Sessoms from this case. He is not the correct person to be apart of this case. 
 * We confirmed that this person is attached to multiple cases and is the incorrect person.
 * remove client ID# 3556153 (BRANDON JOE SESSOMS) from the CPS AR # 241022117353.
 * 
 */

-- Delete Program Assignment(s)
update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-39010',
	updatedon = now()
where personid in ('d86f1c97-6501-4019-a53c-ec6c3705ac6b')
	and objectid = '1e8017c0-bf77-4069-a32e-158d82c8a313' 
	and activeflag = 1 ;

-- Delete Actor
update actor
set activeflag = 0,
	updatedby = 'CDM-39010',
	updatedon = now()
where personid in ('d86f1c97-6501-4019-a53c-ec6c3705ac6b')
	and intakeserviceid = '1e8017c0-bf77-4069-a32e-158d82c8a313'
	and activeflag = 1 ;

-- Delete Person Role(s)
update personrole
set activeflag = 0,
	updatedby = 'CDM-39010',
	updatedon = now()
where personid in ('d86f1c97-6501-4019-a53c-ec6c3705ac6b')
	and intakeserviceid = '1e8017c0-bf77-4069-a32e-158d82c8a313'
	and activeflag = 1 ;

-- Delete Person Relationship(s)
update actorrelationship	
set activeflag = 0,
	updatedby = 'CDM-39010',
	updatedon = now()
where intakeservicerequestactorid
	in ( select intakeservicerequestactorid
			from intakeservicerequestactor
		where personid in ('d86f1c97-6501-4019-a53c-ec6c3705ac6b')
			and intakeserviceid = '1e8017c0-bf77-4069-a32e-158d82c8a313'
		)
	and activeflag = 1 ;
	
-- Delete Intakeservicerequestactor
update intakeservicerequestactor
set activeflag = 0,
	updatedby = 'CDM-39010',
	updatedon = now()
where personid in ('d86f1c97-6501-4019-a53c-ec6c3705ac6b')
	and intakeserviceid = '1e8017c0-bf77-4069-a32e-158d82c8a313'
	and activeflag = 1 ;

-- Delete personroletype
UPDATE cjams.personroletype
SET activeflag=0, updatedby = 'CDM-39010', updatedon = now()
WHERE personroletypeid in ('0e74634a-79d5-4b8c-9253-33d3aa2d57cc'::uuid, 'e27f7e29-c36a-4b19-9a57-e53aefc35cb0'::uuid);
