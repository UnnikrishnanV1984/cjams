--04/11/2023 MOUNIKA GUDISE updating description column (CIDM-6925)

alter table cjams.persondisability add column IF NOT EXISTS selectdisability character varying;

comment on column persondisability.selectdisability IS 'To store the selected disability picklist values';
