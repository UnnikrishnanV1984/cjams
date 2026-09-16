DROP TABLE IF EXISTS cjams.serviceplanoutcome;
DELETE FROM cjams.serviceplanpersoninvolved;
DELETE FROM cjams.serviceplanaction;
ALTER TABLE cjams.serviceplanaction ADD splanobjectiveid uuid NOT NULL;
ALTER TABLE cjams.serviceplanaction DROP COLUMN serviceplanfocusid;
ALTER TABLE cjams.serviceplanaction ADD serviceplanoutcome varchar(100) NULL;
--ALTER TABLE serviceplanaction
--DROP CONSTRAINT fk_serviceplanfocus;
ALTER TABLE serviceplanaction
ADD CONSTRAINT fk_splanobjective FOREIGN KEY (splanobjectiveid) REFERENCES splanobjective(splanobjectiveid);
ALTER TABLE cjams.serviceplan ADD targetenddate timestamp NULL;
ALTER TABLE cjams.serviceplanaction ADD "comments" varchar(150) NULL;
