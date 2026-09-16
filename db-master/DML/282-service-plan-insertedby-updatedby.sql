ALTER TABLE cjams.serviceplanaction ALTER COLUMN insertedby TYPE character varying(50);

ALTER TABLE cjams.serviceplanaction ALTER COLUMN updatedby TYPE character varying(50);
--
ALTER TABLE cjams.serviceplanchild ALTER COLUMN insertedby TYPE character varying(50);

ALTER TABLE cjams.serviceplanchild ALTER COLUMN updatedby TYPE character varying(50);
--
ALTER TABLE cjams.serviceplanfocus ALTER COLUMN insertedby TYPE character varying(50);

ALTER TABLE cjams.serviceplanfocus ALTER COLUMN updatedby TYPE character varying(50);
--
ALTER TABLE cjams.serviceplanneed ALTER COLUMN insertedby TYPE character varying(50);

ALTER TABLE cjams.serviceplanneed ALTER COLUMN updatedby TYPE character varying(50);
--
ALTER TABLE cjams.serviceplanpersoninvolved ALTER COLUMN insertedby TYPE character varying(50);

ALTER TABLE cjams.serviceplanpersoninvolved ALTER COLUMN updatedby TYPE character varying(50);
--
ALTER TABLE cjams.serviceplanstrength ALTER COLUMN insertedby TYPE character varying(50);

ALTER TABLE cjams.serviceplanstrength ALTER COLUMN updatedby TYPE character varying(50);
--
ALTER TABLE cjams.splangoal ALTER COLUMN insertedby TYPE character varying(50);

ALTER TABLE cjams.splangoal ALTER COLUMN updatedby TYPE character varying(50);

--
ALTER TABLE cjams.splanobjective ALTER COLUMN insertedby TYPE character varying(50);

ALTER TABLE cjams.splanobjective ALTER COLUMN updatedby TYPE character varying(50);