-- Drop table

-- DROP TABLE cjams.restricteditems

CREATE TABLE cjams.restricteditems (
	restricteditemsid uuid NOT NULL DEFAULT gen_random_uuid(),
	objecttypekey varchar(50) NULL, -- Type of item
	objectid varchar(50) NULL, -- Case / Item number
	accessuserid varchar(50) NULL, -- User id with access
	description text NULL, -- Any descrtipion or comment
	isadd bool NULL DEFAULT false, -- Mode of restriction
	isedit bool NULL DEFAULT false, -- Mode of restriction 
	isdelete bool NULL DEFAULT false, -- Mode of restriction
	insertedby varchar(50) NULL, -- User who created this record
	updatedby varchar(50) NULL, -- user who last updated the record
	insertedon timestamp NULL, -- Record created date and time
	updatedon timestamp NULL, -- Record updated date and time
	CONSTRAINT pk_restricteditemsid PRIMARY KEY (restricteditemsid)
);


-- Permissions

ALTER TABLE cjams.restricteditems OWNER TO welfareadmin;
GRANT ALL ON TABLE cjams.restricteditems TO welfareadmin;


ALTER TABLE cjams.intakedastaging ADD isrestricteditem bool NULL DEFAULT false;
