update tb_payment_detail set client_id = 3620741, update_ts = now(), update_user_id = 'CDM-11569'
where client_id = 3249669;

update placement
set enddatetime = '2021-02-25 14:19:00.078',
	updatedby = 'CDM-11569',
	updatedon = now()
where placementid = '82b7c191-8e17-4dfd-b46f-953dd422c036' 
	and activeflag = 1 ;