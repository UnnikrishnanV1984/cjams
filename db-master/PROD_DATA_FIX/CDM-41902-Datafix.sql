/*
  Issue Description:  CDM-41902
   Category/ Module  :  Assignments
   Root cause: All of the accounts are disabled in sailpoint. Please deactivate them in cjams db as well
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

update userprofile set activeflag = 0, updatedby = 'CDM-41902', updatedon = now() 
where securityusersid in ('1620bc37-b5bc-4794-afb0-1c23ced69e8c','5681c4d7-6245-4173-8c7d-c04e67635a42','9770057e-0f03-4269-86d0-6fbd83db1b12',
'2b16a355-d7a6-47eb-a871-ee461e112327','e1a8200f-24fe-4375-8a0f-e0cbaff80ec3','bf68418b-9c32-42de-8ec1-5db8cabd2c3a','38e58316-d47d-48c2-97f9-f28e6981f477','9b652524-3318-4bfa-a8b6-0caf60a59c79') 
and activeflag = 1;

update muser set activeflag = 0, updatedby = 'CDM-41902', updatedon = now() 
where securityusersid in ('1620bc37-b5bc-4794-afb0-1c23ced69e8c','5681c4d7-6245-4173-8c7d-c04e67635a42','9770057e-0f03-4269-86d0-6fbd83db1b12',
'2b16a355-d7a6-47eb-a871-ee461e112327','e1a8200f-24fe-4375-8a0f-e0cbaff80ec3','bf68418b-9c32-42de-8ec1-5db8cabd2c3a','38e58316-d47d-48c2-97f9-f28e6981f477','9b652524-3318-4bfa-a8b6-0caf60a59c79')  and activeflag = 1;

update cjams.securityusers set activeflag=0, updatedby='CDM-41902', updatedon=now()  
where securityusersid in ('1620bc37-b5bc-4794-afb0-1c23ced69e8c','5681c4d7-6245-4173-8c7d-c04e67635a42','9770057e-0f03-4269-86d0-6fbd83db1b12',
'2b16a355-d7a6-47eb-a871-ee461e112327','e1a8200f-24fe-4375-8a0f-e0cbaff80ec3','bf68418b-9c32-42de-8ec1-5db8cabd2c3a','38e58316-d47d-48c2-97f9-f28e6981f477','9b652524-3318-4bfa-a8b6-0caf60a59c79') and activeflag = 1;

update cjams.teammemberassignment set activeflag=0, updatedby='CDM-41902', updatedon=now() 
where securityusersid in ('1620bc37-b5bc-4794-afb0-1c23ced69e8c','5681c4d7-6245-4173-8c7d-c04e67635a42','9770057e-0f03-4269-86d0-6fbd83db1b12',
'2b16a355-d7a6-47eb-a871-ee461e112327','e1a8200f-24fe-4375-8a0f-e0cbaff80ec3','bf68418b-9c32-42de-8ec1-5db8cabd2c3a','38e58316-d47d-48c2-97f9-f28e6981f477','9b652524-3318-4bfa-a8b6-0caf60a59c79') and activeflag = 1;

UPDATE teammember
	SET activeflag = 0,
		updatedby = 'CDM-41902',
		updatedon = now()
	WHERE teammemberid IN (
		select tm.teammemberid 
			from userprofile up 
				join teammemberassignment tma on tma.securityusersid = up.securityusersid  
				join teammember tm on tm.teammemberid = tma.teammemberid and tm.activeflag = 1
			where up.securityusersid in ('1620bc37-b5bc-4794-afb0-1c23ced69e8c','5681c4d7-6245-4173-8c7d-c04e67635a42','9770057e-0f03-4269-86d0-6fbd83db1b12',
			'2b16a355-d7a6-47eb-a871-ee461e112327','e1a8200f-24fe-4375-8a0f-e0cbaff80ec3','bf68418b-9c32-42de-8ec1-5db8cabd2c3a','38e58316-d47d-48c2-97f9-f28e6981f477','9b652524-3318-4bfa-a8b6-0caf60a59c79'));
			
			UPDATE rolemapping
	SET updatedon = now(),
		updatedby = 'CDM-41902',
		activeflag = 0
	WHERE principalid::integer IN (select id from muser 
										WHERE securityusersid in ('1620bc37-b5bc-4794-afb0-1c23ced69e8c','5681c4d7-6245-4173-8c7d-c04e67635a42','9770057e-0f03-4269-86d0-6fbd83db1b12',
										'2b16a355-d7a6-47eb-a871-ee461e112327','e1a8200f-24fe-4375-8a0f-e0cbaff80ec3','bf68418b-9c32-42de-8ec1-5db8cabd2c3a','38e58316-d47d-48c2-97f9-f28e6981f477','9b652524-3318-4bfa-a8b6-0caf60a59c79'));
							
