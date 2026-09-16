
ALTER TABLE cjams.splanobjective ALTER COLUMN objectivename TYPE character varying;
ALTER TABLE cjams.splanobjective ALTER COLUMN comments TYPE character varying;

ALTER TABLE cjams.serviceplanaction ALTER COLUMN serviceplanactionname TYPE character varying;
ALTER TABLE cjams.serviceplanaction ALTER COLUMN comments TYPE character varying;

ALTER TABLE cjams.visitationplan ALTER COLUMN planexplain TYPE character varying;
ALTER TABLE cjams.visitationplan ALTER COLUMN supervisecomments TYPE character varying;
ALTER TABLE cjams.visitationplan ALTER COLUMN transportexplain TYPE character varying;
ALTER TABLE cjams.visitationplan ALTER COLUMN visitortransportexplain TYPE character varying;
ALTER TABLE cjams.visitationplan ALTER COLUMN frequencyexplain TYPE character varying;
