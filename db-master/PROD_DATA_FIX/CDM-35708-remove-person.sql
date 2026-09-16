-- CDM-35708 - Need to remove person that are in Others Tab from 231021176207 case
/*
-- Issue Description: 
	231021176207:Albert Linamen was entered into this case in error. He is no party to this case, and needs to be removed
   
-- Case ID: 231021176207 - fe53024a-c706-4a35-964f-93c1a9902e13,
-- Clients 
-- 231021176207 (Albert Linamen) - 72275488-228c-4a1b-936c-2f56efa643ad
   
-- Category/ Module: Persons
-- Root cause: 231021176207:Albert Linamen was entered into this case in error. He is no party to this case, and needs to be removed
-- Resolution: Removed Albert Linamen from the persons other tab by setting active flag to 0.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


select  * 
	from personprogramarea
where personid = '72275488-228c-4a1b-936c-2f56efa643ad'
	and objectid = 'fe53024a-c706-4a35-964f-93c1a9902e13' 
	and activeflag = 1 ;


update personprogramarea
set activeflag = 0,
	updatedby = 'CDM-35708',
	updatedon = now()
where personid = '72275488-228c-4a1b-936c-2f56efa643ad'
	and objectid = 'fe53024a-c706-4a35-964f-93c1a9902e13' 
	and activeflag = 1 ;

-- Delete Person Role(s)

select servicecaseid, *
	from personrole
where personid = '72275488-228c-4a1b-936c-2f56efa643ad'
	and intakeserviceid  = 'fe53024a-c706-4a35-964f-93c1a9902e13'
	and activeflag = 1 ;

update personrole
set activeflag = 0,
	updatedby = 'CDM-35708',
	updatedon = now()
where personid = '72275488-228c-4a1b-936c-2f56efa643ad'
	and intakeserviceid  = 'fe53024a-c706-4a35-964f-93c1a9902e13'
	and activeflag = 1 ;

-- Delete Person Relationship(s)
select *
	from actorrelationship
where intakeservicerequestactorid
	in ( select intakeservicerequestactorid
			from intakeservicerequestactor
              where personid = '72275488-228c-4a1b-936c-2f56efa643ad'
			and intakeserviceid  = 'fe53024a-c706-4a35-964f-93c1a9902e13'
		)
	and activeflag = 1 ;

update actorrelationship	
set activeflag = 0,
	updatedby = 'CDM-35708',
	updatedon = now()
where intakeservicerequestactorid
	in ( select intakeservicerequestactorid
			from intakeservicerequestactor
               where personid = '72275488-228c-4a1b-936c-2f56efa643ad'
			and intakeserviceid = 'fe53024a-c706-4a35-964f-93c1a9902e13'
		)
	and activeflag = 1 ;
	
-- Delete Intakeservicerequestactor
select *
	from intakeservicerequestactor
    where personid = '72275488-228c-4a1b-936c-2f56efa643ad'
	and intakeserviceid = 'fe53024a-c706-4a35-964f-93c1a9902e13'
	and activeflag = 1 ;

update intakeservicerequestactor
set activeflag = 0,
	updatedby = 'CDM-35708',
	updatedon = now()
         where personid = '72275488-228c-4a1b-936c-2f56efa643ad'
	and intakeserviceid = 'fe53024a-c706-4a35-964f-93c1a9902e13'
	and activeflag = 1 ;

-- Delete Actor
select *
	from actor
where personid = '72275488-228c-4a1b-936c-2f56efa643ad'
and intakeserviceid  = 'fe53024a-c706-4a35-964f-93c1a9902e13'
	and activeflag = 1 ;
	
update actor
set activeflag = 0,
	updatedby = 'CDM-357081',
	updatedon = now()
where personid = '72275488-228c-4a1b-936c-2f56efa643ad'
and intakeserviceid  = 'fe53024a-c706-4a35-964f-93c1a9902e13'
	and activeflag = 1 ;