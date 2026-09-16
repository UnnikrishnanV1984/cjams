-- CIDM-4323 LJ Reports - Data Cleanup of duplicate/overlapping removals 
/*
-- Issue Description: 
   Data Cleanup of duplicate/overlapping removals which are either in the Draft or Review Status (un-approved removals).
    
-- Category/ Module: Child Removal (Case Management) 
-- Root cause: Data Issue 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update Active Removal ID in the placement table 
-- Removal ID: 252925 - bde9c831-8f47-489b-9489-c44e27a8b268
select alternateid, placementtypekey, altproviderid, intakeservreqchildremovalid, updatedby, updatedon 
	from placement
where intakeservreqchildremovalid = 'bde9c831-8f47-489b-9489-c44e27a8b268'
	and activeflag = 1 ;

update placement
set intakeservreqchildremovalid = '0bff5eb8-a77f-4784-a30d-11630965b862', -- 251839
	updatedon = now(), 
	updatedby = 'CIDM-4323'
where intakeservreqchildremovalid = 'bde9c831-8f47-489b-9489-c44e27a8b268'
	and activeflag = 1 ;
	
-- Removal ID: 250818 - 14c47726-5409-492e-b40b-4fffce390689
select alternateid, placementtypekey, altproviderid, intakeservreqchildremovalid, updatedby, updatedon 
	from placement
where intakeservreqchildremovalid = '14c47726-5409-492e-b40b-4fffce390689'
	and activeflag = 1 ;

update placement
set intakeservreqchildremovalid = 'f1592e5c-069c-4e20-ae7a-2fe6c6f72452', -- 250655
	updatedon = now(), 
	updatedby = 'CIDM-4323'
where intakeservreqchildremovalid = '14c47726-5409-492e-b40b-4fffce390689'
	and activeflag = 1 ;


-- Delete in Draft - with NO routing and NO placements
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid 
	in (
			251651, 253453, 253007, 250480, 250479, 250358, 253031, 251032, 250466, 250467,
			252719, 250929, 250930, 252749, 251895, 252866, 252733, 252802, 252989, 250359,
			253258, 250736, 251799, 251013, 252466, 252875, 252884, 252877, 252360, 252361,
			251899, 252465, 250493, 250495, 250497, 250496, 250494, 250492, 250735, 250390,
			251450, 252556, 253157, 250490, 253018, 252925, 253274, 251896, 252876, 253257,
			251513, 251514, 252969, 252996, 252997, 252623, 250334, 253337, 250418, 250417,
			250818, 250824, 250811, 250816, 251298, 252609, 253345, 253349, 252535, 252018,
			252841, 253052, 251955, 253313, 252177, 253024, 252724, 252721, 253355, 253406,
			253256, 253419, 253356, 253408, 252990, 252938, 252978
		)

	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;

update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CIDM-4323',
	rm.updatedon = now() 		
where rm.removalid 
	in (
			251651, 253453, 253007, 250480, 250479, 250358, 253031, 251032, 250466, 250467,
			252719, 250929, 250930, 252749, 251895, 252866, 252733, 252802, 252989, 250359,
			253258, 250736, 251799, 251013, 252466, 252875, 252884, 252877, 252360, 252361,
			251899, 252465, 250493, 250495, 250497, 250496, 250494, 250492, 250735, 250390,
			251450, 252556, 253157, 250490, 253018, 252925, 253274, 251896, 252876, 253257,
			251513, 251514, 252969, 252996, 252997, 252623, 250334, 253337, 250418, 250417,
			250818, 250824, 250811, 250816, 251298, 252609, 253345, 253349, 252535, 252018,
			252841, 253052, 251955, 253313, 252177, 253024, 252724, 252721, 253355, 253406,
			253256, 253419, 253356, 253408, 252990, 252938, 252978
		)

	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode  = 'CHRR'
			and ro.objectid  = rm.intakeservreqchildremovalid::character varying 
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
		
		
-- Delete in Review - with NO Approved routing and NO placements
select rm.removalid, rm.removaldate, rm.exitdate, rm.activeflag, rm.updatedby, rm.updatedon 
	from intakeservreqchildremoval rm 
where rm.removalid in ( 253467, 252250, 253576, 251596, 253451 )
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode = 'CHRR'
			and ro.objectid = rm.intakeservreqchildremovalid::character varying 
			and ro.routingstatustypeid = 16
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
	
update intakeservreqchildremoval rm
set rm.activeflag = 0,
	rm.updatedby = 'CIDM-4323',
	rm.updatedon = now() 		
where rm.removalid in ( 253467, 252250, 253576, 251596, 253451 )
	and rm.activeflag = 1
	and ( select count(*)
			from routing ro 
		  where ro.eventcode = 'CHRR'
			and ro.objectid = rm.intakeservreqchildremovalid::character varying 
			and ro.routingstatustypeid = 16
			and ro.activeflag = 1
		) = 0 
	and ( select count(*)
			from placement pl 
		  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
			and pl.activeflag = 1
		) = 0;
	

-- Delete Routing 
select activeflag, routingstatustypeid, remarks, updatedby, updatedon
	from routing ro 
where ro.eventcode  = 'CHRR'
	and ro.activeflag = 1 
	and ro.objectid 
	in ( select rm.intakeservreqchildremovalid::character varying 
			from intakeservreqchildremoval rm 
		where rm.removalid in ( 253467, 252250, 253576, 251596, 253451 )
			and rm.activeflag = 1
			and ( select count(*)
					from routing ro 
				  where ro.eventcode = 'CHRR'
					and ro.objectid = rm.intakeservreqchildremovalid::character varying 
					and ro.routingstatustypeid = 16
					and ro.activeflag = 1
				) = 0 
			and ( select count(*)
					from placement pl 
				  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
					and pl.activeflag = 1
				) = 0
		);	
	
update routing ro
set ro.activeflag = 0,
	ro.updatedby = 'CIDM-4323',
	ro.updatedon = now()	
where ro.eventcode  = 'CHRR'
	and ro.activeflag = 1 
	and ro.objectid 
	in ( select rm.intakeservreqchildremovalid::character varying 
			from intakeservreqchildremoval rm 
		where rm.removalid in ( 253467, 252250, 253576, 251596, 253451 )
			and rm.activeflag = 1
			and ( select count(*)
					from routing ro 
				  where ro.eventcode = 'CHRR'
					and ro.objectid = rm.intakeservreqchildremovalid::character varying 
					and ro.routingstatustypeid = 16
					and ro.activeflag = 1
				) = 0 
			and ( select count(*)
					from placement pl 
				  where pl.intakeservreqchildremovalid = rm.intakeservreqchildremovalid
					and pl.activeflag = 1
				) = 0
		);
		
-- Removal ID: 253584 Approved on 02/25		
