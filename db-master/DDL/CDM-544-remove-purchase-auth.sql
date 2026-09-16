
--CDM -544
UPDATE tb_service_purchase_authorization SET delete_sw = 'Y' WHERE authorization_id = 1732713;


--CDM 548
UPDATE routing SET activeflag = 0 , updatedon = now(), updatedby = 'CDM-548' WHERE routingid = 'c7220b13-edfd-4e12-b2e6-be3e6cddc6e1';


