--Adding primary key and column
--CIDM-8222 Adding primary key/ primary columns

alter table cjams.referencevalues add column referencevaluesid uuid NOT NULL DEFAULT cjams.gen_random_uuid();
alter table cjams.referencevalues add primary key (referencevaluesid);
alter table cjams.personimmunizationconfig add primary key (personimmunizationconfigid);
alter table cjams.personprogramarea add primary key (personprogramid);
