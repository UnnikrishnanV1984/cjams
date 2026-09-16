CREATE TABLE cjams.userresource
(
    userresourceid uuid NOT NULL DEFAULT gen_random_uuid(),
    userid bigint NOT NULL,
    permissiongroupid uuid,
    roleid integer,
    resourceid uuid,
    activeflag integer NOT NULL DEFAULT 1,
    insertedby character varying(50) COLLATE pg_catalog."default",
    insertedon timestamp without time zone NOT NULL DEFAULT now(),
    updatedby character varying(50) COLLATE pg_catalog."default",
    updatedon timestamp without time zone NOT NULL DEFAULT now(),
    isallowed boolean,
    isvisible boolean,
    isenabled boolean,
    old_id character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT pk_userresource PRIMARY KEY (userresourceid),
    CONSTRAINT fk_userresource_muser FOREIGN KEY (userid)
        REFERENCES cjams.muser (id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
);
