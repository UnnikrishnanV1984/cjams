-- cjams.cpsresponsetimeractions definition

-- Drop table

-- DROP TABLE cjams.cpsresponsetimeractions;

CREATE TABLE cjams.cpsresponsetimeractions (
	cpsresponsetimeractionsid uuid NOT NULL DEFAULT gen_random_uuid(),
	intakeserviceid uuid NULL,
	cpsresponsetimeractiontype varchar NULL,
	allegedvictimcontact varchar NULL,
	initialcaregivercontact varchar NULL,
	otherchildrencontact varchar NULL,
	insertedby varchar(50) NULL,
	insertedon timestamp NULL DEFAULT now(),
	updatedby varchar(50) NULL,
	updatedon timestamp NULL DEFAULT now(),
	activeflag int4 NOT NULL DEFAULT 1,
	isskipped bool NULL,
	cpsresponsetimerreason1 varchar NULL,
	cpsresponsetimerreason2 varchar NULL,
	cpsresponsetimerreason3 varchar NULL,
	cpsresponsetimerreason4 varchar NULL,
	cpsresponsetimerreason5 varchar NULL,
	cpsresponsetimerreason6 varchar NULL,
	cpsresponsetimerreason7 varchar NULL,
	cpsresponsetimerreason8 varchar NULL,
	cpsresponsetimerreason9 varchar NULL,
	caseworkercomments varchar NULL,
	supervisorcomments varchar NULL,
	CONSTRAINT pk_cpsresponsetimeractions PRIMARY KEY (cpsresponsetimeractionsid)
);
CREATE INDEX cpsresptmactions_intakeserviceid_idx ON cjams.cpsresponsetimeractions USING btree (intakeserviceid);

alter table cpsresponsetimeractions add column if not exists caseworkercomments character varying; 
alter table cpsresponsetimeractions add column if not exists supervisorcomments character varying;

COMMENT ON COLUMN cjams.cpsresponsetimeractions.caseworkercomments 
	IS 'Case worker''s comments for the Response Timer Save';
	
COMMENT ON COLUMN cjams.cpsresponsetimeractions.supervisorcomments 
	IS 'Supervisor''s comments for the Response Timer Save Approval/Rejection';

alter table cpsresponsetimeractions add column if not exists cpsresponsetimerreason1 character varying; 
alter table cpsresponsetimeractions add column if not exists cpsresponsetimerreason2 character varying;
alter table cpsresponsetimeractions add column if not exists cpsresponsetimerreason3 character varying;
alter table cpsresponsetimeractions add column if not exists cpsresponsetimerreason4 character varying; 
alter table cpsresponsetimeractions add column if not exists cpsresponsetimerreason5 character varying;
alter table cpsresponsetimeractions add column if not exists cpsresponsetimerreason6 character varying;
alter table cpsresponsetimeractions add column if not exists cpsresponsetimerreason7 character varying; 
alter table cpsresponsetimeractions add column if not exists cpsresponsetimerreason8 character varying;
alter table cpsresponsetimeractions add column if not exists cpsresponsetimerreason9 character varying;


COMMENT ON COLUMN cjams.cpsresponsetimeractions.cpsresponsetimerreason1 IS 'Skip Reason one for AllegedVictims';
COMMENT ON COLUMN cjams.cpsresponsetimeractions.cpsresponsetimerreason2 IS 'Skip Reason two for AllegedVictims';
COMMENT ON COLUMN cjams.cpsresponsetimeractions.cpsresponsetimerreason3 IS 'Skip Reason three for AllegedVictims';
COMMENT ON COLUMN cjams.cpsresponsetimeractions.cpsresponsetimerreason4 IS 'Skip Reason one for Otherchild';
COMMENT ON COLUMN cjams.cpsresponsetimeractions.cpsresponsetimerreason5 IS 'Skip Reason two for Otherchild';
COMMENT ON COLUMN cjams.cpsresponsetimeractions.cpsresponsetimerreason6 IS 'Skip Reason three for Otherchild';
COMMENT ON COLUMN cjams.cpsresponsetimeractions.cpsresponsetimerreason7 IS 'Skip Reason one for Initial Contact Caregiver';
COMMENT ON COLUMN cjams.cpsresponsetimeractions.cpsresponsetimerreason8 IS 'Skip Reason two for Initial Contact Caregiver';
COMMENT ON COLUMN cjams.cpsresponsetimeractions.cpsresponsetimerreason9 IS 'Skip Reason three for Initial Contact Caregiver';

alter table cpsresponsetimeractions add column if not exists cpsresponsetimerreason1 character varying; 
alter table cpsresponsetimeractions add column if not exists cpsresponsetimerreason2 character varying;
alter table cpsresponsetimeractions add column if not exists cpsresponsetimerreason3 character varying;
alter table cpsresponsetimeractions add column if not exists cpsresponsetimerreason4 character varying; 
alter table cpsresponsetimeractions add column if not exists cpsresponsetimerreason5 character varying;
alter table cpsresponsetimeractions add column if not exists cpsresponsetimerreason6 character varying;
alter table cpsresponsetimeractions add column if not exists cpsresponsetimerreason7 character varying; 
alter table cpsresponsetimeractions add column if not exists cpsresponsetimerreason8 character varying;
alter table cpsresponsetimeractions add column if not exists cpsresponsetimerreason9 character varying;

COMMENT ON COLUMN cjams.cpsresponsetimeractions.cpsresponsetimerreason1 IS 'Skip Reason one for AllegedVictims';
COMMENT ON COLUMN cjams.cpsresponsetimeractions.cpsresponsetimerreason2 IS 'Skip Reason two for AllegedVictims';
COMMENT ON COLUMN cjams.cpsresponsetimeractions.cpsresponsetimerreason3 IS 'Skip Reason three for AllegedVictims';
COMMENT ON COLUMN cjams.cpsresponsetimeractions.cpsresponsetimerreason4 IS 'Skip Reason one for Otherchild';
COMMENT ON COLUMN cjams.cpsresponsetimeractions.cpsresponsetimerreason5 IS 'Skip Reason two for Otherchild';
COMMENT ON COLUMN cjams.cpsresponsetimeractions.cpsresponsetimerreason6 IS 'Skip Reason three for Otherchild';
COMMENT ON COLUMN cjams.cpsresponsetimeractions.cpsresponsetimerreason7 IS 'Skip Reason one for Initial Contact Caregiver';
COMMENT ON COLUMN cjams.cpsresponsetimeractions.cpsresponsetimerreason8 IS 'Skip Reason two for Initial Contact Caregiver';
COMMENT ON COLUMN cjams.cpsresponsetimeractions.cpsresponsetimerreason9 IS 'Skip Reason three for Initial Contact Caregiver';