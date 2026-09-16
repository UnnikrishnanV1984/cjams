-- CDM-26010 - Profile
/*
-- Issue Description: 
	User having read only access for IV-E login

-- Bomani Ivy - 3303 - 4d70317b-d9fd-4d3e-99e6-2df003321896	
-- bomani.ivy@maryland.gov

-- Category/ Module: User Access Profile (User Management) 
-- Root cause: N/A
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To remove Read_only_access and CENTRAL POLICY STAFF permission groups
select userresourceid, userid, permissiongroupid, activeflag, updatedby, updatedon
	from cjams.userresource
where userid = 3303
	and activeflag = 1
	and permissiongroupid in (	'9f0a99a4-08ae-43ee-ba78-cb8e52a818da',
								'fb335234-73b2-4d01-92ee-6b33cdf6fbd6'
							 );

update cjams.userresource 
set activeflag = 0, 
	updatedby = 'CDM-26010', 
	updatedon = now() 
where userid = 3303
	and activeflag = 1
	and permissiongroupid in (	'9f0a99a4-08ae-43ee-ba78-cb8e52a818da',
								'fb335234-73b2-4d01-92ee-6b33cdf6fbd6'
							 ) ;
