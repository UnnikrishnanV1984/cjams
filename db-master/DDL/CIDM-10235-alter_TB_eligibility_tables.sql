 
ALTER TABLE cjams.tb_eligibility_period ALTER COLUMN create_user_id TYPE varchar(50);
ALTER TABLE cjams.tb_eligibility_period ALTER COLUMN update_user_id TYPE varchar(50);


ALTER TABLE cjams.tb_eligibility_events ALTER COLUMN create_user_id TYPE varchar(50);
ALTER TABLE cjams.tb_eligibility_events ALTER COLUMN update_user_id TYPE varchar(50);