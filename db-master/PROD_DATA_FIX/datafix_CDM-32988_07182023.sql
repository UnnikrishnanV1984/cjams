-- CDM-32988 - Child account
/*
-- Issue Description: 
   User cannot approve a FYS disbursement request
   
-- Client ID: 3757966 (ELIANA ABA WOBILBLANKSON) - c98cbb1b-6fae-4c7d-bedf-0101d34325ad
-- Client Account ID: 1016825 - F100387 - Foster Care Youth Saving
-- Disbursement ID: 1014970 - 2023-06-01 - $1958.81
-- Final Disbursement for finance approval
-- Fowarded To Crystal Stewart - crystal.stewart@montgomerycountymd.gov - e4271184-e42a-4639-88a5-4168eb1814f7
-- LDSS Fiscal Supervisor
	
-- Category/ Module: Purchase Authorization  (Case Management) 
-- Root cause: User setup data issue (Wrong roletypekey in teammember table and roleid in rolemapping table)
-- Fix Provided: Datafix has been promoted to update the Crystal Stewart's role  as FNSFS (LDSS Fiscal Supervisor)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Update roleid as 1053 - FS LDSS - Fiscal Supervisor (old Value 36 - apcs - Supervisor,CW)
select principalid, teamtypekey, roleid, updatedby, updatedon
	from rolemapping 
where principalid  = '4812'  -- userid from v_userprofile
	and activeflag  = 1
	and teamtypekey = 'CW' ;

update rolemapping 
set roleid = '1053',
	updatedby = 'CDM-32988', 
	updatedon = now()
where principalid  = '4812'  -- userid from v_userprofile
	and activeflag  = 1
	and teamtypekey = 'CW' ;

-- Update roletypekey = FNSFS (Old Values: CWSP)
select roletypekey, description, updatedby, updatedon  
	from teammember
where teammemberid = 'b56a53e6-45a6-4a5b-85c2-3c1a1dd7f444' 
	and activeflag  = 1 ;

Update teammember 
set roletypekey = 'FNSFS',
	updatedon = now(),
	updatedby = 'CDM-32988'
where teammemberid = 'b56a53e6-45a6-4a5b-85c2-3c1a1dd7f444' 
	and activeflag  = 1 ;	

-- Fix userresource Data
-- Delete 
select permissiongroupid, roleid, activeflag, updatedby, updatedon
	from userresource 
where userid = '4812' 
	and activeflag = 1
	and permissiongroupid in (  'fb335234-73b2-4d01-92ee-6b33cdf6fbd6', -- Read_only_access
								'a1cbfa86-6350-4f9a-a492-ddd9f82fa012' -- IV-E SUPERVISOR, IV-E
							 );

update userresource
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CDM-32988'
where userid = '4812' 
	and activeflag = 1
	and permissiongroupid in (  'fb335234-73b2-4d01-92ee-6b33cdf6fbd6', -- Read_only_access
								'a1cbfa86-6350-4f9a-a492-ddd9f82fa012' -- IV-E SUPERVISOR, IV-E
							 );
							 
-- Add fdc2849c-0a29-4b38-98eb-b08a461e883e	CW SUPERVISOR
delete from cjams.userresource where insertedby	= 'CDM-32988';	
		
INSERT INTO cjams.userresource
	(	userresourceid, userid, permissiongroupid, roleid, resourceid, 
		activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id
	)
VALUES
	(	cjams.gen_random_uuid(), 4812, 'fdc2849c-0a29-4b38-98eb-b08a461e883e', 36, NULL,
		1, 'CDM-32988', now(), 'CDM-32988', now(), true, true, true, NULL
	);

		
-- Update Final Disbursement for finance approval - fromroleid as FNSFS (old value CWCW) 
select remarks, routingstatustypeid, activeflag, fromroleid, updatedby, updatedon
	from routing
where routingid = '923fe478-15c6-4f4f-b14c-6d021a07a4bc'
	and activeflag = 1 ;

update routing
set fromroleid = 'FNSFS',
	updatedon = now(),
	updatedby = 'CDM-32988'
where routingid = '923fe478-15c6-4f4f-b14c-6d021a07a4bc'
	and activeflag = 1 ;
