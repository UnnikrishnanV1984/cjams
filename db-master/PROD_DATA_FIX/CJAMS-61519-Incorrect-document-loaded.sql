/*
 Issue Description:CJAMS-61519
 Category/ Module: delete document download
 Root cause: user uploaded document by mistake
 Pull request# N/A
 Reason why no related code fix: N/A
 Status of the code fix if already submitted and expected prod fix date: N/A
 */

update documentproperties
set activeflag = 0,
	updatedby = 'CJAMS-61519',
	updatedon = now()
where documentpropertiesid = '87dedcf6-dae3-47af-b327-6303e8ef4f41'
	and activeflag = 1 ;

update documentattachment
set activeflag = 0,
	updatedby = 'CJAMS-61519',
	updatedon = now()
where documentpropertiesid = '87dedcf6-dae3-47af-b327-6303e8ef4f41'
	and activeflag = 1 ;