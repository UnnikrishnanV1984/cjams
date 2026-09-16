/*
Issue Description:CJAMS-63831
Category/Module: Documents
Root cause: User uploaded video files and they are showing in pending status. Later user uploaded the same files again. 
			Now user requested to delete files with upload penidng status
Fix provided: Data fix has been done to soft delete the pending documents from cjams application.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User was able to upload documents later.
*/

update cjams.documentproperties
	set activeflag = 0,
		updatedby = 'CJAMS-63831',
		updatedon = now()
	where documentpropertiesid in (
			'a4a5b4d1-de1b-4782-9633-3a4d18c63296',
			'7231cff4-3f71-4a54-afe6-887ef3b5055e',
			'92ed2027-714b-4b66-a5a5-88a2fa18c033',
			'6dbbae04-32dc-41a7-b331-49c3c2070d0e',
			'35f98bc7-d6e0-4c54-b71f-c3fbedcb14d9',
			'1eb1db44-0d9d-448e-93fc-e17f5f5c8387',
			'9ac5732e-ae48-4688-9bed-6a15c7bd03ca',
			'db6900d3-558d-4bb6-90ee-73c810ea6912',
			'67c8f79f-240d-4738-b2ff-bb0de3aaf318',
			'728e0f71-20de-4131-b0d5-773ec8a27772')
		and activeflag = 3;
		
update cjams.documentattachment
	set activeflag = 0,
		updatedby = 'CJAMS-63831',
		updatedon = now()
	where documentpropertiesid in (
			'a4a5b4d1-de1b-4782-9633-3a4d18c63296',
			'7231cff4-3f71-4a54-afe6-887ef3b5055e',
			'92ed2027-714b-4b66-a5a5-88a2fa18c033',
			'6dbbae04-32dc-41a7-b331-49c3c2070d0e',
			'35f98bc7-d6e0-4c54-b71f-c3fbedcb14d9',
			'1eb1db44-0d9d-448e-93fc-e17f5f5c8387',
			'9ac5732e-ae48-4688-9bed-6a15c7bd03ca',
			'db6900d3-558d-4bb6-90ee-73c810ea6912',
			'67c8f79f-240d-4738-b2ff-bb0de3aaf318',
			'728e0f71-20de-4131-b0d5-773ec8a27772')
	and activeflag = 1;