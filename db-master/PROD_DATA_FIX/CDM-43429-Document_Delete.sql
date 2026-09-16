/*
 Issue Description:CDM-13429
 Category/ Module: Documents
 Root cause: User requested to delete the documents
 Pull request# N/A
 Reason why no related code fix: User Error
 */

 update documentproperties
set activeflag = 0,
	updatedby = 'CDM-43429',
	updatedon = now()
where documentpropertiesid in ('e2097fd4-8532-454b-bf09-84d3e028fc77','b83954d4-ef43-4efb-b6d5-58bc7e26356f','d8178e66-453c-45d1-81ae-a49b50af747c')
 	  and activeflag = 1 ;
 	  
 	 
update documentattachment
set activeflag = 0,
	updatedby = 'CDM-43429',
	updatedon = now()
where documentpropertiesid in ('e2097fd4-8532-454b-bf09-84d3e028fc77','b83954d4-ef43-4efb-b6d5-58bc7e26356f','d8178e66-453c-45d1-81ae-a49b50af747c')
 	  and activeflag = 1 ;