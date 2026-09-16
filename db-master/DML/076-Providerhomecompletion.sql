
alter table tb_public_provider_applicant add column  if not exists home_study_completed_by varchar(50) null;

alter table tb_public_provider_applicant add column  if not exists reason text null;