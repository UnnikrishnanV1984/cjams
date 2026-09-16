CREATE INDEX IF NOT EXISTS idx_alias_firstname ON cjams.alias USING btree (firstname ASC);
CREATE INDEX IF NOT EXISTS idx_alias_lastname ON cjams.alias USING btree (lastname ASC);
CREATE INDEX IF NOT EXISTS idx_alias_middlename ON cjams.alias USING btree (middlename ASC);