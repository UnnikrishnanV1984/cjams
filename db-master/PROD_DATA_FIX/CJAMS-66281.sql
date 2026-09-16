 /*
 Issue Description:CJAMS-66281
 Category/ Module: delete document download
 Root cause: user requested to delete the document from documents tab
 Fix provided:Data fix is done to remove the April 2020 IR Physical/ Crisfield/ Police Report document from documents tab
 Pull request# N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
 */
update documentproperties
set activeflag = 0,
	updatedby = 'CJAMS-66281',
	updatedon = now()
where documentpropertiesid ='c16ac93b-c3b9-448f-ba85-92bec561f7a6'
 	  and activeflag = 1 ;
 	  
 	 
update documentattachment
set activeflag = 0,
	updatedby = 'CJAMS-66281',
	updatedon = now()
where documentpropertiesid ='c16ac93b-c3b9-448f-ba85-92bec561f7a6'
 	  and activeflag = 1 ;
