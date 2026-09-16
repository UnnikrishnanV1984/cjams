
ALTER TABLE cjams.documentproperties
add column if not exists additionalobjectid varchar(50);

ALTER TABLE cjams.documentproperties
add column if not exists additionalobjecttype varchar(50);

COMMENT ON COLUMN cjams.documentproperties.additionalobjectid
    IS 'Additional object ID varchar';
   
COMMENT ON COLUMN cjams.documentproperties.additionalobjecttype
    IS 'Additional object Type varchar';
