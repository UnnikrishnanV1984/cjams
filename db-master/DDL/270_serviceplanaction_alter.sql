ALTER TABLE cjams.serviceplanaction ALTER COLUMN "comments" TYPE varchar(1500) USING "comments"::varchar;
ALTER TABLE cjams.splanobjective ALTER COLUMN "comments" TYPE varchar(1500) USING "comments"::varchar;
