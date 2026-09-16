-- Data fix CDM-8226
update tb_client_eligibility set delete_sw = 'Y' where eligibility_id = '10000988' and client_id = 200147261 and eligibility_type_cd = '2931' AND delete_sw = 'N'
		