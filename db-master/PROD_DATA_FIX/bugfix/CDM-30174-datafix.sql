/*
-- Issue Description: 
-- Category/ Module: Approval Inbox 
-- Root cause: data fix
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


update routing	
set activeflag = 0,
	updatedon = now(), 
	updatedby = 'CDM-30174'
where routingid in ('f86e0039-8b36-4b5e-bd6c-36faec943a25',
'1fef36c0-7769-4afa-8960-51428231c351',
'681697e3-eea1-44d2-b71e-f8170c6d37c1',
'c16c771c-a4a8-4ead-a17a-bd87562fe1ff',
'66720f5b-8263-4e21-b270-183e430a4fe8',
'131b6c11-f6dd-4070-8006-e9dbe49dd6c3',
'77a881f9-5cad-44da-863a-7314ed01e48d',
'836da717-c32a-418b-8f65-fe8941f5220d',
'cdfc15d8-84bf-4be7-9e3e-ebc7cf213eb4',
'8dc6a624-ebf4-4c0a-b66a-eeb39cb796f0');