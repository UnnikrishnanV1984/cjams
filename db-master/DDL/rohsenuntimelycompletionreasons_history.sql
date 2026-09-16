-- cjams.rohsenuntimelycompletionreasons_history definition

-- Drop table

-- DROP TABLE cjams.rohsenuntimelycompletionreasons_history;

CREATE TABLE cjams.rohsenuntimelycompletionreasons_history (
    rohsenuntimelycompletionreasonhistoryid uuid DEFAULT cjams.gen_random_uuid() NOT NULL,
    rowtype character varying(20),
    rohsenuntimelycompletionreasonid uuid, 
	servicecaseid uuid NULL,
    personid uuid NULL,
    startdate timestamp NULL,
	f2fcontactuntimelydone boolean NULL,
    f2fcontactuntimelydonereason varchar NULL,
    otherf2fcomments text NULL,
    progressnoteid uuid,
    safecuntimelydone boolean NULL,
    safecuntimelydonereason varchar NULL,
    othersafeccomments text NULL,
    safecassessmentid uuid,
    mfirauntimelydone boolean NULL,
    mfirauntimelydonereason varchar NULL,
    othermfiracomments text NULL,
    mfiraassessmentid uuid,
	insertedby varchar(50) NULL,
	insertedon timestamp DEFAULT now() NULL,
	updatedby varchar(50) NULL,
	updatedon timestamp DEFAULT now() NULL,
	activeflag int4 DEFAULT 1 NOT NULL,
    CONSTRAINT pk_rohsenuntimelycompletionreasons_history PRIMARY KEY (rohsenuntimelycompletionreasonhistoryid),
    CONSTRAINT fk_rohsenuntimelycompletionreasons_history FOREIGN KEY (rohsenuntimelycompletionreasonid) REFERENCES cjams.rohsenuntimelycompletionreasons(rohsenuntimelycompletionreasonid)
);