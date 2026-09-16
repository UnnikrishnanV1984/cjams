create sequence SQ_CRB_FACTS_INTERMEDIATE start 101;

alter  table interfaceserrorlog alter column errorcode type varchar(10000);

alter table interfaceserrorlog alter column errorsqlcode type varchar(10000);

alter  table interfaceserrorlog alter column interfaceid type varchar(100);

alter table interfacecrboutbound alter column FILLER_2 type varchar(77);

alter table interfacecrboutbound alter column LA_PROVIDER type varchar(100);


create sequence SQ_CARES_OUTBOUND_INTERFACE start 101;

alter table userprofile add column name_suffix varchar(15);


create extension fuzzystrmatch;