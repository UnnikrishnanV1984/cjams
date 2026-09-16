-- CDM-26288 - OOH Milestone Placements
/*
-- Issue Description: 
   To fix end date discrepancies between Placement and Living Arrangements tables

-- Category/ Module: Accounts Payable (Finance Management)
-- Root cause: TBD
-- Pull request# N/A
-- Reason why no related code fix: 
-- Placement table is havign trigger after update of enddatetime to update Living Arrangement
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Placement End date is null (Active) and LA is closed
select la.activeflag, 
	la.livingid, 
	la.livingstartdate, 
	la.livingenddate, 
	la.livingarrangementtypekey, la.updatedby, la.updatedon,
	(select p.enddatetime 
		from placement p 
	 where p.placementid = la.placementid
	) as placement_enddate
from livingarrangement la 
where la.activeflag = 1 
	and la.placementid 
		in (  select pl.placementid 
				from placement pl,
					livingarrangement la
			  where pl.placementid = la.placementid
				and pl.activeflag = 1
				and la.activeflag = 1
				and la.livingenddate is not null
				and pl.enddatetime is null
            ); 


update livingarrangement la1
set livingenddate = NULL,
	updatedby = 'CDM-26288',
	updatedon = now()
where la1.activeflag = 1 
	and la1.placementid 
		in (  select pl.placementid 
				from placement pl,
					livingarrangement la
			  where pl.placementid = la.placementid
				and pl.activeflag = 1
				and la.activeflag = 1
				and la.livingenddate is not null
				and pl.enddatetime is null
            ); 

-- Placement End date is NOT null (Closed) and LA is Active
select la.activeflag, 
	la.livingid, 
	la.livingstartdate, 
	la.livingenddate, 
	la.livingarrangementtypekey, la.updatedby, la.updatedon,
	(select p.enddatetime 
		from placement p 
	 where p.placementid = la.placementid
	) as placement_enddate
from livingarrangement la 
where la.activeflag = 1 
	and la.placementid 
		in (  select pl.placementid 
				from placement pl,
					livingarrangement la
			  where pl.placementid = la.placementid
				and pl.activeflag = 1
				and la.activeflag = 1
				and la.livingenddate is null
				and pl.enddatetime is not null
            ); 
			
update livingarrangement la1
set livingenddate = (select p.enddatetime 
						from placement p 
					 where p.placementid = la1.placementid
					 ),
	updatedby = 'CDM-26288',
	updatedon = now()
where la1.activeflag = 1 
	and la1.placementid 
		in (  select pl.placementid 
				from placement pl,
					livingarrangement la
			  where pl.placementid = la.placementid
				and pl.activeflag = 1
				and la.activeflag = 1
				and la.livingenddate is null
				and pl.enddatetime is not null
            ); 
