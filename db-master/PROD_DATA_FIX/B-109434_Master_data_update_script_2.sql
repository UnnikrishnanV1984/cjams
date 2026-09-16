-- B-109434 - Service Log Category - Editing of Family First EBP Service Categories (FAMILY FIRST)

/*
To fix below typos
1. Spell Error: Funcational Family Therapy - EBP - PSSF (Non-Paid)

2. Missing: Expecting Two with 5509/5501 but we have only one displayed in list
			Multisystemic Therapy - EBP - Other Funds (Non-Paid)
			
   Spell Error: Mulitsystemic Therapy - EBP - Other Funds (Non-Paid)
   -- Category 5501
*/

-- Functional Family Therapy - EBP - PSSF (Non-Paid)
select service_id, service_nm, service_category_cd, update_ts, update_user_id
	from prov.tb_services
where service_id = 13009
	and delete_sw = 'N' ;

update prov.tb_services
set service_nm = 'Functional Family Therapy - EBP - PSSF (Non-Paid)',
	update_ts = now(),
	update_user_id = 'B-109434-2'
where service_id = 13009
	and delete_sw = 'N' ;
	
-- Multisystemic Therapy - EBP - Other Funds (Non-Paid)
select service_id, service_nm, service_category_cd, update_ts, update_user_id
	from prov.tb_services
where service_id = 13021
	and delete_sw = 'N' ;

update prov.tb_services
set service_nm = 'Multisystemic Therapy - EBP - Other Funds (Non-Paid)',
	update_ts = now(),
	update_user_id = 'B-109434-2'
where service_id = 13021
	and delete_sw = 'N' ;

