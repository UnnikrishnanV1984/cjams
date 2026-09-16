-- B-124608 Birth Match Identification (CIDM-4409)

-- Drop table
DROP TABLE if exists cjams.personbirthmatch;
	
CREATE TABLE cjams.personbirthmatch (
	personbirthmatchid uuid not null default gen_random_uuid(),
	personid uuid not null,
	birthmatchflag int4 null,
	notificationdate timestamp null,
	deselectreason text null,
	birthmatchupdatedon timestamp null DEFAULT now(),
	birthmatchlockdate timestamp null DEFAULT now() + interval '60 days', -- update with case clsoure ??
	caseclosedflag int4 null,
	objecttypekey varchar(50) NULL,
	objectid varchar(50) NULL,
	insertedby varchar(50) null,
	insertedon timestamp null default now(),
	updatedby varchar(50) null,
	updatedon timestamp null default now(),
	activeflag int4 not null default 1,
	nevershowagain boolean,
	CONSTRAINT pk_personbirthmatch PRIMARY KEY (personbirthmatchid)
);
CREATE INDEX personbirthmatch_person_idx ON cjams.personbirthmatch USING btree (personid);

ALTER TABLE cjams.personbirthmatch ADD CONSTRAINT fk_personid
	FOREIGN KEY (personid) REFERENCES cjams.person(personid);
