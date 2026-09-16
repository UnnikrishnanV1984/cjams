alter table prov.tb_provider drop column if exists row_lock ;
alter table prov.tb_contract_program  drop column if exists row_lock ;

ALTER TABLE prov.tb_provider ADD COLUMN IF NOT EXISTS row_lock character varying(50);
COMMENT ON COLUMN prov.tb_provider.row_lock IS 'Added for handling concurrency';


ALTER TABLE prov.tb_contract_program  ADD COLUMN IF NOT EXISTS row_lock character varying(50);
COMMENT ON COLUMN prov.tb_contract_program.row_lock IS 'Added for handling concurrency';