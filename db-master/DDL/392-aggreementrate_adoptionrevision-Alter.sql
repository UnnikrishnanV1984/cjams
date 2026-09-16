ALTER TABLE personprogramarea ADD COLUMN IF NOT EXISTS entityid character varying;

ALTER TABLE adoptioncaserevision ADD COLUMN IF NOT EXISTS old_id character varying;

ALTER TABLE adoptioncaseagreementrate ADD COLUMN IF NOT EXISTS fk_id INT;
ALTER TABLE adoptioncaseagreementrate ADD COLUMN IF NOT EXISTS isssaapproved INT;
ALTER TABLE adoptioncaseagreementrate ADD COLUMN IF NOT EXISTS ssaapproveddate timestamp without time zone;