drop table if exists birthhealthinfo;
CREATE TABLE birthhealthinfo (
	birthhealthinfoid uuid NOT NULL DEFAULT gen_random_uuid(),
	personid uuid NOT NULL,
	mothersusepregnant varchar(100) NULL,
	mothersusepregnantspecify text NULL,
	mentalcondition varchar(100) NULL,
	mentalconditionspecify text NULL,
	diseasescondition varchar(100) NULL,
	diseasesconditionspecify text NULL,
	birthdefects text NULL,
	"comments" text NULL,
	activeflag int4 NULL DEFAULT 1,
	insertedby varchar(50) NULL,
	insertedon timestamp NOT NULL DEFAULT now(),
	updatedby varchar(50) NULL,
	updatedon timestamp NULL,
	effectivedate timestamp NOT NULL DEFAULT now(),
	expirationdate timestamp NULL,
	old_id varchar(50) NULL,
	CONSTRAINT birthhealthinfo_pkey PRIMARY KEY (birthhealthinfoid)
);

-- Drop table

-- DROP TABLE personhlthmobilityspeech;

CREATE TABLE personhlthmobilityspeech (
	personhlthmobilityspeechid uuid NOT NULL DEFAULT gen_random_uuid(),
	providedname varchar ,
	relationship varchar,
	ishousehold boolean,
	iscollateral boolean,
	ismbltyspchknown boolean,
	mbltyspch varchar,
	satupage integer,
	walkedage integer,
	talkedage integer,	
	insertedon timestamp NULL,
	insertedby varchar NULL,
	updatedon timestamp NULL,
	updatedby varchar NULL,
	activeflag int4 NOT NULL DEFAULT 1,
	"comments" varchar(500) NULL,
	personid uuid NULL
	);

-- DROP TABLE personhlthfeeding;

CREATE TABLE personhlthfeeding (
	personhlthfeedingid uuid NOT NULL DEFAULT gen_random_uuid(),
	providedname varchar ,
	relationship varchar,
	ishousehold boolean,
	iscollateral boolean,
	isfeedinginfoknown boolean,
	diettype varchar,
	eatertype varchar,
	liquids varchar,
	solidfood varchar,
	feeding_position varchar,
	otherneeds varchar,
	typeofformula varchar,
	amountperfeeding varchar,
	schedule varchar,	
	insertedon timestamp NULL,
	insertedby varchar NULL,
	updatedon timestamp NULL,
	updatedby varchar NULL,
	activeflag int4 NOT NULL DEFAULT 1,
	"comments" varchar(500) NULL,
	personid uuid NULL
	);