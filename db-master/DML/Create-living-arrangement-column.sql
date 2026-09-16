alter table livingarrangement add column if not exists livingpriortoplacement boolean;
comment on column cjams.livingarrangement.livingpriortoplacement is 'Living Arrangement added prior to Placement';
