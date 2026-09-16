-- CDM-9571
update tb_client_eligibility set delete_sw = 'Y' where client_id = 1310084 and eligibility_id = 10000934 and delete_sw = 'N';