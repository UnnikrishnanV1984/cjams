drop table if exists cjams.expungement;
 
CREATE TABLE cjams.expungement (
	expungementid uuid NOT NULL DEFAULT gen_random_uuid(),
	investigationfindingid uuid NULL,
	isunsubstansiated bool NULL,
	isindicated bool NULL,
	isremovemaltreator bool NULL,
	donotexpunge bool NULL,
	manualexpunge bool NULL,
	unsubstansiateddate timestamp NULL,
	indicateddate timestamp NULL,
	removemaltreatordate timestamp NULL,
	investigationfinding varchar(50) NULL,
	appealfinding varchar(50) NULL,
	finalfinding varchar(50) NULL,
	resultoflawenforcement varchar(50) NULL,
	insertedon timestamp NULL,
	insertedby varchar(50) NULL,
	updatedon timestamp NULL,
	updatedby varchar(50) NULL,
	activeflag int4 NOT NULL DEFAULT 1
);
