CREATE TABLE cjams.progressnotecomment (
	progressnotecommentid uuid NOT NULL DEFAULT gen_random_uuid(), -- Progress note detail (Primary key)
	progressnoteid uuid NOT NULL, -- Progress note id (foreign key)
	note text NOT NULL, -- Description of the notes
	activeflag int4 NOT NULL DEFAULT 1, -- Status of the record
	insertedby varchar(50) NULL, -- User who created this record
	insertedon timestamp NULL DEFAULT now(), -- Record created date and time
	updatedby varchar(50) NULL, -- user who last updated the record
	updatedon timestamp NULL DEFAULT now(), -- Record updated date and time	
	CONSTRAINT pk_progressnotecomment PRIMARY KEY (progressnotecommentid),
	CONSTRAINT fk_progressnotecomment_progressnote FOREIGN KEY (progressnoteid) REFERENCES progressnote(progressnoteid)
);