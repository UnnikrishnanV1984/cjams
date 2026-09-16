/*
 * CDM-41605 - Remove Person From Persons Tab, case should be removed person prior case history and Program Assignment.
 * Customer Email ID:kevin.buckley@maryland.gov
 * Focus Area:Persons
 * Identified As:User Error
 * Description - 241030399057:Geoffrey Mott, CJAMS ID 203985287,was added to this service case in error. 
 */

-- Delete Program Assignment(s)
update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-41605',
	updatedon = now()
where personid = '7627e9ed-f54c-4ba3-a7fe-db267f379921'
	and personprogramid = 'cfab05c2-9125-4435-91ea-05b10c083679' 
	and activeflag = 1 ;


-- Delete Actor
/*select actorid, actortype, activeflag, updatedby, updatedon,intakeserviceid
	from actor
where personid = '7627e9ed-f54c-4ba3-a7fe-db267f379921'
	and servicecaseid = '95581836-e621-487b-ab75-ba69ef79fbf9'
	and activeflag = 1 ;--actorid = e47351ba-9682-4b41-bc5e-37b230bd3924
	*/
update actor
set activeflag = 0,
	updatedby = 'CDM-41605',
	updatedon = now()
where personid = '7627e9ed-f54c-4ba3-a7fe-db267f379921'
	and servicecaseid = '95581836-e621-487b-ab75-ba69ef79fbf9'
	and activeflag = 1 ;--actorid = e47351ba-9682-4b41-bc5e-37b230bd3924

-- Delete Person Role(s)
/*select personroleid, activeflag, updatedby, updatedon 
	from personrole
where personid = '7627e9ed-f54c-4ba3-a7fe-db267f379921'
	and servicecaseid = '95581836-e621-487b-ab75-ba69ef79fbf9'
	and activeflag = 1 ;*/

update personrole
set activeflag = 0,
	updatedby = 'CDM-41605',
	updatedon = now()
where personid = '7627e9ed-f54c-4ba3-a7fe-db267f379921'
	and servicecaseid = '95581836-e621-487b-ab75-ba69ef79fbf9'
	and activeflag = 1 ;

-- Delete Person Relationship(s)
/*select actorrelationshipid, relationshiptypekey, activeflag, updatedby, updatedon
	from actorrelationship
where intakeservicerequestactorid
	in ( select intakeservicerequestactorid
			from intakeservicerequestactor
			where personid = '7627e9ed-f54c-4ba3-a7fe-db267f379921'
			and servicecaseid = '95581836-e621-487b-ab75-ba69ef79fbf9'
		)
	and activeflag = 1 ;*/
	
update actorrelationship	
set activeflag = 0,
	updatedby = 'CDM-41605',
	updatedon = now()
where intakeservicerequestactorid
	in ( select intakeservicerequestactorid
			from intakeservicerequestactor
			where personid = '7627e9ed-f54c-4ba3-a7fe-db267f379921'
			and servicecaseid = '95581836-e621-487b-ab75-ba69ef79fbf9'
		)
	and activeflag = 1 ;
	
-- Delete Intakeservicerequestactor
/*select intakeserviceid, servicecaseid, intakeservicerequestpersontypekey, activeflag, updatedby, updatedon
	from intakeservicerequestactor
where personid = '7627e9ed-f54c-4ba3-a7fe-db267f379921'
	and servicecaseid = '95581836-e621-487b-ab75-ba69ef79fbf9'
	and activeflag = 1 ;*/

update intakeservicerequestactor
set activeflag = 0,
	updatedby = 'CDM-41605',
	updatedon = now()
where personid = '7627e9ed-f54c-4ba3-a7fe-db267f379921'
	and servicecaseid = '95581836-e621-487b-ab75-ba69ef79fbf9'
	and activeflag = 1 ;

-- Delete personroletype
/*select *
from personroletype p
where personroleid
in
(select personroleid
from personrole
where personid = '7627e9ed-f54c-4ba3-a7fe-db267f379921'
and servicecaseid = '95581836-e621-487b-ab75-ba69ef79fbf9'
)
and activeflag = 1;	*/

UPDATE cjams.personroletype
SET activeflag=0, updatedby = 'CDM-41605', updatedon = now()
WHERE personroletypeid in ('5b028960-8c93-4578-92af-0f500dedb9b9'::uuid, 'd708c029-2e59-4ebb-92c9-5d6165763057'::uuid,'34c3228b-53b5-49dd-a8d0-0554a9265226'::uuid );
