-- Drop table

-- DROP TABLE cjams.programupdateresponse;

CREATE TABLE programupdateresponse 
(
	responseid			bigserial NOT NULL,
	triggerrequestid	bigint,
	responseerrorcode	character varying(4) NULL,
	responsemessage 	character varying(100) NULL,		
	responsemdmid		character varying(20) NULL,
	responsereturnstatus integer NULL,
	responsestatustext  character varying (100) NULL,
	insertedon  		timestamp NULL,
	updatedby			character varying(50) NULL,
	CONSTRAINT programupdateresponse_pkey PRIMARY KEY (responseid)
);
