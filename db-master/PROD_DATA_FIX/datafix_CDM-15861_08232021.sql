-- CDM-15861 - Provider Name Change
/*
-- Issue Description: 
   Request to update 2 Public Provider Names
   # 5007447 - Genia Grimes (old Name: Genia Friia)
   # 5050533 - Avis	Isaac (old Name: Avis Issac)
   
-- Category/ Module: Accounts Payable (Finance Management) 
-- Root cause: # 5007447 is data migration issue & # 5050533 is User error 
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Genia Grimes
select provider_nm, provider_first_nm, provider_last_nm, update_ts, update_user_id
	from prov.tb_provider 
where provider_id = 5007447
	and delete_sw = 'N' ;

Update prov.tb_provider 
set provider_nm = '',
	update_ts = now(),
	update_user_id = 'CDM-15861'
where provider_id = 5007447
	and delete_sw  = 'N' ;


-- Avis	Issac (wrong)
-- Avis	Isaac (correct) 
select provider_nm, provider_first_nm, provider_last_nm, update_ts, update_user_id
	from prov.tb_provider 
where provider_id = 5050533
	and delete_sw = 'N' ;

Update prov.tb_provider 
set provider_nm = '',
	provider_last_nm = 'Isaac',
	update_ts = now(),
	update_user_id = 'CDM-15861'
where provider_id = 5050533
	and delete_sw  = 'N' ;

