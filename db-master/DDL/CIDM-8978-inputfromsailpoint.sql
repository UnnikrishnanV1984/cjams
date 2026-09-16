ALTER TABLE cjams.inputfromsailpoint ALTER COLUMN message TYPE text USING message::text;
ALTER TABLE cjams.inputfromsailpoint ADD COLUMN IF NOT EXISTS response text;
ALTER TABLE cjams.inputfromsailpoint RENAME COLUMN v_phonenumber TO v_cell_phonenumber;
ALTER TABLE cjams.inputfromsailpoint add column if not exists v_work_phonenumber character varying;
COMMENT ON COLUMN cjams.inputfromsailpoint.message IS 'Actions performed as part of create or update user';
COMMENT ON COLUMN cjams.inputfromsailpoint.response IS 'Response returned after cjams data update to sailpoint';
COMMENT ON COLUMN cjams.inputfromsailpoint.v_cell_phonenumber IS 'User Cell phone number.';
COMMENT ON COLUMN cjams.inputfromsailpoint.v_work_phonenumber IS 'User Work phone number';
