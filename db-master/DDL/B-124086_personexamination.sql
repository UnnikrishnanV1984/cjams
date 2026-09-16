alter table personexamination add column if not exists labtestother text;
alter table personexamination add column if not exists specialityexamother text;
alter table personexamination add column if not exists physicianfaxnumber character varying(15);
ALTER table personexamination ALTER column labtesttypekey TYPE text[] USING string_to_array(labtesttypekey,',');
ALTER table personexamination ALTER column labtesttypekey TYPE json USING array_to_json(labtesttypekey);
