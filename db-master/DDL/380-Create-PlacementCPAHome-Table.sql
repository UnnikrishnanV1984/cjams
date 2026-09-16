DROP TABLE IF EXISTS cjams.placementcpahomes;
CREATE TABLE cjams.placementcpahomes (
	placementcpahomeid uuid NOT NULL DEFAULT gen_random_uuid(),
	placementid uuid NULL,
	providerid uuid NULL,
	entrydt timestamp NULL,
	entrytm timestamp NULL,
	exitdt timestamp NULL,
	exittm timestamp NULL,
	exittypecd varchar(15) NULL,
	exitreasoncd varchar(15) NULL,
	commentstx varchar(500) NULL,
	createts timestamp NOT NULL DEFAULT now(),
	createuserid varchar(50) NOT NULL,
	updatets timestamp NOT NULL DEFAULT now(),
	updateuserid varchar(50) NOT NULL,
	activeflag int4 NULL DEFAULT 1,
	altproviderid int4 NULL,
	altplacementid int4 NULL,
	CONSTRAINT placementcpahomes_pk PRIMARY KEY (placementcpahomeid)
);

CREATE INDEX ix_placementcpahomes_altplacementid ON cjams.placementcpahomes USING btree (altplacementid);
CREATE INDEX ix_placementcpahomes_altproviderid ON cjams.placementcpahomes USING btree (altproviderid);
CREATE INDEX ix_placementcpahomes_exitdt ON cjams.placementcpahomes USING btree (exitdt);


