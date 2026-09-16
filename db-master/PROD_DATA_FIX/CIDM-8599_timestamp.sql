-- CIDM-8599 - TimeStamp Fixes
/* Issue Description: Updating audit column which are not updating from code and changing coulmn with varchar2timestamp 
*/

-- Updating datatype of create_ts on tb_receivable_liquidation
ALTER TABLE cjams.tb_receivable_liquidation ALTER COLUMN create_ts TYPE timestamp USING create_ts::timestamp;

ALTER TABLE cjams.tb_receivable_liquidation ALTER COLUMN update_ts TYPE timestamp USING update_ts::timestamp;

-- Updating datatype of create_ts, update_ts on tb_provider_address_mapping
ALTER TABLE cjams.tb_provider_address_mapping ALTER COLUMN create_ts TYPE timestamp USING create_ts::timestamp;

ALTER TABLE cjams.tb_provider_address_mapping ALTER COLUMN update_ts TYPE timestamp USING update_ts::timestamp;


-- Updating datatype of create_ts, update_ts on publicproviderhousehold
ALTER TABLE cjams.publicproviderhousehold ALTER COLUMN create_ts TYPE timestamp USING create_ts::timestamp;

ALTER TABLE cjams.publicproviderhousehold ALTER COLUMN update_ts TYPE timestamp USING update_ts::timestamp;

-- Updating datatype of create_ts on tb_receivable_collection_status
ALTER TABLE cjams.tb_receivable_collection_status ALTER COLUMN create_ts TYPE timestamp USING create_ts::timestamp;

ALTER TABLE cjams.tb_receivable_collection_status ALTER COLUMN update_ts TYPE timestamp USING update_ts::timestamp;
