-- CDM-19634 - 3287805 - HAZEL JACOBS PAYMENTS
/*
-- Issue Description: 
   To change the provider on this GAP case as a Successor Guardian
   
-- Case ID: 3287805
-- Client ID: 4231459 (KEYSHAUN	RAY)- b0db23df-6a98-47d5-a9a4-d2ae555e4c34
-- Provider ID: 5088439	(Claudette Speights) - Local Department Home
-- Successor Guardian Provider ID: 6005003 (Hazel Jacobs) - Local Department Home
-- GAP ID: 5233 - 2019-06-07 To 2022-06-25 - 905fd1ca-a7b7-4c92-956a-e844b940f3be

-- Category/ Module: GAP (Case Management) 
-- Root cause: User error
-- Pull request# N/A 
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A 
*/

/*
1. OLD Provider 5088439 need to be updated with Hazel Jacobs wrongly. 
   We need to revert the Guardian one provider Name back to Claudette Speights.

2. As Claudette Speights is deceased New provider ID 6005003 created to make payment from Nov 1st 2021 to Hazel Jacobs. 
   From CW Application side Need data fix to switch the GAP Primary provider from Claudette Speights to Hazel Jacobs.

3. Claudette-6005002 need to be removed.
*/

-- To Revert the Provider Name change
-- Provider ID: 5088439	(Claudette Speights) - Local Department Home
-- Wrong Name: Hazel Jacobs
select provider_nm, provider_first_nm, provider_middle_nm, provider_last_nm, update_ts, update_user_id
	from prov.tb_provider 
where provider_id = 5088439
	and delete_sw = 'N' ;

Update prov.tb_provider 
set provider_first_nm = 'Claudette',
	provider_last_nm = 'Speights',
	update_ts = now(),
	update_user_id = 'CDM-19634'
where provider_id = 5088439
	and delete_sw  = 'N' ;
	

-- Update GAP Info
select alternateid, gapid, guardianonename, guardianoneid, guardianoneproviderid, primaryrelationshipkey,
	guardiantwoname, guardiantwoid, guardiantwoproviderid, secondaryrelationshipkey,
	updatedby, updatedon
from guardianship 
where gapid = '905fd1ca-a7b7-4c92-956a-e844b940f3be'
	and activeflag = 1 ;

update guardianship 
set guardianonename = 'Hazel Jacobs',
	guardianoneid = 528131, -- (approval_person_id -> tb_prov_approval_person )
	guardianoneproviderid = 6005003,
	-- primaryrelationshipkey = 'guardian', -- current value DACRCHLD
	guardiantwoname = NULL,
	guardiantwoid = NULL, -- (approval_person_id -> tb_prov_approval_person )
	guardiantwoproviderid = NULL,
	secondaryrelationshipkey = NULL,
	updatedby = 'CDM-19634',
	updatedon = now()
where gapid = '905fd1ca-a7b7-4c92-956a-e844b940f3be'
	and activeflag = 1 ;


-- Delete  Duplicate Provider
-- ID: 6005002 (Claudette Speights) - Local Department Home
select provider_id, provider_nm, provider_first_nm, provider_middle_nm, 
		provider_last_nm, update_ts, update_user_id, delete_sw
	from prov.tb_provider 
where provider_id = 6005002
	and delete_sw = 'N' ;

Update prov.tb_provider 
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-19634'
where provider_id = 6005002
	and delete_sw = 'N' ;
	

select address_id, parent_key_id, update_ts, update_user_id, delete_sw 
	from prov.tb_provider_addresses
where parent_key_id = 6005002
	and delete_sw = 'N' ;

update prov.tb_provider_addresses
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-19634'
where parent_key_id = 6005002
	and delete_sw = 'N' ;


select provider_approval_id, update_ts, update_user_id, delete_sw 
	from prov.tb_provider_approval 
where provider_id = 6005002
	and delete_sw = 'N' ;

update prov.tb_provider_approval 
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-19634'
where provider_id = 6005002
	and delete_sw = 'N' ;

select provider_approval_id, person_type_cd, update_ts, update_user_id, delete_sw 
	from prov.tb_prov_approval_person 
where provider_approval_id = 108739
	and delete_sw = 'N' ;

update prov.tb_prov_approval_person 
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-19634'
where provider_approval_id = 108739
	and delete_sw = 'N' ;
	
select provider_service_id, service_id, update_ts, update_user_id, delete_sw 
	from prov.tb_provider_services 
where provider_id = 6005002
	and delete_sw = 'N' ;

update prov.tb_provider_services 
set delete_sw = 'Y',
	update_ts = now(),
	update_user_id = 'CDM-19634'
where provider_id = 6005002
	and delete_sw = 'N' ;
	
select provider_picklist_id, update_ts, update_user_id, delete_sw 
	from prov.tb_provider_picklist 
where provider_id = 6005002
	and delete_sw = 'N' ;

select objectid, updatedon, updatedby, activeflag 
	from prov.providerassignment 
where objectid = '6005002'
	and activeflag = 1 ;
	
update prov.providerassignment 
set activeflag = 0,
	updatedon = now(),
	updatedby = 'CDM-19634'	
where objectid = '6005002'
	and activeflag = 1 ;
