-- Drop table

-- DROP TABLE cjams.legislative;

CREATE TABLE cjams.legislative (
	legislativeid uuid NOT NULL DEFAULT gen_random_uuid(),
	intakeserviceid uuid NOT NULL,
	isapprovedsafec bool NULL,
	activeflag int4 NOT NULL DEFAULT 1,
	updatedby varchar(50) NULL,
	updatedon timestamp NOT NULL DEFAULT now(),
	insertedby varchar(50) NULL,
	insertedon timestamp NOT NULL DEFAULT now(),
	isinitialfacetoface bool NULL,
	isapprovedmfira bool NULL,
	isapprovecansf bool NULL,
	isvictimperpetrator bool NULL,
	isallpersons bool NULL,
	isallegedvicitm bool NULL,
	isemergency varchar(100) NULL,
	islegislativereporting varchar(100) NULL,
	isreasonnotprovided varchar(50) NULL,
	isdataentrynotes text NULL
);