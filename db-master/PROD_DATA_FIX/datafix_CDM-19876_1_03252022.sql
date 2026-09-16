-- CDM-19876 - Provider Name Discrepancy
/*
-- Issue Description: 
	Public Provider Name Discrepancy between CJAMS CW and Provider Module
   
-- Category/ Module: Public Provider (Provider Management) 
-- Root cause: Provider Module Data Issue
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

/*
--------------------------------------------------------------------------------------------
Provider Full Name				First Name	Middle Name	Last Name	Correct Name 
--------------------------------------------------------------------------------------------
5014086	Lori Edwards			TORI					EDWARDS		Tori Edwards
5023315	Keishia Polston			Keisha		L			Polston		Keisha L Polston
5012790	Linda Genus				Linda					Lewis Genus	Linda Lewis Genus
5015030	Towanda James-sergent	Towanda					Sergent		Towanda Sergent
5015557	Shiela Hicks			Sheila					Hicks		Sheila Hicks
5044421	Karen Shannon			Karen					Douglas		Karen Douglas
5030898	Betty Jones-thomas		Betty					Jones		Betty Jones

5025236	Tarsha Randolph			Tarsha					Pass		Tarsha Delores Pass
5014683	Joann Thomas			Joanne		S			Anoma		Joanne Thomas 
5021443	Stacey Clea				Stacey		Rae			Taylor		Stacey Clea
--------------------------------------------------------------------------------------------
*/
-- Nullify provider_nm
select provider_nm, provider_first_nm, provider_middle_nm, provider_last_nm, update_ts, update_user_id
	from prov.tb_provider 
where provider_id in ( 5014086, 5023315, 5012790, 5015030, 5015557, 5044421, 5030898 )
	and delete_sw = 'N' ;

Update prov.tb_provider 
set provider_nm = '',
	update_ts = now(),
	update_user_id = 'CDM-19876-1'
where provider_id in ( 5014086, 5023315, 5012790, 5015030, 5015557, 5044421, 5030898 )
	and delete_sw  = 'N' ;
	
-- Add Middle Name and Nullify Provider Name
select provider_nm, provider_first_nm, provider_middle_nm, provider_last_nm, update_ts, update_user_id
	from prov.tb_provider 
where provider_id = 5025236
	and delete_sw = 'N' ;
	
update prov.tb_provider 
set provider_nm = '',
	provider_last_nm = 'Delores Pass',
	update_ts = now(),
	update_user_id = 'CDM-19876-1'
where provider_id = 5025236	
	and delete_sw  = 'N' ;

-- Change Last Name and Nullify Provider Name & Middle Name
select provider_nm, provider_first_nm, provider_middle_nm, provider_last_nm, update_ts, update_user_id
	from prov.tb_provider 
where provider_id = 5014683
	and delete_sw = 'N' ;
	
update prov.tb_provider 
set provider_nm = '',
	provider_middle_nm = NULL,
	provider_last_nm = 'Thomas',
	update_ts = now(),
	update_user_id = 'CDM-19876-1'
where provider_id = 5014683	
	and delete_sw  = 'N' ;

-- Change Last Name and Nullify Provider Name & Middle Name
select provider_nm, provider_first_nm, provider_middle_nm, provider_last_nm, update_ts, update_user_id
	from prov.tb_provider 
where provider_id = 5021443
	and delete_sw = 'N' ;
	
update prov.tb_provider 
set provider_nm = '',
	provider_middle_nm = NULL,
	provider_last_nm = 'Clea',
	update_ts = now(),
	update_user_id = 'CDM-19876-1'
where provider_id = 5021443	
	and delete_sw  = 'N' ;
