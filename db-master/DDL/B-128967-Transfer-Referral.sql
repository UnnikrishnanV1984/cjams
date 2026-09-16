-- B-128967 - Transfer a Referral to Another Jurisdiction (CIDM-4372)


-- Drop table
DROP TABLE if exists cjams.intaketransfers;
	
CREATE TABLE cjams.intaketransfers (
	intaketransferid uuid not null default gen_random_uuid(),
	-- intakeserviceid uuid not null,
	intakenumber varchar(50) not null,
	transferdate timestamp null,
	sendingcountyid uuid null,
	receivingcountyid uuid null,
	requestedby uuid null, 
	approvedby uuid null, 
	receivingcountysupervisor uuid null,
	receivingcountyworker  uuid null,	
	transferreason text null,
	rejectionreason text null,
	approvalstatus varchar(50) null,
	approvedon timestamp null,
	insertedby varchar(50) null,
	insertedon timestamp null default now(),
	updatedby varchar(50) null,
	updatedon timestamp null default now(),
	activeflag int4 not null default 1,
	CONSTRAINT pk_intaketransfers PRIMARY KEY (intaketransferid)
);
CREATE INDEX intaketransfers_intake_idx ON cjams.intaketransfers USING btree (intakenumber);

/*
ALTER TABLE cjams.intaketransfers ADD CONSTRAINT fk_intakenumber
	FOREIGN KEY (intakenumber) REFERENCES cjams.intakedastaging(intakenumber);
*/