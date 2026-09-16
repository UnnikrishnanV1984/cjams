-- Add New column in tb_rs_ive_status table 
-- This is to capture the key value (eligibility_period_id) when Event ID is missing 
-- CJAMS IV-E determination is creating events only when there is a change in the resulting status

alter table tb_rs_ive_status add column if not exists eligibility_period_id bigint;

alter table tb_rs_ive_status_history add column if not exists eligibility_period_id bigint;

