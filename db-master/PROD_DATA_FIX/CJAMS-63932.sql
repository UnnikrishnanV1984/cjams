/*
Issue Description:CJAMS-63932
Category/Module: Documents
Root cause: User requested to delete document which was uplaoded by mistake
Fix provided: Data fix has been done to soft delete the document from cjams application.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error.
*/

update cjams.documentproperties
	set activeflag = 0,
		updatedby = 'CJAMS-63932',
		updatedon = now()
	where documentpropertiesid in ('ff582f32-1cab-4798-8eb6-ffc8416ef8a9')
		and activeflag = 1;
		
update cjams.documentattachment
	set activeflag = 0,
		updatedby = 'CJAMS-63932',
		updatedon = now()
	where documentpropertiesid in ('ff582f32-1cab-4798-8eb6-ffc8416ef8a9')
	and activeflag = 1;