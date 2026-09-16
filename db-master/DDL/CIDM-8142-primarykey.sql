--Primary Key for tables
--cjams.referencevalues
--cjams.personimmunizationconfig  
--CIDM-8142

alter table cjams.referencevalues add column referencevaluesid uuid NOT NULL DEFAULT cjams.gen_random_uuid();
alter table cjams.referencevalues add primary key (referencevaluesid);
alter table cjams.personimmunizationconfig add primary key (personimmunizationconfigid);