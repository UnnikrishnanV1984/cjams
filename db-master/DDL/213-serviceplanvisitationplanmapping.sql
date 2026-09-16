-- Drop table

-- DROP TABLE cjams.serviceplanvisitationplanmapping

CREATE TABLE cjams.serviceplanvisitationplanmapping (
	serviceplanvisitationplanmappingid uuid NOT NULL,
	visitationplanid uuid NOT NULL,
	serviceplanid uuid NOT NULL,
	insertedon timestamp NULL,
	insertedby varchar(10) NULL,
	updatedon timestamp NULL,
	updatedby varchar(10) NULL,
	activeflag int4 NOT NULL DEFAULT 1
);

-- Permissions

ALTER TABLE cjams.serviceplanvisitationplanmapping OWNER TO welfareadmin;
GRANT ALL ON TABLE cjams.serviceplanvisitationplanmapping TO welfareadmin;
