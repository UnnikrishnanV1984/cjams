/*
Issue Description: CJAMS-60391: Data entry error. The wrong documents uploaded into closed CPS case and cannot delete
Category/Module: Intake removal
Root cause: Data fix to delete the respective uploaded document
Data/Code fix ticket#: CJAMS-60391
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Migration issue and correction is needed as a data fix for the issue.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/


update documentproperties
set activeflag = 0,
	updatedby = 'CJAMS-60391',
	updatedon = now()
where documentpropertiesid ='6b0ffe79-71b9-49e4-a67c-3a6d848122b5'
 	  and activeflag = 1 ;
 	  
 	 
update documentattachment
set activeflag = 0,
	updatedby = 'CJAMS-60391',
	updatedon = now()
where documentpropertiesid = '6b0ffe79-71b9-49e4-a67c-3a6d848122b5'
 	  and activeflag = 1 ;