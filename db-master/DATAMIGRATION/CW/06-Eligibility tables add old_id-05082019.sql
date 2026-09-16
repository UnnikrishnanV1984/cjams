ALTER TABLE cjams.tb_child_care_expense ADD COLUMN IF NOT EXISTS old_id character varying (50);
ALTER TABLE cjams.tb_deemed_income_clients ADD COLUMN IF NOT EXISTS old_id character varying (50);
ALTER TABLE cjams.tb_deemed_income_stepparent ADD COLUMN IF NOT EXISTS old_id character varying (50);