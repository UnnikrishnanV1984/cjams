-- DROP TABLE cjams.overduepopup;

CREATE TABLE cjams.overduepopup (
    overduepopupid uuid NOT NULL DEFAULT cjams.gen_random_uuid(),
    intakeserviceid uuid NULL,
    insertedby varchar(50) NULL,
    insertedon timestamp NULL DEFAULT now(),
    updatedby varchar(50) NULL,
    updatedon timestamp NULL DEFAULT now(),
    activeflag int4 NOT NULL DEFAULT 1,
    caseworkercomments varchar NULL,
    supervisorcomments varchar NULL,
    objectid uuid NULL,
    objecttype varchar NULL,
    CONSTRAINT pk_overduepopupid PRIMARY KEY (overduepopupid)
);
CREATE INDEX overduepopupid_intakeserviceid_idx ON cjams.overduepopup USING btree (intakeserviceid);



COMMENT ON COLUMN cjams.overduepopup.caseworkercomments 
    IS 'Case worker''s comments for the Over due popup';
    
COMMENT ON COLUMN cjams.overduepopup.supervisorcomments 
    IS 'Supervisor''s comments for the Response Timer for over due popup';

COMMENT ON COLUMN cjams.overduepopup.objectid IS 'To save Placement ID for LIVING Arrangement Popup';
COMMENT ON COLUMN cjams.overduepopup.objecttype IS 'To save placement type for Living Arrangement Popup';
COMMENT ON COLUMN cjams.overduepopup.overduepopupid IS 'Primary Key of the Table';
COMMENT ON COLUMN cjams.overduepopup.insertedby IS 'Record Created User Details';
COMMENT ON COLUMN cjams.overduepopup.insertedon IS 'Date and Time of Record Creation';
COMMENT ON COLUMN cjams.overduepopup.updatedby IS 'Record Update User Details';
COMMENT ON COLUMN cjams.overduepopup.updatedon IS 'Date and Time of Record update';
COMMENT ON COLUMN cjams.overduepopup.activeflag  IS 'Status of the Record';
COMMENT ON COLUMN cjams.overduepopup.intakeserviceid IS 'To save Service case id';