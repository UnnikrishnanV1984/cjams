

    ALTER TABLE cjams.tb_provider_applicant_addresses ALTER COLUMN create_ts TYPE varchar(50) USING create_ts::varchar;
ALTER TABLE cjams.tb_provider_applicant_addresses ALTER COLUMN update_ts TYPE varchar(50) USING update_ts::varchar;
ALTER TABLE cjams.tb_provider_address_mapping ALTER COLUMN update_ts TYPE varchar(50) USING update_ts::varchar;
ALTER TABLE cjams.tb_provider_address_mapping ALTER COLUMN create_ts TYPE varchar(50) USING create_ts::varchar;
