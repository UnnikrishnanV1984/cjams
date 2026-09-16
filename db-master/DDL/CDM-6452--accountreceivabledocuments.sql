--Adding delete funtionality for account receivable document module.
alter table cjams.accountreceivabledocuments add column if not exists ecmsdocumentid character varying(30); 
comment on column cjams.accountreceivabledocuments.ecmsdocumentid is 'To capture the ecms document id after uploading into ECMS system';