ALTER TABLE tb_deemed_income_clients drop COLUMN deemed_income_clients_id;
ALTER TABLE tb_deemed_income_clients ADD COLUMN deemed_income_clients_id uuid not null;
ALTER TABLE tb_deemed_income_clients drop COLUMN deemed_income_stepparent_id;
ALTER TABLE tb_deemed_income_clients ADD COLUMN deemed_income_stepparent_id uuid not null;
ALTER TABLE tb_deemed_income_clients Alter COLUMN client_id drop not null;
ALTER TABLE tb_deemed_income_clients Alter COLUMN client_merge_id drop not null;
ALTER TABLE tb_deemed_income_clients ADD COLUMN personid uuid not null;
ALTER TABLE tb_deemed_income_clients Alter COLUMN delete_sw type integer using delete_sw :: integer ;