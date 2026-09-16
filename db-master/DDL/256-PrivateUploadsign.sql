alter table tb_provider_applicant add column if not exists uploadsignature text;
ALTER TABLE cjams.tb_provider_applicant ALTER COLUMN prgram TYPE varchar(100) USING prgram::varchar;
ALTER TABLE cjams.tb_provider_applicant ALTER COLUMN program_name TYPE varchar(100) USING program_name::varchar;
ALTER TABLE cjams.tb_provider_applicant ALTER COLUMN contact_email TYPE varchar(50) USING contact_email::varchar;
alter table tb_provider_referral_addresses add column if not exists adr_line2 varchar(50);
alter table tb_provider_referral add column if not exists adr_line2 varchar(50);