drop table if exists assessment_history;

CREATE TABLE IF NOT EXISTS cjams.assessment_history (
    assessmenthistoryid uuid NOT NULL DEFAULT gen_random_uuid(),
    modifieddata json,
    rowtype character varying(20),
    assessmentid uuid NOT NULL,
	assessmenttemplateid uuid NULL,
	personid uuid NULL,
	agencyid uuid NULL,
	securityusersid varchar(50) NOT NULL,
	assessmentstatustypekey varchar(50) NOT NULL,
	activeflag int4 NOT NULL DEFAULT 1,
	insertedby varchar(50) NOT NULL,
	insertedon timestamp NOT NULL DEFAULT now(),
	updatedby varchar(50) NOT NULL,
	updatedon timestamp NOT NULL DEFAULT now(),
	effectivedate timestamp NOT NULL DEFAULT now(),
	expirationdate timestamp NULL,
	"timestamp" bytea NULL,
	objectid uuid NULL,
	objectname varchar(100) NULL,
	disposition text NULL,
	executerules bool NULL DEFAULT false,
	requiredind bool NULL DEFAULT false,
	submissionid varchar(50) NULL,
	score int4 NULL,
	intakenumber varchar(50) NULL,
	submissiondata jsonb NULL,
	ischildsafe bool NULL DEFAULT false,
	old_id varchar(50) NULL,
	ismigrated int4 NULL DEFAULT 0,
	assessmentsubmissiontypekey varchar(50) NULL DEFAULT 'Submission'::character varying,
	intakeservicerequestactorid uuid NULL,
	servicecaseid uuid NULL,
	fromobjectid uuid NULL,
	legalincidentkey float8 NULL,
	mscaoffensecatgry float8 NULL,
	indoutcomecode varchar(4) NULL,
	etl_userid varchar(30) NULL,
	etl_load_date date NULL,
    actualdata json NULL,
    CONSTRAINT pk_assessment_history PRIMARY KEY (assessmenthistoryid),
	CONSTRAINT pk_assessment FOREIGN KEY (assessmentid) REFERENCES assessment(assessmentid),
	CONSTRAINT fk_assessment_assessmenttemplate FOREIGN KEY (assessmenttemplateid) REFERENCES assessmenttemplate(assessmenttemplateid)
);


comment on column cjams.assessment_history.assessmenthistoryid is 'Assessment infomation (PRIMARY KEY)';
comment on column cjams.assessment_history.assessmentid is 'Assessment infomation (FOREIGN KEY)';
comment on column cjams.assessment_history.assessmenttemplateid is 'Assessment infomation (FOREIGN KEY)';
comment on column cjams.assessment_history.personid is 'Person id  (FOREIGN KEY)';
comment on column cjams.assessment_history.agencyid is 'Agency id  (FOREIGN KEY)';
comment on column cjams.assessment_history.securityusersid is 'Security user';
comment on column cjams.assessment_history.assessmentstatustypekey is 'Assessment status type (FOREIGN KEY)';
comment on column cjams.assessment_history.objectid is 'Intakeservicerequest id';
comment on column cjams.assessment_history.objectname is 'Service request)';
comment on column cjams.assessment_history.submissionid is 'Submission id';
comment on column cjams.assessment_history.disposition is 'Disposition';
comment on column cjams.assessment_history.executerules is 'Execute Rules';
comment on column cjams.assessment_history.requiredind is 'Required ind';
comment on column cjams.assessment_history.intakenumber is 'Assessment infomation (PRIMARY KEY)';
comment on column cjams.assessment_history.submissiondata is 'Assessment infomation (PRIMARY KEY)';
comment on column cjams.assessment_history.rowtype is 'History or Current Info check';
comment on column cjams.assessment_history.ischildsafe is 'Child safe or not';
comment on column cjams.assessment_history.actualdata is 'Current Payload Information';
comment on column cjams.assessment_history.modifieddata is 'Modified Data Information';
comment on column cjams.assessment_history.submissiondata is 'Assessment Payload infomation';

