/*
 Issue Description: CDM-36362
 Category/ Module : Assessments
 Root cause: Assessments are not loading for user as team member table contains LDSS role.
 Fix: Update team member record with CWSP role, which is in sync with sailpoint roles.
 Pull request# for code fix: N/A
 Reason why no related code fix: 
 Need to do data fix
 */
 
update teammember 
	set roletypekey = 'CWSP',  ---old role LDSSSP
		updatedon = now(),
		updatedby = 'CDM-36362'
	where teammemberid = '69c62732-5ad3-4c4c-be52-67cd18b84133';