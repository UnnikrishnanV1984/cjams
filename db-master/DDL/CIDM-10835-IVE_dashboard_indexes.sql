CREATE UNIQUE INDEX  if not exists idx_aprvlid_catgry ON cjams.tb_ive_adoption_audit USING btree ( (approvalid::varchar) , category);
CREATE UNIQUE index if not exists idx_eligbty_period_id ON cjams.tb_ive_adoption_audit USING btree ( eligibility_period_id);

