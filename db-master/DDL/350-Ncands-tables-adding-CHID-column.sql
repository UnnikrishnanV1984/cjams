alter table ncands_maltreator_info add column if not exists chid varchar(50);
alter table ncands_childrisk add column if not exists chid varchar(50);
alter table ncands_caregiver add column if not exists chid varchar(50);
alter table ncands_services add column if not exists chid varchar(50);
alter table ncands_work_perp add column if not exists chid varchar(50);