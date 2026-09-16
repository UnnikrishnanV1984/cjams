/* 
    Issue Description: CDM-38490
   Category/ Module  : USER NEEDS NAMES REMOVED FROM CJAMS WORKLOAD
   Root cause: Vera Montgomery - offboarded  11/30/23 vera.montgomery@maryland.gov and In Home #2: Jalesa Byes offboardded 
   2/1/24 should remove from CJAMS Workload
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    void the rejected provider placement from backend
*/

--Vera Montgomery
UPDATE userprofile
	SET activeflag = 0,
		updatedby = 'CDM-38490',
		updatedon = now()
	WHERE securityusersid = '07e7bc36-c2fb-4198-a6e9-4a40e9f197be'
		AND activeflag = 1;
	
UPDATE muser
	SET activeflag = 0,
		updatedby = 'CDM-38490',
		updatedon = now()
	WHERE securityusersid = '07e7bc36-c2fb-4198-a6e9-4a40e9f197be'
		AND activeflag = 1;
		
UPDATE rolemapping 
	SET activeflag = 0, 
		updatedby = 'CDM-38490', 
		updatedon = now()
	WHERE principalid IN (select id::character varying 
							from muser 
							where securityusersid = '07e7bc36-c2fb-4198-a6e9-4a40e9f197be') 
		                    and activeflag = 1;	


UPDATE teammember
	SET activeflag = 0,
		updatedby = 'CDM-38490',
		updatedon = now()
	WHERE teammemberid IN (
		select tm.teammemberid 
			from userprofile up 
				join teammemberassignment tma on tma.securityusersid = up.securityusersid  
				join teammember tm on tm.teammemberid = tma.teammemberid and tm.activeflag = 1
			where up.securityusersid = '07e7bc36-c2fb-4198-a6e9-4a40e9f197be')
		and activeflag = 1;

	
UPDATE teammemberassignment
	SET activeflag = 0,
		updatedby = 'CDM-38490',
		updatedon = now()
	WHERE teammemberassignmentid IN (
		select tma.teammemberassignmentid 
			from userprofile up 
				join teammemberassignment tma on tma.securityusersid = up.securityusersid  and tma.activeflag = 1
			where up.securityusersid = '07e7bc36-c2fb-4198-a6e9-4a40e9f197be')
		and activeflag = 1;		
		
	
	
--Jalesa byes	
	
	UPDATE userprofile
	SET activeflag = 0,
		updatedby = 'CDM-38490',
		updatedon = now()
	WHERE securityusersid = '384f227c-9fee-4c95-bb00-744e0d2c08f1'
		AND activeflag = 1;
	
UPDATE muser
	SET activeflag = 0,
		updatedby = 'CDM-38490',
		updatedon = now()
	WHERE securityusersid = '384f227c-9fee-4c95-bb00-744e0d2c08f1'
		AND activeflag = 1;
	
	
UPDATE rolemapping 
	SET activeflag = 0, 
		updatedby = 'CDM-38490', 
		updatedon = now()
	WHERE principalid IN (select id::character varying 
							from muser 
							where securityusersid = '384f227c-9fee-4c95-bb00-744e0d2c08f1') 
		                    and activeflag = 1;	


UPDATE teammember
	SET activeflag = 0,
		updatedby = 'CDM-38490',
		updatedon = now()
	WHERE teammemberid IN (
		select tm.teammemberid 
			from userprofile up 
				join teammemberassignment tma on tma.securityusersid = up.securityusersid  
				join teammember tm on tm.teammemberid = tma.teammemberid and tm.activeflag = 1
			where up.securityusersid = '384f227c-9fee-4c95-bb00-744e0d2c08f1')
		and activeflag = 1;

	
UPDATE teammemberassignment
	SET activeflag = 0,
		updatedby = 'CDM-38490',
		updatedon = now()
	WHERE teammemberassignmentid IN (
		select tma.teammemberassignmentid 
			from userprofile up 
				join teammemberassignment tma on tma.securityusersid = up.securityusersid  and tma.activeflag = 1
			where up.securityusersid = '384f227c-9fee-4c95-bb00-744e0d2c08f1')
		and activeflag = 1;
