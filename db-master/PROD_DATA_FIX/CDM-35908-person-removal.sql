-- CDM-35908 - Need to remove 1 person that are in Others Tab from 231021326593 case
/*
-- Issue Description: 
	231021326593:One person on this screen shot do not belong.Need to remove 3 persons that are in Others Tab from 231021326593 case.
   
-- Case ID: 231021326593 - e74af02a-e258-4d92-93e5-a8988aeda26b,
-- Clients 
-- 202400126 (AMANDA MORROW) - 192b9c49-bbbe-44af-97f4-33310c86ab4f

   
-- Category/ Module: Persons
-- Root cause: one person on this screen shot do not belong to the case 231021326593. So need to remove person from the others persons tab.
-- Resolution: Removed a person from the persons other tab by setting active flag to 0.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select * from cjams.person where cjamspid='202400126';

select  * 
	from personprogramarea
where personid = '192b9c49-bbbe-44af-97f4-33310c86ab4f'
	and objectid = 'e74af02a-e258-4d92-93e5-a8988aeda26b' 
	and activeflag = 1 ;


update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-35908',
	updatedon = now()
where personid = '192b9c49-bbbe-44af-97f4-33310c86ab4f'
	and objectid = 'e74af02a-e258-4d92-93e5-a8988aeda26b' 
	and activeflag = 1 ;

-- Delete Person Role(s)
select servicecaseid, *
	from personrole
where personid = '192b9c49-bbbe-44af-97f4-33310c86ab4f'
	and intakeserviceid  = 'e74af02a-e258-4d92-93e5-a8988aeda26b'
	and activeflag = 1 ;

update personrole
set activeflag = 0,
	updatedby = 'CDM-35908',
	updatedon = now()
where personid = '192b9c49-bbbe-44af-97f4-33310c86ab4f'
	and intakeserviceid  = 'e74af02a-e258-4d92-93e5-a8988aeda26b'
	and activeflag = 1 ;

-- Delete Person Relationship(s)
select *
	from actorrelationship
where intakeservicerequestactorid
	in ( select intakeservicerequestactorid
			from intakeservicerequestactor
		where personid = '192b9c49-bbbe-44af-97f4-33310c86ab4f'
			and intakeserviceid  = 'e74af02a-e258-4d92-93e5-a8988aeda26b'
		)
	and activeflag = 1 ;

update actorrelationship	
set activeflag = 0,
	updatedby = 'CDM-35908',
	updatedon = now()
where intakeservicerequestactorid
	in ( select intakeservicerequestactorid
			from intakeservicerequestactor
		where personid = '192b9c49-bbbe-44af-97f4-33310c86ab4f'
			and intakeserviceid = 'e74af02a-e258-4d92-93e5-a8988aeda26b'
		)
	and activeflag = 1 ;
	
-- Delete Intakeservicerequestactor
select *
	from intakeservicerequestactor
where personid = '192b9c49-bbbe-44af-97f4-33310c86ab4f'
	and intakeserviceid = 'e74af02a-e258-4d92-93e5-a8988aeda26b'
	and activeflag = 1 ;

update intakeservicerequestactor
set activeflag = 0,
	updatedby = 'CDM-35908',
	updatedon = now()
where personid = '192b9c49-bbbe-44af-97f4-33310c86ab4f'
	and intakeserviceid = 'e74af02a-e258-4d92-93e5-a8988aeda26b'
	and activeflag = 1 ;

-- Delete Actor
select *
	from actor
where personid = '192b9c49-bbbe-44af-97f4-33310c86ab4f'
and intakeserviceid  = 'e74af02a-e258-4d92-93e5-a8988aeda26b'
	and activeflag = 1 ;
	
update actor
set activeflag = 0,
	updatedby = 'CDM-35908',
	updatedon = now()
where personid = '192b9c49-bbbe-44af-97f4-33310c86ab4f'
and intakeserviceid  = 'e74af02a-e258-4d92-93e5-a8988aeda26b'
	and activeflag = 1 ;

-- Update personroletype
select * from personroletype where personroleid in (select
			personroleid
		from
			personrole
		where
			personid = '192b9c49-bbbe-44af-97f4-33310c86ab4f'
			and intakeserviceid = 'e74af02a-e258-4d92-93e5-a8988aeda26b');
		
		
update personroletype 
		set  activeflag = 0,
			 updatedby = 'CDM-35908',
			 updatedon = now()
		where personroleid in (select
			personroleid
		from
			personrole
		where
			personid = '192b9c49-bbbe-44af-97f4-33310c86ab4f'
			and intakeserviceid = 'e74af02a-e258-4d92-93e5-a8988aeda26b');

