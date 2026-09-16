alter table cjams.personeducation add column if not exists delayinenrollment character varying(10) NULL;
COMMENT ON COLUMN cjams.personeducation.delayinenrollment IS 'To store the Selected Delay In Enrollment';

alter table cjams.personeducation add column if not exists delayinenrollmentdetail character varying(2000) NULL;
COMMENT ON COLUMN cjams.personeducation.delayinenrollmentdetail IS 'To store Others Information For Delay In Enrollment';

ALTER TABLE personeducation add column if not exists enrollmentdate timestamp NULL;
COMMENT ON COLUMN personeducation.enrollmentdate IS 'To store enrollment date';

ALTER TABLE personeducation add column if not exists nonewenrollment int4 NULL;
COMMENT ON COLUMN personeducation.nonewenrollment IS 'To store no new enrollment checkbox value';

ALTER TABLE cjams.personeducation ALTER COLUMN nonewenrollment TYPE bool USING nonewenrollment::bool;
COMMENT ON COLUMN personeducation.nonewenrollment IS 'To store no new enrollment checkbox value';