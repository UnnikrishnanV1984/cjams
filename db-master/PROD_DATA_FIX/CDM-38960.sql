/*
 * CDM-38960 - Delete person
 * Customer Email ID:krystal.christ@maryland.gov
 * Focus Area:Persons
 * Description - 241022114405:Please delete the child "Madison Adkins" which was made in error by intake worker.
 * remove the client ID: 203036737 Madison Adkins from the CPS IR # 241022114405.
 * 
 */

-- Delete Program Assignment(s)
update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-38960',
	updatedon = now()
where personid in ('9f80bcf2-3c48-46ad-9476-f2abb5cfb11e')
	and personprogramid = 'ed1ec852-d36c-45a7-b84e-e25c4164366e' 
	and activeflag = 1 ;

-- Delete Actor
update actor
set activeflag = 0,
	updatedby = 'CDM-38960',
	updatedon = now()
where personid in ('9f80bcf2-3c48-46ad-9476-f2abb5cfb11e')
	and intakeserviceid = 'b30fdf9c-859d-42ec-ac09-c1b8a5cfcc2a'
	and activeflag = 1 ;

-- Delete Person Role(s)
update personrole
set activeflag = 0,
	updatedby = 'CDM-38960',
	updatedon = now()
where personid in ('9f80bcf2-3c48-46ad-9476-f2abb5cfb11e')
	and intakeserviceid = 'b30fdf9c-859d-42ec-ac09-c1b8a5cfcc2a'
	and activeflag = 1 ;

-- Delete Person Relationship(s)
update actorrelationship	
set activeflag = 0,
	updatedby = 'CDM-38960',
	updatedon = now()
where intakeservicerequestactorid
	in ( select intakeservicerequestactorid
			from intakeservicerequestactor
		where personid in ('9f80bcf2-3c48-46ad-9476-f2abb5cfb11e')
			and intakeserviceid = 'b30fdf9c-859d-42ec-ac09-c1b8a5cfcc2a'
		)
	and activeflag = 1 ;
	
-- Delete Intakeservicerequestactor
update intakeservicerequestactor
set activeflag = 0,
	updatedby = 'CDM-38960',
	updatedon = now()
where personid in ('9f80bcf2-3c48-46ad-9476-f2abb5cfb11e')
	and intakeserviceid = 'b30fdf9c-859d-42ec-ac09-c1b8a5cfcc2a'
	and activeflag = 1 ;

-- Delete personroletype
UPDATE cjams.personroletype
SET activeflag=0, updatedby = 'CDM-38960', updatedon = now()
WHERE personroletypeid in ('d422e705-3b6f-4d8b-8276-05c54c5c94f7'::uuid);
