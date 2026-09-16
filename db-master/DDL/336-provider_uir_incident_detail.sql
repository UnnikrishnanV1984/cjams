alter table provider_uir_incident_detail add column if not exists incident_date timestamp without time zone;
alter table provider_uir_incident_detail add column if not exists incident_time character varying;
alter table provider_uir_incident_detail add column if not exists discovered_date timestamp without time zone;
alter table provider_uir_incident_detail add column if not exists discovered_time character varying;
alter table provider_uir_incident_detail add column if not exists precipitating_event character varying;