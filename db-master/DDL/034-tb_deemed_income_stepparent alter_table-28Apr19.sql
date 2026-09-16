ALTER TABLE tb_deemed_income_stepparent ADD COLUMN incomeid uuid;
ALTER TABLE tb_deemed_income_stepparent drop COLUMN deemed_income_stepparent_id;
ALTER TABLE tb_deemed_income_stepparent ADD COLUMN deemed_income_stepparent_id uuid not null;
ALTER TABLE tb_deemed_income_stepparent drop COLUMN case_id;
ALTER TABLE tb_deemed_income_stepparent ADD COLUMN case_id uuid not null;
alter table tb_deemed_income_stepparent alter column delete_sw type integer using delete_sw :: integer;