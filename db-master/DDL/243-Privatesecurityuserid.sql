alter  table tb_provider_applicant alter column create_ts set default current_timestamp;

alter table tb_provider_decision add column if not exists tosecurityusersid varchar(50) null;
alter table tb_provider_decision add column if not exists toroleid varchar(50) null;