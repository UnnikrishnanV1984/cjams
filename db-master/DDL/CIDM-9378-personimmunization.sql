ALTER TABLE cjams.personimmunization ADD column if not exists recordstatus int4 NULL;
ALTER TABLE cjams.personimmunization_history ADD column if not exists recordstatus int4 NULL;


COMMENT ON COLUMN cjams.personimmunization.recordstatus IS '(reference value 0- deleted , 1 - rejected, 3-Undo ) status of record for Immunization record ';
COMMENT ON COLUMN cjams.personimmunization_history.recordstatus IS '(reference value 0- deleted , 1 - rejected, 3-Undo ) status of record for Immunization history record ';