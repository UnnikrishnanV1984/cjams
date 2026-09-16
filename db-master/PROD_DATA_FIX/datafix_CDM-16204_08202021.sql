-- CDM-16204 - Data Fix Baltimore city Closed Removal with no exit Reason
/*
-- Issue Description: 
   Datafix to update the Removal Exist reasons provided by the Business users 
   for Baltimore city closed Removals.
    
-- Category/ Module: Child Removal (Case Management) 
-- Root cause: User Error (Data Issue) 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update Removal Exit Reason - REUNIF	Reunification
select removalid, removaldate, exitdate, removalexitreason, updatedby, updatedon, activeflag 
	from intakeservreqchildremoval  
where removalid  
	in ( 
		251401, 251140, 252286, 252283, 251351, 252234, 252285, 251473, 251844, 250749, 
		251835, 251837, 251715, 250677, 251836, 251374, 251375, 251028, 251242, 252339,
		251664, 252340, 252287, 252031
		)
	and activeflag  = 1 ;

update intakeservreqchildremoval
set removalexitreason = 'REUNIF',
	updatedby = 'CDM-16204',
	updatedon = now()
where removalid  
	in ( 
		251401, 251140, 252286, 252283, 251351, 252234, 252285, 251473, 251844, 250749, 
		251835, 251837, 251715, 250677, 251836, 251374, 251375, 251028, 251242, 252339,
		251664, 252340, 252287, 252031
		)
	and activeflag  = 1 ;
	
-- Delete Duplicate removal (No associated placement) 	
select eventcode, routingstatustypeid, remarks, updatedby, updatedon, activeflag 
	from routing 
where eventcode = 'CHRR'
	and activeflag = 1
	and objectid 
		in ( select intakeservreqchildremovalid::character varying
				from intakeservreqchildremoval  
			 where removalid in ( 251453, 251637 )
				and activeflag  = 1
			) ;

update routing
set activeflag = 0,
	updatedby = 'CDM-16204',
	updatedon = now()
where eventcode = 'CHRR'
	and activeflag = 1
	and objectid 
		in ( select intakeservreqchildremovalid::character varying
				from intakeservreqchildremoval  
			 where removalid in ( 251453, 251637 )
				and activeflag  = 1
			) ;

select intakeservreqchildremovalid, removalid, removaldate, exitdate, removalexitreason, updatedby, updatedon, activeflag 
	from intakeservreqchildremoval 
where removalid in ( 251453, 251637	)
	and activeflag  = 1 ;

update intakeservreqchildremoval
set activeflag = 0,
	updatedby = 'CDM-16204',
	updatedon = now()
where removalid in ( 251453, 251637	)
	and activeflag  = 1 ;

