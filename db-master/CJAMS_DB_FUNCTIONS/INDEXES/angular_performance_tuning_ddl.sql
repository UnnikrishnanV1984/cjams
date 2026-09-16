-- Agathya - 01/09/2025 - Added for the performance tuning. 

CREATE INDEX if not exists idx_dastaging_cw_1 ON cjams.intakedastaging USING btree (intakenumber, teamtypekey, activeflag, lower(status));

CREATE index if not exists idx_trgm_intake_number ON cjams.intakedastatus USING gin (lower(intakenumber) gin_trgm_ops);

CREATE INDEX if not exists idx_trgm_servicerequestnumber ON cjams.intakeservicerequest USING GIN (lower(servicerequestnumber) gin_trgm_ops);

CREATE INDEX if not exists idx_trgm_servicecasenumber ON cjams.servicecase USING GIN (lower(servicecasenumber) gin_trgm_ops);

CREATE INDEX if not exists idx_trgm_adoptioncasenumber ON cjams.adoptioncase USING GIN (lower(adoptioncasenumber) gin_trgm_ops);
