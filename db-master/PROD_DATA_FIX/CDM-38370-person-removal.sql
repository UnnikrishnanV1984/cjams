-- CDM-38370 - Need to remove 1 person from 241021915614 case
/*
-- Issue Description: 
	241021915614:PID 3082713 was added to case #241021915614 erroneously. She is not connected to the case in any way and needs to be removed via data fix
   
-- Case ID: 241021915614 - e95bd7c1-7605-45a2-9901-316120b497a1,
-- Clients 
-- 3082713 (EDITH GARCIA) - 4fc116a2-8191-44e2-a402-51d471005355

   
-- Category/ Module: Persons
-- Root cause: one person on this screen shot do not belong to the case 241021915614. So need to remove person from the others persons tab.
-- Resolution: Removed a person from the persons other tab by setting active flag to 0.
-- Pull request# https://source.mdthink.maryland.gov/projects/DHSCJAMS/repos/cjams_db_scripts/pull-requests/11723/overview
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/




update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-38370',
	updatedon = now()
where personid = '4fc116a2-8191-44e2-a402-51d471005355'
	and objectid = 'e95bd7c1-7605-45a2-9901-316120b497a1' 
	and activeflag = 1 ;

-- Delete Person Role(s)


update personrole
set activeflag = 0,
	updatedby = 'CDM-38370',
	updatedon = now()
where personid = '4fc116a2-8191-44e2-a402-51d471005355'
	and intakeserviceid  = 'e95bd7c1-7605-45a2-9901-316120b497a1'
	and activeflag = 1 ;

-- Delete Person Relationship(s)


update actorrelationship	
set activeflag = 0,
	updatedby = 'CDM-38370',
	updatedon = now()
where intakeservicerequestactorid
	in ( select intakeservicerequestactorid
			from intakeservicerequestactor
		where personid = '4fc116a2-8191-44e2-a402-51d471005355'
			and intakeserviceid = 'e95bd7c1-7605-45a2-9901-316120b497a1'
		)
	and activeflag = 1 ;
	
-- Delete Intakeservicerequestactor


update intakeservicerequestactor
set activeflag = 0,
	updatedby = 'CDM-38370',
	updatedon = now()
where personid = '4fc116a2-8191-44e2-a402-51d471005355'
	and intakeserviceid = 'e95bd7c1-7605-45a2-9901-316120b497a1'
	and activeflag = 1 ;

-- Delete Actor

	
update actor
set activeflag = 0,
	updatedby = 'CDM-38370',
	updatedon = now()
where personid = '4fc116a2-8191-44e2-a402-51d471005355'
and intakeserviceid  = 'e95bd7c1-7605-45a2-9901-316120b497a1'
	and activeflag = 1 ;

-- Update personroletype

		
update personroletype 
		set  activeflag = 0,
			 updatedby = 'CDM-38370',
			 updatedon = now()
		where personroleid in (select
			personroleid
		from
			personrole
		where
			personid = '4fc116a2-8191-44e2-a402-51d471005355'
			and intakeserviceid = 'e95bd7c1-7605-45a2-9901-316120b497a1');

