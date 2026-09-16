/*
-- Issue Description: 
    the client name has been changed on 10/28/2025 and the client name still displayed as the old name when creating a new purchase authorization.
    Purchase authorization is created on 10/21/2025 and approved on 10/28/2025 so system will pulling the new client name as the client name is changed to the new name on 10/28/2025.--  Case# 3299565, Client ID: 4040404 (TASHAMERE CARTER), 
-- Category/ Module: Service Log (Case Management) 
-- Root cause: User Request, The funding approval happened before the name changes got into effect.  
-- Fix Provided: Datafix has been promoted to update the name in the PA pdf
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

--select update_ts ,create_ts ,* from tb_slpa_snapshot tss where client_name ilike '%isabella  jackson%'
--order by update_ts desc;

UPDATE cjams.tb_slpa_snapshot
SET client_name ='Bella''Rae Nicole Gowans',
	update_user_id='CJAMS-63573',
	update_ts =now() 
WHERE authorization_id  = 3895382
	and client_id = '3423604';