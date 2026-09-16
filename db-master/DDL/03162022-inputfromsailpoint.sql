-- cjams.inputfromsailpoint definition

-- Drop table

DROP TABLE IF EXISTS cjams.inputfromsailpoint;

CREATE TABLE cjams.inputfromsailpoint (
	inputid varchar(50) NOT NULL DEFAULT gen_random_uuid(),
	v_email varchar(50) NULL,
	v_firstname varchar(50) NULL,
	v_lastname varchar(50) NULL,
	v_middlename varchar(50) NULL,
	v_fullname varchar(50) NULL,
	v_agencycode varchar(50) NULL,
	v_openamrole varchar(50) NULL,
	v_countycode varchar(50) NULL,
	v_teamcode varchar(50) NULL,
	v_teamname varchar(50) NULL,
	v_ldss varchar(50) NULL,
	v_add1 varchar(50) NULL,
	v_city varchar(50) NULL,
	v_zipcode varchar(50) NULL,
	v_phonenumber varchar(50) NULL,
	v_staffid varchar(50) NULL,
	v_positioncode varchar(50) NULL,
	v_positiontitle varchar(50) NULL,
	v_username varchar(50) NULL,
	v_super_id varchar(50) NULL,
	v_as_super_id varchar(50) NULL,
	v_isaddorremove varchar(50) NULL,
	v_roletypekey varchar(50) NULL,
	v_teamtypekey varchar(50) NULL,
	methodname varchar(50) NULL,
	insertedby varchar(50) NULL,
	insertedon timestamp NOT NULL DEFAULT now(),
	updatedby varchar(50) NULL,
	updatedon timestamp NULL,
	v_message varchar(500) NULL
);