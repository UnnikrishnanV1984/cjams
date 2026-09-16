-- CDM-33181 - CLONE - Permanency Plan not listing parent names
/*
-- Issue Description: 
	 Permanency Plan data fix to update Parent 1 Name and Parent 2 Name columns with personid

-- Category/ Module: Permanency Plan(Case Management)
-- Root cause: Permanency Plan design change 
-- Fix Provided: Datafix has been promoted to update Start and End date of the requested Permanency Plan
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Permanency Plan mass update for update Parent 1 and Parent 2 columns (CDM-33181)

-- Parent 1 
select pp.permanencyplanid, pp.parentname, pp.activeflag, pp.updatedby, pp.updatedon
	from permanencyplan pp
where pp.parentname is not null
	and pp.activeflag = 1 
	and (select count(*)
			from intakeservicerequestactor icr
		 where icr.intakeservicerequestactorid = pp.parentname
	    ) > 0 ;


update cjams.permanencyplan pp
set parentname = ( select icr.personid
					from intakeservicerequestactor icr
				   where icr.intakeservicerequestactorid = pp.parentname
				 )
	-- updatedby = 'CDM-33181',
	-- updatedon = now()
where pp.parentname is not null
	and pp.activeflag = 1 
	and (select count(*)
			from intakeservicerequestactor icr
		 where icr.intakeservicerequestactorid = pp.parentname
	    ) > 0 ;

select pp.permanencyplanid, pp.parentname, pp.activeflag, pp.updatedby, pp.updatedon
	from permanencyplan_history pp
where pp.parentname is not null
	and pp.activeflag = 1 
	and (select count(*)
			from intakeservicerequestactor icr
		 where icr.intakeservicerequestactorid = pp.parentname
	    ) > 0 ;


update cjams.permanencyplan_history pp
set parentname = ( select icr.personid
					from intakeservicerequestactor icr
				   where icr.intakeservicerequestactorid = pp.parentname
				 )
	-- updatedby = 'CDM-33181',
	-- updatedon = now()
where pp.parentname is not null
	and pp.activeflag = 1 
	and (select count(*)
			from intakeservicerequestactor icr
		 where icr.intakeservicerequestactorid = pp.parentname
	    ) > 0 ;
		
-- Parent 2 
select pp.permanencyplanid, pp.parent2name, pp.activeflag, pp.updatedby, pp.updatedon
	from permanencyplan pp
where pp.parent2name is not null
	and pp.activeflag = 1 
	and (select count(*)
			from intakeservicerequestactor icr
		 where icr.intakeservicerequestactorid = pp.parent2name
	    ) > 0 ;

update cjams.permanencyplan pp
set parent2name = ( select icr.personid
					from intakeservicerequestactor icr
				   where icr.intakeservicerequestactorid = pp.parent2name
				 )
	-- updatedby = 'CDM-33181',
	-- updatedon = now()
where pp.parent2name is not null
	and pp.activeflag = 1 
	and (select count(*)
			from intakeservicerequestactor icr
		 where icr.intakeservicerequestactorid = pp.parent2name
	    ) > 0 ;

select pp.permanencyplanid, pp.parent2name, pp.activeflag, pp.updatedby, pp.updatedon
	from permanencyplan_history pp
where pp.parent2name is not null
	and pp.activeflag = 1 
	and (select count(*)
			from intakeservicerequestactor icr
		 where icr.intakeservicerequestactorid = pp.parent2name
	    ) > 0 ;

update cjams.permanencyplan_history pp
set parent2name = ( select icr.personid
					from intakeservicerequestactor icr
				   where icr.intakeservicerequestactorid = pp.parent2name
				 )
	-- updatedby = 'CDM-33181',
	-- updatedon = now()
where pp.parent2name is not null
	and pp.activeflag = 1 
	and (select count(*)
			from intakeservicerequestactor icr
		 where icr.intakeservicerequestactorid = pp.parent2name
	    ) > 0 ;		