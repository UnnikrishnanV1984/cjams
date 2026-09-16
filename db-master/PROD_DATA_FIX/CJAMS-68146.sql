/*
 Issue Description:CJAMS-68146
 Category/ Module: delete document download
 Root cause: user requested to delete the document from documents tab as it was stuck somehow the flag in DB was wrongly set , other worker was able to upload the video successfully
 Fix provided:Data fix is done to remove the  document from documents tab
 Pull request# N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
 */
update documentproperties
set activeflag = 0,
	updatedby = 'CJAMS-68146',
	updatedon = now()
where documentpropertiesid ='491cc364-5ff3-4578-bf1f-820b696c5bf0';
 	  
 	 
update documentattachment
set activeflag = 0,
	updatedby = 'CJAMS-68146',
	updatedon = now()
where documentpropertiesid ='491cc364-5ff3-4578-bf1f-820b696c5bf0'
 	  and activeflag = 1 ;