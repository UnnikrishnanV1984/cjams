-- Drop table

-- DROP TABLE cjams.adoptionannualreview;

CREATE TABLE cjams.adoptionannualreview (
	adoptionannualreviewid uuid NOT NULL DEFAULT gen_random_uuid(), 
	adoptioncaseid uuid NULL, 
	reviewdate timestamp NULL, 
	ischilddisability bool NULL, 
	ischildspecialneed bool NULL, 
	isparentlegalresponsible bool NULL, 
	isrenewalsigned bool NULL,
	isfinancialsupport bool NULL, 
	ischildenrolledschool bool NULL, 
	isdoumentationimmurization bool NULL, 
	ischildschoolemployeedisabled bool NULL,
	iscompletesecondaryeducation bool NULL,
	isenrolledinstitution bool NULL,
	isparticipatingemployement bool NULL,
	isemployeehrspermonth bool NULL,
	isincapableactivities bool NULL,
	adoptiveparentonedate timestamp NULL, 
	adoptiveparenttwodate timestamp NULL, 
	ldssdirectorsigndate timestamp NULL,
	disabilitynotes varchar(5000) NULL,
	notes varchar(5000) NULL,	
	activeflag int4 NULL DEFAULT 1, 
	effectivedate timestamp NOT NULL DEFAULT now(), 
	insertedby varchar(50) NULL, 
	insertedon timestamp NOT NULL DEFAULT now(), 
	updatedby varchar(50) NULL, 
	updatedon timestamp NOT NULL DEFAULT now(), 
	old_id varchar(50) NULL,
	CONSTRAINT adoptionannualreview_pkey PRIMARY KEY (adoptionannualreviewid),
	CONSTRAINT fk_adoptionannualreview_adoptioncase FOREIGN KEY (adoptioncaseid) REFERENCES adoptioncase(adoptioncaseid)
);

