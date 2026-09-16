DROP TABLE IF EXISTS expungementstatus;
CREATE TABLE expungementstatus (
	  expungementstatusid 	serial
	, jobid					int
	, rundate				date
	, status				character varying
	, starttime				timestamp
	, endtime				timestamp
	, expungscreenouts		json
	, expungmaltreatment	json
	, expunginvestigation	json
	, expungperson			json
);