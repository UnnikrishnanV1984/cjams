-- CDM-27230 - Wrong person listing
/*
-- Issue Description: 
   Purchase authorizations are switching the client name from Dakota Davis to Robert Buxenstein

-- Category/ Module: Service Log/Purchase Authorization (Case Management) 
-- Original Root Cause: Data Migration Issue, 2 person records migrated to CJAMS with same Client ID (cjamspid). 
-- One is actual client (DAKOTA DANIEL DAVIS) and other record is for un-confirmed person (ROBERT BUXENSTEIN).
-- Fix Provided as a part of CDM-27341 to generate new Client ID (cjamspid) for ROBERT BUXENSTEIN - 200996496
-- Root Cause: CJAMS is dipalying the Purchase Authorization data on the report from Sanpshot table.
--			   And in the snapshot table the Client name is saved as ROBERT BUXENSTEIN.	
-- Fix Provided: Datafix has been provided to update the Client Name as DAKOTA DAVIS
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Datafix to update client name in snapshot table (CDM-27230)
select authorization_id, slpa_snapshot_id, client_id, client_name, update_ts, update_user_id 
	from tb_slpa_snapshot
where client_id = 31990
	and upper(client_name) = 'ROBERT  BUXENSTEIN';

update tb_slpa_snapshot
set client_name = 'DAKOTA DANIEL DAVIS',
	update_ts = now(), 
	update_user_id = 'CDM-27230'
where client_id = 31990 
	and upper(client_name) = 'ROBERT  BUXENSTEIN';