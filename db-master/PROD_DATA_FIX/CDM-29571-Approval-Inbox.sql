/*
   Issue Description: CDM-29571
   Category/ Module  : Supervisor Approval Inbox
   Root cause: user has 18 approvals in her inbox that have been approved but will not drop off her approval inbox.
   Pull request# for code fix: 8410
   Reason why no related code fix: data fix
   
*/

 update
	routing
set
	activeflag = 0,
	updatedby = 'CDM-29571',
	updatedon = now()
where
	routingid in ('a05302ce-334d-46bb-ab98-a10bc60d1033',
	'fb9d81e8-ec3d-4a82-af21-1a941c72e80c',
	'b5f66736-ee13-4979-8978-0a40a6b28c86',
	'bab25815-ee0d-4c9f-ba3e-e851f1bffc6e',
	'270f7a0f-735c-47e6-866c-98b02350be32',
	'425e4746-ff9e-4526-aadc-6561611f13d5',
	'aecee234-2053-4351-a58d-b8342b44809c',
	'78fc3fee-7236-4604-8734-d821a110c75e',
	'9e5af910-a7c6-460d-b438-78c6b09dc75b',
	'cbcf887a-e220-402e-9e74-4de85ce25272',
	'c16ef604-6b11-4746-bd2c-b740091fb2ae',
	'de2c5508-d33b-4a78-8def-0e6c8249ff71',
	'92f1c874-c360-4e51-9191-09f2221d2668',
	'56919d64-1155-4f37-a9ff-dc1790327c56')
	and activeflag = 1;