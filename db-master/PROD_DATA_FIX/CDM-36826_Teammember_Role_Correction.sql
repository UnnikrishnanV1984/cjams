/*
 * CDM-36826 - Missing Supervisor Id
 * Supervisor Monique Swain not appearing in supervisors dropdwon
 * Focus Area:Service Log
 * Root Cause: Roletype key is mapped to LDSSSP in team member record. It should be CWSP
 * Case ID # 3177073
 * 
 */

update teammember 
	set roletypekey = 'CWSP',
		updatedon=now(), updatedby='CDM-36826'	
	where teammemberid = '29b92f5b-dd1a-4860-9f25-1e96b692fb82' and activeflag = 1 ;

