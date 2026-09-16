alter table personhealthinsurance add column if not exists managedcareorganization varchar(200) null;
ALTER TABLE cjams.personemployerdetail ALTER COLUMN duties TYPE varchar(100) USING duties::varchar;
alter table personhlthelimination add column if not exists isspecialconsiderunknown boolean null;
alter table personphycisianinfo add column if not exists countyname character varying(20) null;
