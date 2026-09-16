ALTER TABLE cjams.assessment ADD column IF NOT EXISTS actualdata json;
comment on column cjams.assessment.actualdata is 'Current Payload Information';
