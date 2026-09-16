-- B-124608 Birth Match Identification (CIDM-4409)

-- Drop table
DROP TABLE if exists cjams.ivecsmsncpcasedetails;
	
CREATE TABLE IF not exists cjams.ivecsmsncpcasedetails (
	ivecsmsncpcasedetailsid uuid not null default gen_random_uuid(),
	clientid int8 NULL,
	removalid int8 NULL,
	csmsreferralid varchar(20) NULL,
	ncpclientid int8 NULL, 
	ncpcasenumber varchar(20) NULL,
	ncpcasecreationdate timestamp null,
	recievedpayload json NULL,
	insertedby varchar(50) null,
	insertedon timestamp null default now(),
	updatedby varchar(50) null,
	updatedon timestamp null default now(),
	activeflag int4 not null default 1,
	CONSTRAINT pk_ivecsmsncpcasedetails PRIMARY KEY (ivecsmsncpcasedetailsid)
);
CREATE INDEX xie1_ivecsmsncpcasedetails ON cjams.ivecsmsncpcasedetails USING btree (clientid, removalid);



COMMENT ON COLUMN cjams.ivecsmsncpcasedetails.ivecsmsncpcasedetailsid IS 'Primary Key of the table';
COMMENT ON COLUMN cjams.ivecsmsncpcasedetails.clientid IS 'Kids CJAMSPID';
COMMENT ON COLUMN cjams.ivecsmsncpcasedetails.removalid IS 'Children Removal ID details';
COMMENT ON COLUMN cjams.ivecsmsncpcasedetails.csmsreferralid IS 'Mapped to CSMS Referral ID';
COMMENT ON COLUMN cjams.ivecsmsncpcasedetails.ncpclientid IS 'Non custodial parent CJAMSPID';
COMMENT ON COLUMN cjams.ivecsmsncpcasedetails.ncpcasenumber IS 'Non custodial parent case number created by CSMS';
COMMENT ON COLUMN cjams.ivecsmsncpcasedetails.ncpcasecreationdate IS 'Non custodial parent case number created daTE';
COMMENT ON COLUMN cjams.ivecsmsncpcasedetails.recievedpayload IS 'recieved payload information from csms';