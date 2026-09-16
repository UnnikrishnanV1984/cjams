alter table placementrevision add column if not exists justification character varying;

comment on column cjams.placementrevision.justification is 'Reason to modify the placement details';

alter table placementrevision add column if not exists status character varying(20);

comment on column cjams.placementrevision.status is 'Status of the placement for audit log';