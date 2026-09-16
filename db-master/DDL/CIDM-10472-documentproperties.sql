
ALTER TABLE cjams.documentproperties add column if not exists uploadstatus varchar(50);

ALTER TABLE cjams.documentproperties add column if not exists finalstatus varchar(50);

ALTER TABLE cjams.documentproperties add column if not exists usernotified Boolean;

ALTER TABLE cjams.documentproperties add column if not exists filesize varchar(50);

COMMENT ON COLUMN cjams.documentproperties.uploadstatus IS 'File Upload status based on the upload progress';
   
COMMENT ON COLUMN cjams.documentproperties.finalstatus IS 'Final file upload status updated by callback call from EDMS system';

COMMENT ON COLUMN cjams.documentproperties.usernotified IS 'Flag updated after the user is being notified on the scan failures';

COMMENT ON COLUMN cjams.documentproperties.filesize IS 'uploaded File Size';
