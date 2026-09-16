	ALTER TABLE tb_cses_outbound_interface_iss drop COLUMN cses_record_id;
	
ALTER TABLE tb_cses_outbound_interface_iss add COLUMN cses_record_id  uuid;