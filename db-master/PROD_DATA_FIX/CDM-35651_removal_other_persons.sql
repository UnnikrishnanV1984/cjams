
-- CDM-35651 - Need to remove 3 persons that are in Others Tab from 231021282868 case
/*
-- Issue Description: 
	231021282868:Three persons on this screen shot do not belong.Need to remove 3 persons that are in Others Tab from 231021282868 case.
   
-- Case ID: 231021282868 - c086070b-7005-4e91-ac10-c2daef7fe25b,
-- Clients 
-- 3611367 (JAYSON JONES) - 0d8771f4-ce91-4f97-8c9c-463d480f90b7
-- 3611368 (JOSIAH JONES) - 87aa29d8-b681-42f8-9730-642190047122
-- 3611365 (AURIYANNA GALLISHAW KING) - bbd264ba-41a3-4969-9bf8-b355e338b78b
   
-- Category/ Module: Persons
-- Root cause: Three persons on this screen shot do not belong to the case 231021282868. So need to remove those persons from the others persons tab.
-- Resolution: Removed the three persons from the persons other tab by setting active flag to 0.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


select  * 
	from personprogramarea
where personid in (	'0d8771f4-ce91-4f97-8c9c-463d480f90b7',
					'87aa29d8-b681-42f8-9730-642190047122',
					'bbd264ba-41a3-4969-9bf8-b355e338b78b'
				  )
	and objectid = 'c086070b-7005-4e91-ac10-c2daef7fe25b' 
	and activeflag = 1 ;


update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-35651',
	updatedon = now()
where personid in (	'0d8771f4-ce91-4f97-8c9c-463d480f90b7',
					'87aa29d8-b681-42f8-9730-642190047122',
					'bbd264ba-41a3-4969-9bf8-b355e338b78b'
				  )
	and objectid = 'c086070b-7005-4e91-ac10-c2daef7fe25b' 
	and activeflag = 1 ;

-- Delete Person Role(s)
select servicecaseid, *
	from personrole
where personid in (	'0d8771f4-ce91-4f97-8c9c-463d480f90b7',
					'87aa29d8-b681-42f8-9730-642190047122',
					'bbd264ba-41a3-4969-9bf8-b355e338b78b'
				  )
	and intakeserviceid  = 'c086070b-7005-4e91-ac10-c2daef7fe25b'
	and activeflag = 1 ;

update personrole
set activeflag = 0,
	updatedby = 'CDM-35651',
	updatedon = now()
where personid in (	'0d8771f4-ce91-4f97-8c9c-463d480f90b7',
					'87aa29d8-b681-42f8-9730-642190047122',
					'bbd264ba-41a3-4969-9bf8-b355e338b78b'
				  )
	and intakeserviceid  = 'c086070b-7005-4e91-ac10-c2daef7fe25b'
	and activeflag = 1 ;

-- Delete Person Relationship(s)
select *
	from actorrelationship
where intakeservicerequestactorid
	in ( select intakeservicerequestactorid
			from intakeservicerequestactor
		where personid 
				in ( '0d8771f4-ce91-4f97-8c9c-463d480f90b7',
					'87aa29d8-b681-42f8-9730-642190047122',
					'bbd264ba-41a3-4969-9bf8-b355e338b78b'
				   )
			and intakeserviceid  = 'c086070b-7005-4e91-ac10-c2daef7fe25b'
		)
	and activeflag = 1 ;

update actorrelationship	
set activeflag = 0,
	updatedby = 'CDM-35651',
	updatedon = now()
where intakeservicerequestactorid
	in ( select intakeservicerequestactorid
			from intakeservicerequestactor
		where personid 
				in ( '0d8771f4-ce91-4f97-8c9c-463d480f90b7',
					'87aa29d8-b681-42f8-9730-642190047122',
					'bbd264ba-41a3-4969-9bf8-b355e338b78b'
				   )
			and intakeserviceid = 'c086070b-7005-4e91-ac10-c2daef7fe25b'
		)
	and activeflag = 1 ;
	
-- Delete Intakeservicerequestactor
select *
	from intakeservicerequestactor
where personid in ( '0d8771f4-ce91-4f97-8c9c-463d480f90b7',
					'87aa29d8-b681-42f8-9730-642190047122',
					'bbd264ba-41a3-4969-9bf8-b355e338b78b'
				   )
	and intakeserviceid = 'c086070b-7005-4e91-ac10-c2daef7fe25b'
	and activeflag = 1 ;

update intakeservicerequestactor
set activeflag = 0,
	updatedby = 'CDM-35651',
	updatedon = now()
where personid in ( '0d8771f4-ce91-4f97-8c9c-463d480f90b7',
					'87aa29d8-b681-42f8-9730-642190047122',
					'bbd264ba-41a3-4969-9bf8-b355e338b78b'
				   )
	and intakeserviceid = 'c086070b-7005-4e91-ac10-c2daef7fe25b'
	and activeflag = 1 ;

-- Delete Actor
select *
	from actor
where personid in ( '0d8771f4-ce91-4f97-8c9c-463d480f90b7',
					'87aa29d8-b681-42f8-9730-642190047122',
					'bbd264ba-41a3-4969-9bf8-b355e338b78b'
				   )
and intakeserviceid  = 'c086070b-7005-4e91-ac10-c2daef7fe25b'
	and activeflag = 1 ;
	
update actor
set activeflag = 0,
	updatedby = 'CDM-35651',
	updatedon = now()
where personid in ( '0d8771f4-ce91-4f97-8c9c-463d480f90b7',
					'87aa29d8-b681-42f8-9730-642190047122',
					'bbd264ba-41a3-4969-9bf8-b355e338b78b'
				   )
and intakeserviceid  = 'c086070b-7005-4e91-ac10-c2daef7fe25b'
	and activeflag = 1 ;