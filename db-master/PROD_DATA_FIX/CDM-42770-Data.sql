/*
 Issue Description:  CDM-42770
 Category/ Module: Approval Dashboard
 Root cause:Users left the organisation and their details were deleted in sailpoint, corresponding deletion in the cjams databases was affected
 Pull request# for code fix: NA
 Reason why no related code fix: For deleting the users from CJAMS data fix is needed
 Status of the code fix if already submitted and expected prod fix date: NO
 Backup before update/ delete: NA
 */
update
    userprofile
set
    activeflag = 0,
    updatedby = 'CDM-42770',
    updatedon = now()
where
    securityusersid in (
        'f4037169-c70f-422e-8a3b-e9385f5065f9',
        'a9e87fc5-d184-4073-8b13-bdb117c25eb5'
    )
    and activeflag = 1;

update
    muser
set
    activeflag = 0,
    updatedby = 'CDM-42770',
    updatedon = now()
where
    securityusersid in (
        'f4037169-c70f-422e-8a3b-e9385f5065f9',
        'a9e87fc5-d184-4073-8b13-bdb117c25eb5'
    )
    and activeflag = 1;


    	
UPDATE securityusers
	SET activeflag = 0,
		updatedby = 'CDM-42770',
		updatedon = now()
	WHERE  
		securityusersid in (
        'f4037169-c70f-422e-8a3b-e9385f5065f9',
        'a9e87fc5-d184-4073-8b13-bdb117c25eb5'
    )
    and activeflag = 1;
	
UPDATE rolemapping 
	SET activeflag = 0, updatedby = 'CDM-42770', updatedon = now()
	WHERE principalid in ('4711','12800') and teamtypekey = 'CW' and activeflag = 1;	
	
UPDATE teammember
	SET activeflag = 0,
		updatedby = 'CDM-42770',
		updatedon = now()
	WHERE teammemberid IN (
		select tm.teammemberid 
			from userprofile up 
				join teammemberassignment tma on tma.securityusersid = up.securityusersid  
				join teammember tm on tm.teammemberid = tma.teammemberid and tm.activeflag = 1
			where up.securityusersid  in ('f4037169-c70f-422e-8a3b-e9385f5065f9',
        'a9e87fc5-d184-4073-8b13-bdb117c25eb5'));
			
UPDATE teammemberassignment
	SET activeflag = 0,
		updatedby = 'CDM-42770',
		updatedon = now()
	WHERE teammemberassignmentid IN (
		select tma.teammemberassignmentid 
			from userprofile up 
				join teammemberassignment tma on tma.securityusersid = up.securityusersid  and tma.activeflag = 1
			where up.securityusersid in ('f4037169-c70f-422e-8a3b-e9385f5065f9',
        'a9e87fc5-d184-4073-8b13-bdb117c25eb5'));