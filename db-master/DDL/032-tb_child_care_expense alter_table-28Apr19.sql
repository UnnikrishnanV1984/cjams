ALTER TABLE tb_child_care_expense drop COLUMN child_care_expense_id;
ALTER TABLE tb_child_care_expense ADD COLUMN child_care_expense_id uuid not null;
ALTER TABLE tb_child_care_expense ADD COLUMN incomeid uuid not null;
ALTER TABLE tb_child_care_expense Alter COLUMN case_id drop not null;
ALTER TABLE tb_child_care_expense Alter COLUMN delete_sw type integer using delete_sw :: integer;