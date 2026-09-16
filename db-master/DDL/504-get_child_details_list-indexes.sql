CREATE INDEX idx_person_gin_name
ON person
USING GIN (lower(btrim(firstname)) gin_trgm_ops, lower(btrim(lastname)) gin_trgm_ops)
TABLESPACE pg_default;

CREATE INDEX idx_person_name_soundex
ON person
USING btree (soundex(lower(btrim((firstname)::text))), soundex(lower(btrim((lastname)::text))))
TABLESPACE pg_default;