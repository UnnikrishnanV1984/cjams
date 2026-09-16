-- Drop table

-- DROP TABLE cjams.caregivernotify;

CREATE TABLE cjams.caregivernotify (
	caregivernotifyid uuid NOT NULL,
	notifydate date NULL,
	courtname varchar(100) NULL,
	countaddreslineone varchar NULL,
	countaddreslinetwo varchar NULL,
	city varchar NULL,
	state varchar NULL,
	zipcode varchar NULL,
	roomnumber varchar NULL,
	insertedby varchar(50) NULL,
	insertedon timestamp NULL DEFAULT now(),
	updatedby varchar(50) NULL,
	updatedon timestamp NULL DEFAULT now(),
	persons json NULL,
	cargivers bpchar(50) NULL,
	objecttypekey varchar(50) NULL,
	objectid varchar(50) NULL,
	activeflag int4 NULL,
	intakeservicerequestcourthearingid uuid NULL,
	caregiverid uuid NULL
);
