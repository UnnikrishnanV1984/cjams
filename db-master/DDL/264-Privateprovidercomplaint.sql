alter table tb_provider_complaint add column if not exists investigationstartdate timestamp null;
alter table tb_provider_complaint add column if not exists investigationenddate timestamp null;
alter table providerportalrequest add column if not exists signimage text;

  alter sequence if exists sq_staffgroupinglog owned by none;
             alter table providerstaff add column if not exists groupinglog int null;
              alter table providerstaff alter column groupinglog drop default;
              drop sequence if exists sq_staffgroupinglog;
              CREATE SEQUENCE if not exists sq_staffgroupinglog
              INCREMENT 1
              MINVALUE 1
              MAXVALUE 9223372036854775807
              START 10000001
              CACHE 1; 
alter table only providerstaff alter column  groupinglog set default nextval('sq_staffgroupinglog') ;