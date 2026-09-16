ALTER TABLE cjams.serviceplanaction ALTER COLUMN serviceplanactionname TYPE varchar(500) USING serviceplanactionname::varchar;

ALTER TABLE cjams.splangoal ALTER COLUMN goalname TYPE varchar(500) USING goalname::varchar;

ALTER TABLE cjams.splanobjective ALTER COLUMN objectivename TYPE varchar(500) USING objectivename::varchar;