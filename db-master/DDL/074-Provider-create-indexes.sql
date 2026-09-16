create index tb_provider_provider_id_idx on cjams.tb_provider
(provider_id);

create index tb_provider_public_provider_nm_idx on cjams.tb_provider
(provider_first_nm, provider_last_nm);

create index tb_provider_private_provider_nm_idx on cjams.tb_provider
(provider_nm);

create index tb_provider_tax_id_no_idx on cjams.tb_provider
(tax_id_no);

create index tb_provider_addresses_adr_zip5_no_idx on cjams.tb_provider_addresses
(adr_zip5_no);

create index tb_provider_services_provider_id_idx on cjams.tb_provider_services
(provider_id);

create index tb_provider_services_service_id_idx on cjams.tb_provider_services
(service_id);
