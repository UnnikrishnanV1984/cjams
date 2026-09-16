ALTER TABLE cjams.personincome ALTER COLUMN incomesourcetypekey TYPE varchar(25) USING incomesourcetypekey::varchar;

alter table cjams.personmilitaryservices
add column contactphonetypekey varchar(25) NULL,
add column contactphoneextension varchar(5) NULL,
add column superiorphonetypekey varchar(25) NULL,
add column adr1 varchar(250) NULL,
add column adr2 varchar(250) NULL;