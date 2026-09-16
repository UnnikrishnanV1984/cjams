DROP TABLE if exists cjams.ivecaseclosurereview;
CREATE TABLE cjams.ivecaseclosurereview (
	ivecaseclosurereviewId uuid NOT NULL DEFAULT gen_random_uuid(),
    dispositionId varchar NULL,
    objecttype varchar(50) NULL,
    objectId uuid NULL,
    insertedby varchar(50) NULL, 
	insertedon timestamp NOT NULL DEFAULT now(), 
	updatedby varchar(50) NOT NULL, 
	updatedon timestamp NOT NULL DEFAULT now(), 
    ivereviewstatus varchar NULL,
    activeflag int4 NULL DEFAULT 1,
    CONSTRAINT pk_ivecaseclosurereview PRIMARY KEY (ivecaseclosurereviewId)
);

-- Column comments
COMMENT ON COLUMN cjams.ivecaseclosurereview.ivecaseclosurereviewId IS 'Table primary key(UUID)';
COMMENT ON COLUMN cjams.ivecaseclosurereview.dispositionid IS 'Record to save dispositionId';
COMMENT ON COLUMN cjams.ivecaseclosurereview.objecttype IS 'Type of case (service/adoption)';
COMMENT ON COLUMN cjams.ivecaseclosurereview.objectId IS 'saves caseid';
COMMENT ON COLUMN cjams.ivecaseclosurereview.insertedby IS 'User who created this record';
COMMENT ON COLUMN cjams.ivecaseclosurereview.insertedon IS 'Record created date and time';
COMMENT ON COLUMN cjams.ivecaseclosurereview.updatedby IS 'user who last updated the record';
COMMENT ON COLUMN cjams.ivecaseclosurereview.updatedon IS 'Record updated date and time';
COMMENT ON COLUMN cjams.ivecaseclosurereview.ivereviewstatus IS 'Status of IV-E Case Closure';
COMMENT ON COLUMN cjams.ivecaseclosurereview.activeflag IS 'Active record flag';

