-- B-109434 - Service Log Category - Editing of Family First EBP Service Categories (FAMILY FIRST)

/*
Mulitsystemic Therapy - EBP- Other Funds (Non-Paid)
This one have spell error.. It should be
Multisystemic Therapy - EBP - Other Funds (Non-Paid)
*/

-- Multisystemic Therapy - EBP- Other Funds (Non-Paid)
select service_id, service_nm, update_ts, update_user_id
	from prov.tb_services
where service_id = 13013
	and delete_sw = 'N' ;

update prov.tb_services
set service_nm = 'Multisystemic Therapy - EBP - Other Funds (Non-Paid)',
	update_ts = now(),
	update_user_id = 'B-109434-1'
where service_id = 13013
	and delete_sw = 'N' ;
