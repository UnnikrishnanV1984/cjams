CREATE INDEX IF NOT EXISTS idx_caseclosuresummary_IntakeServiceId
ON cjams.caseclosuresummary
USING btree (IntakeServiceId ASC);