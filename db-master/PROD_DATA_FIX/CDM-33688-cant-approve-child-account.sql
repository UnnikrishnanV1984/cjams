/*
   Issue Description: CDM-33688
   Category/ Module  : Accounts
   Root cause: Approve button not visible for child account disbursement approval
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/ 
	INSERT INTO cjams.userresource
	(	userresourceid, userid, permissiongroupid, roleid, resourceid, 
		activeflag, insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id
	)
VALUES
	(	cjams.gen_random_uuid(), 4812, 'fdc2849c-0a29-4b38-98eb-b08a461e883e', 36, NULL,
		1, 'CDM-33688', now(), 'CDM-33688', now(), true, true, true, NULL
	);

update rolemapping 
set roleid = '1053',
	updatedby = 'CDM-33688', 
	updatedon = now()
where principalid  = '4812'  -- userid from v_userprofile
	and activeflag  = 1
	and teamtypekey = 'CW' ;

Update teammember 
set roletypekey = 'FNSFS',
	updatedon = now(),
	updatedby = 'CDM-33688'
where teammemberid = 'a0000ccd-2c65-4551-9934-0c00bcb3633f' 
	and activeflag  = 1 ;	
