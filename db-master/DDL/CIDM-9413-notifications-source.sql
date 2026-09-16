ALTER TABLE cjams.usernotification ADD "source" varchar(50) NULL;

COMMENT ON COLUMN cjams.usernotification.source is 'External source system for user notifications';